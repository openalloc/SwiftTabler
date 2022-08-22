//
//  BaseList1.swift
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

// List with single-selection
struct BaseList1<Element, Header, Footer, Rows>: View
    where Element: Identifiable,
    Header: View,
    Footer: View,
    Rows: View
{
    typealias Config = TablerListConfig<Element>
    typealias Context = TablerContext<Element>
    typealias HeaderContent = (Binding<Context>) -> Header
    typealias FooterContent = (Binding<Context>) -> Footer
    typealias RowContent = () -> Rows
    typealias Selected = Element.ID?

    @Binding var context: Context
    @Binding var selected: Selected
    @ViewBuilder let header: HeaderContent
    @ViewBuilder let footer: FooterContent
    @ViewBuilder let rows: RowContent

    var body: some View {
        BaseTable(context: $context,
                  header: header,
                  footer: footer) { buildHeader, buildFooter in
            List(selection: $selected) {
                buildHeader()
                rows()
                buildFooter()
            }
        }
        .padding(config.tablePadding)
    }

    private var config: Config {
        context.config as? Config ?? Config()
    }
}
