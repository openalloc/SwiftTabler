//
//  TablerStackB.swift
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

/// Stack-based table, with support for bound values
public struct TablerStackB<Element, Header, Row, RowBack, Results>: View
    where Element: Identifiable,
    Header: View,
    Row: View,
    RowBack: View,
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

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let rowBackground: RowBackground
    @Binding private var results: Results

    public init(_ config: Config,
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                rowBackground: @escaping RowBackground,
                results: Binding<Results>)
    {
        self.config = config
        headerContent = header
        rowContent = row
        self.rowBackground = rowBackground
        _results = results
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
            .modifier(StackRowMod(config, element.wrappedValue, $hovered))
    }
}

public extension TablerStackB {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         rowBackground: @escaping RowBackground,
         results: Binding<Results>)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  results: results)
    }
}
