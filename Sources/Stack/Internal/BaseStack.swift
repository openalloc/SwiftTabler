//
//  BaseStack.swift
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

// Stack-based list
struct BaseStack<Element, Header, Footer, Rows>: View
    where Element: Identifiable,
    Header: View,
    Footer: View,
    Rows: View
{
    typealias Config = TablerStackConfig<Element>
    typealias Context = TablerContext<Element>
    typealias HeaderContent = (Binding<Context>) -> Header
    typealias FooterContent = (Binding<Context>) -> Footer
    typealias RowContent = () -> Rows

    @Binding var context: Context
    @ViewBuilder let header: HeaderContent
    @ViewBuilder let footer: FooterContent
    @ViewBuilder let rows: RowContent

    var body: some View {
        BaseTable(context: $context,
                  header: header,
                  footer: footer)
        { buildHeader, buildFooter in

            VStack(spacing: 0) {
//                if config.headerFixed {
                buildHeader()
                    .padding(.vertical, config.headerSpacing)
//                }

                ScrollView {
//                    if !config.headerFixed {
//                        buildHeader()
//                            .padding(.vertical, config.headerSpacing)
//                    }

                    LazyVStack(alignment: .leading, spacing: config.rowSpacing) {
                        rows()
                    }

//                    if !config.footerFixed {
//                        buildFooter()
//                            .padding(.vertical, config.footerSpacing)
//                    }
                }

//                if config.footerFixed {
                buildFooter()
                    .padding(.vertical, config.footerSpacing)
//                }
            }
        }
        .padding(config.tablePadding)
    }

    private var config: Config {
        context.config as? Config ?? Config()
    }
}
