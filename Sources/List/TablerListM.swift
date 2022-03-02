//
//  TablerListM.swift
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

/// List-based table, with support for multi-select
public struct TablerListM<Element, Header, Row, Select, Results>: View
    where Element: Identifiable,
    Header: View,
    Row: View,
    Select: View,
    Results: RandomAccessCollection,
    Results.Element == Element
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias RowContent = (Element) -> Row
    public typealias SelectContent = (Bool) -> Select
    public typealias Selected = Set<Element.ID>

    // MARK: Parameters

    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let selectContent: SelectContent
    private var results: Results
    @Binding private var selected: Selected

    public init(_ config: Config,
                @ViewBuilder headerContent: @escaping HeaderContent,
                @ViewBuilder rowContent: @escaping RowContent,
                @ViewBuilder selectContent: @escaping SelectContent,
                results: Results,
                selected: Binding<Selected>)
    {
        self.headerContent = headerContent
        self.rowContent = rowContent
        self.selectContent = selectContent
        self.results = results
        _selected = selected
        _context = State(initialValue: TablerContext(config: config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseListM(context: $context,
                  selected: $selected,
                  headerContent: headerContent) {
            ForEach(results.filter(config.filter ?? { _ in true })) { element in
                rowContent(element)
                    .modifier(ListRowMod(config, element, $hovered))
                    .overlay(
                        selectContent(selected.contains(element.id))
                    )
            }
            .onMove(perform: config.onMove)
        }
    }

    private var config: Config {
        guard let c = context.config as? Config else { return Config() }
        return c
    }
}

public extension TablerListM {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder rowContent: @escaping RowContent,
         @ViewBuilder selectContent: @escaping SelectContent,
         results: Results,
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
         results: Results,
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
         results: Results,
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
