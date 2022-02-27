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
public struct TablerGrid<Element, Header, Row, Results>: View
    where Element: Identifiable,
    Header: View,
    Row: View,
    Results: RandomAccessCollection,
    Results.Element == Element
{
    public typealias Config = TablerGridConfig<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<TablerSort<Element>?>) -> Header
    public typealias RowContent = (Element) -> Row

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private var results: Results

    public init(_ config: Config,
                @ViewBuilder headerContent: @escaping HeaderContent,
                @ViewBuilder rowContent: @escaping RowContent,
                results: Results)
    {
        self.config = config
        self.headerContent = headerContent
        self.rowContent = rowContent
        self.results = results
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil

    // MARK: Views

    public var body: some View {
        BaseGrid(config: config,
                  headerContent: headerContent) {
            ForEach(results.filter(config.filter ?? { _ in true })) { element in
                BaseGridRow(config: config,
                             element: element,
                             hovered: $hovered) {
                    
                    // TODO how to provide a continuous hover block (selection, etc.)?
                    rowContent(element)
                }
            }
        }
    }
}

public extension TablerGrid {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder rowContent: @escaping RowContent,
         results: Results)
        where Header == EmptyView
    {
        self.init(config,
                  headerContent: { _ in EmptyView() },
                  rowContent: rowContent,
                  results: results)
    }
}
