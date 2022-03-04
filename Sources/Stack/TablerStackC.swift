//
//  TablerStackC.swift
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

/// Stack-based table, with support for bound values
public struct TablerStackC<Element, Header, Row, RowBack>: View
    where Element: Identifiable & NSFetchRequestResult & ObservableObject,
    Header: View,
    Row: View
{
    public typealias Config = TablerStackConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias ProjectedValue = ObservedObject<Element>.Wrapper
    public typealias RowContent = (ProjectedValue) -> Row
    public typealias RowBackground = (Element) -> RowBack
    public typealias Fetched = FetchedResults<Element>

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let rowBackground: RowBackground
    private var results: Fetched

    public init(_ config: Config,
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                rowBackground: @escaping RowBackground,
                results: Fetched)
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
        BaseStack(context: $context,
                  header: headerContent) {
            ForEach(results) { rawElem in
                ObservableHolder(element: rawElem) { obsElem in
                    rowContent(obsElem)
                        .modifier(StackRowMod(config, rawElem, $hovered))
                }
            }
        }
    }
}

public extension TablerStackC {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         rowBackground: @escaping RowBackground,
         results: Fetched)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  results: results)
    }
}
