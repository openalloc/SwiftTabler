//
//  TablerListO.swift
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

/// List-based table, with support for bound values
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct TablerListO<Element, Header, Row>: View
where Element: Identifiable & NSFetchRequestResult & ObservableObject,
      Header: View,
      Row: View
//,
//    Results: RandomAccessCollection,
//    Results.Element == Element,
//    Results.Index: Hashable
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias RowContent = (ObservedObject<Element>.Wrapper) -> Row
    
    // MARK: Parameters
    
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private var results: FetchedResults<Element>
    
    public init(_ config: Config,
                @ViewBuilder headerContent: @escaping HeaderContent,
                @ViewBuilder rowContent: @escaping RowContent,
                results: FetchedResults<Element>)
    {
        self.headerContent = headerContent
        self.rowContent = rowContent
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
            ForEach(results.filter(config.filter ?? { _ in true })) { element in
                BaseListRowO(config: config,
                             element: element,
                             hovered: $hovered) { e in
                    rowContent(e)
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

//@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
//public extension TablerListO {
//    // omitting Header
//    init(_ config: Config,
//         @ViewBuilder rowContent: @escaping RowContent,
//         results: Binding<Results>)
//        where Header == EmptyView
//    {
//        self.init(config,
//                  headerContent: { _ in EmptyView() },
//                  rowContent: rowContent,
//                  results: results)
//    }
//}
