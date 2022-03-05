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
    typealias Context = TablerContext<Element>
    typealias HeaderContent = (Binding<Context>) -> Header
    typealias RowContent = () -> Rows
    typealias Selected = Set<Element.ID>

    @Binding var context: Context
    let headerContent: HeaderContent
    @Binding var selected: Selected
    let rowsContent: RowContent

    init(context: Binding<Context>,
         selected: Binding<Selected>,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder rowsContent: @escaping RowContent)
    {
        _context = context
        _selected = selected
        headerContent = header
        self.rowsContent = rowsContent
    }

    var body: some View {
        BaseTable(context: $context,
                  header: headerContent) { buildHeader in
            List(selection: $selected) {
                buildHeader()
                rowsContent()
            }
            .padding(config.tablePadding)
        }
    }

    private var config: Config {
        context.config as? Config ?? Config()
    }
}
