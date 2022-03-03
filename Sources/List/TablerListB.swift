//
//  TablerListB.swift
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

/// List-based table, with support for bound values
public struct TablerListB<Element, Header, Row, Results>: View
    where Element: Identifiable,
    Header: View,
    Row: View,
    Results: RandomAccessCollection & MutableCollection,
    Results.Element == Element,
    Results.Index: Hashable
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias RowContent = (Binding<Element>) -> Row

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    @Binding private var results: Results

    public init(_ config: Config,
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                results: Binding<Results>)
    {
        self.config = config
        self.headerContent = header
        self.rowContent = row
        _results = results
        _context = State(initialValue: TablerContext(config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseList(config: config,
                 context: $context,
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
    }
}

public extension TablerListB {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         results: Binding<Results>)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  results: results)
    }
}
