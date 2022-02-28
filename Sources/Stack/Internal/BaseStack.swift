//
//  BaseStack.swift
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

// Stack-based list
struct BaseStack<Element, Header, Rows>: View
    where Element: Identifiable,
    Header: View,
    Rows: View
{
    typealias Config = TablerStackConfig<Element>
    typealias Context = TablerContext<Element>
    typealias HeaderContent = (Binding<Context>) -> Header
    typealias RowContent = () -> Rows

    @Binding private var context: Context
    private let headerContent: HeaderContent
    private let rowsContent: RowContent

    init(context: Binding<Context>,
         @ViewBuilder headerContent: @escaping HeaderContent,
         @ViewBuilder rowsContent: @escaping RowContent) {
        _context = context
        self.headerContent = headerContent
        self.rowsContent = rowsContent
    }
    
    var body: some View {
        BaseTable(context: $context,
                  headerContent: headerContent) { buildHeader in

            VStack(spacing: config.rowSpacing) {
                buildHeader()

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: config.rowSpacing) {
                        rowsContent()
                    }
                }
            }
            .padding(config.paddingInsets)
        }
    }
     
    private var config: Config {
        guard let gridConfig = context.config as? Config else { return Config(gridItems: []) }
        return gridConfig
    }
}
