//
//  TablerList1C.swift
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

/// List-based table, with support for single-selection and bound values through Core Data
public struct TablerList1C<Element, Header, Row, RowBack, Select>: View
    where Element: Identifiable & NSFetchRequestResult & ObservableObject,
    Header: View,
    Row: View,
    RowBack: View,
    Select: View
{
    public typealias Config = TablerListConfig<Element>
    public typealias Context = TablerContext<Element>
    public typealias Hovered = Element.ID?
    public typealias HeaderContent = (Binding<Context>) -> Header
    public typealias ProjectedValue = ObservedObject<Element>.Wrapper
    public typealias RowContent = (ProjectedValue) -> Row
    public typealias RowBackground = (Element) -> RowBack
    public typealias SelectContent = (Bool) -> Select
    public typealias Selected = Element.ID?
    public typealias Fetched = FetchedResults<Element>

    // MARK: Parameters

    private let config: Config
    private let headerContent: HeaderContent
    private let rowContent: RowContent
    private let rowBackground: RowBackground
    private let selectContent: SelectContent
    private var results: Fetched
    @Binding private var selected: Selected

    public init(_ config: Config,
                @ViewBuilder header: @escaping HeaderContent,
                @ViewBuilder row: @escaping RowContent,
                @ViewBuilder rowBackground: @escaping RowBackground,
                @ViewBuilder selectOverlay: @escaping SelectContent,
                results: Fetched,
                selected: Binding<Selected>)
    {
        self.config = config
        headerContent = header
        rowContent = row
        self.rowBackground = rowBackground
        selectContent = selectOverlay
        self.results = results
        _selected = selected
        _context = State(initialValue: TablerContext(config))
    }

    // MARK: Locals

    @State private var hovered: Hovered = nil
    @State private var context: Context

    // MARK: Views

    public var body: some View {
        BaseList1(context: $context,
                  selected: $selected,
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

public extension TablerList1C {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder selectOverlay: @escaping SelectContent,
         results: Fetched,
         selected: Binding<Selected>)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  selectOverlay: selectOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Select
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Fetched,
         selected: Binding<Selected>)
        where Select == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: rowBackground,
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Background
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder selectOverlay: @escaping SelectContent,
         results: Fetched,
         selected: Binding<Selected>)
        where RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: selectOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Header AND Select
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Fetched,
         selected: Binding<Selected>)
        where Header == EmptyView, Select == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
    
    // omitting Header AND Background
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder selectOverlay: @escaping SelectContent,
         results: Fetched,
         selected: Binding<Selected>)
        where Header == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: selectOverlay,
                  results: results,
                  selected: selected)
    }
    
    // omitting Select AND Background
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         results: Fetched,
         selected: Binding<Selected>)
        where Select == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header, Select AND Background
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         results: Fetched,
         selected: Binding<Selected>)
        where Header == EmptyView, Select == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  selectOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
}
