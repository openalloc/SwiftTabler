//
//  TablerListMC.swift
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

/// List-based table, with support for multi-selection and reference types
public struct TablerListMC<Element, Header, Row, RowBack, RowOver, Results>: View
    where Element: Identifiable & ObservableObject,
    Header: View,
    Row: View,
    RowBack: View,
    RowOver: View,
    Results: RandomAccessCollection,
    Results.Element == Element
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias ProjectedValue = ObservedObject<Element>.Wrapper
    public typealias RowContent = (ProjectedValue) -> Row
    public typealias RowBackground = (Element) -> RowBack
    public typealias RowOverlay = (Element) -> RowOver
    public typealias Selected = Set<Element.ID>

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let rowBackground: RowBackground
    private let rowOverlay: RowOverlay
    private var results: Results
    @Binding private var selected: Selected

    public init(_ config: Config = .init(),
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                @ViewBuilder rowBackground: @escaping RowBackground,
                @ViewBuilder rowOverlay: @escaping RowOverlay,
                results: Results,
                selected: Binding<Selected>)
    {
        self.config = config
        headerContent = header
        rowContent = row
        self.rowBackground = rowBackground
        self.rowOverlay = rowOverlay
        self.results = results
        _selected = selected
        _context = State(initialValue: TablerContext(config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseListM(context: $context,
                  selected: $selected,
                  header: headerContent) {
            ForEach(results) { rawElem in
                ObservableHolder(element: rawElem) { obsElem in
                    rowContent(obsElem)
                        .modifier(ListRowMod(config, rawElem, $hovered))
                        .listRowBackground(rowBackground(rawElem))
                }
            }
            .onMove(perform: config.onMove)
        }
    }
}

public extension TablerListMC {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Overlay
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Results,
         selected: Binding<Selected>)
        where RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Background
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Header AND Overlay
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
    
    // omitting Header AND Background
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }
    
    // omitting Background AND Overlay
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         results: Results,
         selected: Binding<Selected>)
        where RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header, Background, AND Overlay
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
}
