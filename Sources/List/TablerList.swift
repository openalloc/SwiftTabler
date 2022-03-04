//
//  TablerList.swift
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

/// List-based table
public struct TablerList<Element, Header, RowBack, Row, Results>: View
    where Element: Identifiable,
    Header: View,
    Row: View,
    RowBack: View,
    Results: RandomAccessCollection,
    Results.Element == Element
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias RowContent = (Element) -> Row
    public typealias RowBackground = (Element) -> RowBack

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let rowBackground: RowBackground
    private var results: Results

    public init(_ config: Config,
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                rowBackground: @escaping RowBackground,
                results: Results)
    {
        self.config = config
        headerContent = header
        rowContent = row
        self.rowBackground = rowBackground
        self.results = results
        _context = State(initialValue: TablerContext(config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseList(context: $context,
                 header: headerContent) {
            ForEach(results.filter(config.filter ?? { _ in true })) { element in
                rowContent(element)
                    .modifier(ListRowMod(config, element, $hovered))
                    .listRowBackground(rowBackground(element))
            }
            .onMove(perform: config.onMove)
        }
    }
}

public extension TablerList {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         rowBackground: @escaping RowBackground,
         results: Results)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  results: results)
    }

    // omitting Background
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         results: Results)
        where RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  results: results)
    }

    // omitting Header AND Background
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         results: Results)
        where Header == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  results: results)
    }
}
