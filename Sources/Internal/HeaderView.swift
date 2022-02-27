//
//  HeaderView.swift
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

struct HeaderView<Element, Header>: View
    where Element: Identifiable,
    Header: View
{
    typealias Config = TablerConfig<Element>
    
    // MARK: Parameters

    var config: Config
    @ViewBuilder var content: (Binding<TablerSort<Element>?>) -> Header

    // MARK: Locals

    /// used to track most recent sorted field
    @State private var sort: TablerSort<Element>? = nil

    // MARK: Views

    var body: some View {
        LazyVGrid(columns: config.gridItems,
                  alignment: config.alignment) {
            content($sort)
        }
    }
}
