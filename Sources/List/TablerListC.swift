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

import CoreData
import SwiftUI

/// List-based table, with support for bound values through Core Data
public struct TablerListC<Element, Header, Row>: View
    where Element: Identifiable & NSFetchRequestResult & ObservableObject,
    Header: View,
    Row: View
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias ProjectedValue = ObservedObject<Element>.Wrapper
    public typealias RowContent = (ProjectedValue) -> Row
    public typealias Fetched = FetchedResults<Element>

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private var results: Fetched

    public init(_ config: Config,
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                results: Fetched)
    {
        self.config = config
        self.headerContent = header
        self.rowContent = row
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
            ForEach(results) { rawElem in
                ObservableHolder(element: rawElem) { obsElem in
                    rowContent(obsElem)
                        .modifier(ListRowMod(config, rawElem, $hovered))
                }
            }
            .onMove(perform: config.onMove)
        }
    }
}

public extension TablerListC {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         results: Fetched)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  results: results)
    }
}
