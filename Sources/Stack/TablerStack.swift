//
//  TablerStack.swift
//
// Copyright 2021, 2022 OpenAlloc LLC
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

// sourcery: AutoInit
/// Stack-based table
public struct TablerStack<Element, Header, Footer, Row, RowBack, RowOver, Results>: View
    where Element: Identifiable,
    Header: View,
    Footer: View,
    Row: View,
    RowBack: View,
    RowOver: View,
    Results: RandomAccessCollection,
    Results.Element == Element
{
    public typealias Config = TablerStackConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias FooterContent = (Binding<Context>) -> Footer
    public typealias RowContent = (Element) -> Row
    public typealias RowBackground = (Element) -> RowBack
    public typealias RowOverlay = (Element) -> RowOver

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let footerContent: FooterContent
    private let rowContent: RowContent
    private let rowBackground: RowBackground
    private let rowOverlay: RowOverlay
    private var results: Results

    public init(_ config: Config = .init(),
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder footer: @escaping FooterContent,
                @ViewBuilder row: @escaping RowContent,
                @ViewBuilder rowBackground: @escaping RowBackground,
                @ViewBuilder rowOverlay: @escaping RowOverlay,
                results: Results)    {
        self.config = config
        headerContent = header
        footerContent = footer
        rowContent = row
        self.rowBackground = rowBackground
        self.rowOverlay = rowOverlay
        self.results = results
        _context = State(initialValue: TablerContext(config))
    }

    // MARK: Locals

    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseStack(context: $context,
                  header: headerContent,
                  footer: footerContent) {
            ForEach(results.filter(config.filter ?? { _ in true })) { element in
                rowContent(element)
                    .modifier(StackRowMod(config: config, element: element))
                    .background(rowBackground(element))
                    .overlay(rowOverlay(element))
            }
        }
    }
}
