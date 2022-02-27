//
//  BaseListM.swift
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

// List with multi selection
struct BaseListM<Element, Header, Rows>: View
    where Element: Identifiable,
    Header: View,
    Rows: View
{
    typealias Config = TablerListConfig<Element>
    typealias HeaderContent = (Binding<TablerSort<Element>?>) -> Header // (Binding<SwSort<Field>?>) -> Header
    typealias RowContent = () -> Rows
    typealias Selected = Set<Element.ID>

    let config: Config
    let headerContent: HeaderContent
    @Binding var selected: Selected
    @ViewBuilder var rowsContent: RowContent

    var body: some View {
        BaseTable(config: config,
                  headerContent: headerContent) { buildHeader in
            List(selection: $selected) {
                buildHeader()
                rowsContent()
            }
        }
    }
}
