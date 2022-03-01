//
//  TablerList1B.swift
//
// Copyright 2022 FlowAllocator LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

/// List-based table, with support for single-select and bound values
public struct TablerList1B<Element, Header, Row, Select, Results>: View
    where Element: Identifiable,
    Header: View,
    Row: View,
    Select: View,
    Results: RandomAccessCollection & MutableCollection,
    Results.Element == Element,
    Results.Index: Hashable
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias RowContent = (Binding<Element>) -> Row
    public typealias SelectContent = (Bool) -> Select
    public typealias Selected = Element.ID?

    // MARK: Parameters

    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let selectContent: SelectContent
    @Binding private var results: Results
    @Binding private var selected: Selected

    public init(_ config: Config,
                @ViewBuilder headerContent: @escaping HeaderContent,
                @ViewBuilder rowContent: @escaping RowContent,
                @ViewBuilder selectContent: @escaping SelectContent,
                results: Binding<Results>,
                selected: Binding<Selected>)
    {
        self.headerContent = headerContent
        self.rowContent = rowContent
        self.selectContent = selectContent
        _results = results
        _selected = selected
        _context = State(initialValue: TablerContext(config: config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseList1(context: $context,
                  selected: $selected,
                  headerContent: headerContent) {
            // TODO: is there a better way to filter bound data source?
            if let _filter = config.filter {
                ForEach($results) { $element in
                    if _filter(element) {
                        row($element)
                    }
                }
                .onMove(perform: config.onMove)
            } else {
                ForEach($results) { $element in
                    row($element)
                }
                .onMove(perform: config.onMove)
            }
        }
    }

    private func row(_ element: Binding<Element>) -> some View {
        BaseListRow(config: config,
                    element: element.wrappedValue,
                    hovered: $hovered) {
            rowContent(element)
                .overlay(
                    selectContent(element.wrappedValue.id == selected)
                )
        }
    }
    
    private var config: Config {
        guard let c = context.config as? Config else { return Config(gridItems: []) }
        return c
    }
}

public extension TablerList1B {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder rowContent: @escaping RowContent,
         @ViewBuilder selectContent: @escaping SelectContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView
    {
        self.init(config,
                  headerContent: { _ in EmptyView() },
                  rowContent: rowContent,
                  selectContent: selectContent,
                  results: results,
                  selected: selected)
    }

    // omitting Select
    init(_ config: Config,
         @ViewBuilder headerContent: @escaping HeaderContent,
         @ViewBuilder rowContent: @escaping RowContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Select == EmptyView
    {
        self.init(config,
                  headerContent: headerContent,
                  rowContent: rowContent,
                  selectContent: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header AND Select
    init(_ config: Config,
         @ViewBuilder rowContent: @escaping RowContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView, Select == EmptyView
    {
        self.init(config,
                  headerContent: { _ in EmptyView() },
                  rowContent: rowContent,
                  selectContent: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
}
