//
//  TablerGrid.swift
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

/// Grid-based table
public struct TablerGrid<Element, Header, Row, ItemMod, Results>: View
where Element: Identifiable,
      Header: View,
      Row: View,
      ItemMod: ViewModifier,
      Results: RandomAccessCollection,
      Results.Element == Element
{
    public typealias Config = TablerGridConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias RowContent = (Element) -> Row
    public typealias ItemModifier = (Element) -> ItemMod

    // MARK: Parameters
    
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let itemModifier: ItemModifier
    private var results: Results
    
    public init(_ config: Config,
                @ViewBuilder headerContent: @escaping HeaderContent,
                @ViewBuilder rowContent: @escaping RowContent,
                itemModifier: @escaping ItemModifier,
                results: Results)
    {
        self.headerContent = headerContent
        self.rowContent = rowContent
        self.itemModifier = itemModifier
        self.results = results
        _context = State(initialValue: TablerContext(config: config))
    }

    // MARK: Locals
    
    @State private var context: Context

    // MARK: Views
    
    public var body: some View {
        BaseGrid(context: $context,
                 headerContent: headerContent) {
            ForEach(results.filter(config.filter ?? { _ in true })) { element in
                rowContent(element)
                    .modifier(GridItemMod(config, element))
                    .modifier(itemModifier(element))
            }
        }
    }
    
    private var config: Config {
        guard let c = context.config as? Config else { return Config(gridItems: []) }
        return c
    }
}

public extension TablerGrid {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder rowContent: @escaping RowContent,
         itemModifier: @escaping ItemModifier,
         results: Results)
    where Header == EmptyView
    {
        self.init(config,
                  headerContent: { _ in EmptyView() },
                  rowContent: rowContent,
                  itemModifier: itemModifier,
                  results: results)
    }
}
