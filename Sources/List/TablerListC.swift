//
//  TablerListC.swift
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
import CoreData

/// List-based table, with support for bound values through Core Data
public struct TablerListC<Element, Header, Row, RowMod>: View
where Element: Identifiable & NSFetchRequestResult & ObservableObject,
      Header: View,
      Row: View,
      RowMod: ViewModifier
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias ProjectedValue = ObservedObject<Element>.Wrapper
    public typealias RowContent = (ProjectedValue) -> Row
    public typealias RowModifier = (Element) -> RowMod
    public typealias Fetched = FetchedResults<Element>
    
    // MARK: Parameters
    
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let rowModifier: RowModifier
    private var results: Fetched
    
    public init(_ config: Config,
                @ViewBuilder headerContent: @escaping HeaderContent,
                @ViewBuilder rowContent: @escaping RowContent,
                rowModifier: @escaping RowModifier,
                results: Fetched)
    {
        self.headerContent = headerContent
        self.rowContent = rowContent
        self.rowModifier = rowModifier
        self.results = results
        _context = State(initialValue: TablerContext(config: config))
    }
    
    // MARK: Locals
    
    @State private var hovered: Hovered = nil
    @State private var context: Context
    
    // MARK: Views
    
    public var body: some View {
        BaseList(context: $context,
                 headerContent: headerContent) {
            ForEach(results) { rawElem in
                ObservableHolder(element: rawElem) { obsElem in
                    LazyVGrid(columns: config.gridItems,
                              alignment: config.alignment) {
                        rowContent(obsElem)
                    }
                    .modifier(ListRowMod(config, rawElem, $hovered))
                    .modifier(rowModifier(rawElem))
                }
            }
            .onMove(perform: config.onMove)
        }
    }
    
    private var config: Config {
        guard let c = context.config as? Config else { return Config(gridItems: []) }
        return c
    }
}

public extension TablerListC {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder rowContent: @escaping RowContent,
         rowModifier: @escaping RowModifier,
         results: Fetched)
        where Header == EmptyView
    {
        self.init(config,
                  headerContent: { _ in EmptyView() },
                  rowContent: rowContent,
                  rowModifier: rowModifier,
                  results: results)
    }
}
