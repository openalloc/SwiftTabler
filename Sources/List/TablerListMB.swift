//
//  TablerListMB.swift
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

/// List-based table, with support for multi-select and bound values
public struct TablerListMB<Element, Header, Row, Select, Results>: View
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
    public typealias Selected = Set<Element.ID>

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let selectContent: SelectContent
    @Binding private var results: Results
    @Binding private var selected: Selected

    public init(_ config: Config,
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                @ViewBuilder selectOverlay: @escaping SelectContent,
                results: Binding<Results>,
                selected: Binding<Selected>)
    {
        self.config = config
        self.headerContent = header
        self.rowContent = row
        self.selectContent = selectOverlay
        _results = results
        _selected = selected
        _context = State(initialValue: TablerContext(config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseListM(context: $context,
                  selected: $selected,
                  header: headerContent) {
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
        rowContent(element)
            .modifier(ListRowMod(config, element.wrappedValue, $hovered))
            .overlay(
                selectContent(selected.contains(element.wrappedValue.id))
            )
    }
}

public extension TablerListMB {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder selectOverlay: @escaping SelectContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  selectOverlay: selectOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Select
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Select == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header AND Select
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView, Select == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
}
