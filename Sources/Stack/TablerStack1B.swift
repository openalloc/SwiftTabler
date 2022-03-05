//
//  TablerStack1B.swift
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

/// Stack-based table, with support for single-select and bound values from RandomAccessCollection
public struct TablerStack1B<Element, Header, Row, RowBack, Select, Results>: View
    where Element: Identifiable,
    Header: View,
    Row: View,
    RowBack: View,
    Select: View,
    Results: RandomAccessCollection & MutableCollection,
    Results.Element == Element,
    Results.Index: Hashable
{
    public typealias Config = TablerStackConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias RowContent = (Binding<Element>) -> Row
    public typealias RowBackground = (Element) -> RowBack
    public typealias SelectContent = (Bool) -> Select
    public typealias Selected = Element.ID?

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let rowBackground: RowBackground
    private let selectContent: SelectContent
    @Binding private var results: Results
    @Binding private var selected: Selected

    public init(_ config: Config = .init(),
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                @ViewBuilder rowBackground: @escaping RowBackground,
                @ViewBuilder selectOverlay: @escaping SelectContent,
                results: Binding<Results>,
                selected: Binding<Selected>)
    {
        self.config = config
        headerContent = header
        rowContent = row
        self.rowBackground = rowBackground
        selectContent = selectOverlay
        _results = results
        _selected = selected
        _context = State(initialValue: TablerContext(config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseStack(context: $context,
                  header: headerContent) {
            // TODO: is there a better way to filter bound data source?
            if let _filter = config.filter {
                ForEach($results) { $element in
                    if _filter(element) {
                        row($element)
                    }
                }
            } else {
                ForEach($results) { $element in
                    row($element)
                }
            }
        }
    }

    private func row(_ element: Binding<Element>) -> some View {
        rowContent(element)
            .modifier(StackRowMod1(config, element.wrappedValue, $hovered, $selected))
            .background(rowBackground(element.wrappedValue))
            .overlay(
                selectContent(element.wrappedValue.id == selected)
            )
    }
}

public extension TablerStack1B {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder selectOverlay: @escaping SelectContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  selectOverlay: selectOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Select
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Select == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: rowBackground,
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Background
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder selectOverlay: @escaping SelectContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: selectOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Header AND Select
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView, Select == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
    
    // omitting Header AND Background
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder selectOverlay: @escaping SelectContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: selectOverlay,
                  results: results,
                  selected: selected)
    }
    
    // omitting Background AND Select
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where RowBack == EmptyView, Select == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header, Background, AND Select
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         results: Binding<Results>,
         selected: Binding<Selected>)
        where Header == EmptyView, RowBack == EmptyView, Select == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
}
