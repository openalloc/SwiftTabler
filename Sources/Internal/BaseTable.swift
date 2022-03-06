//
//  BaseTable.swift
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

struct BaseTable<Element, Header, Rows>: View
    where Element: Identifiable,
    Header: View,
    Rows: View
{
    typealias Context = TablerContext<Element>
    typealias HeaderContent = (Binding<Context>) -> Header
    typealias HeaderBuilder = () -> Header
    typealias TableBuilder = (@escaping HeaderBuilder) -> Rows

    // MARK: Parameters

    @Binding var context: Context
    let header: HeaderContent
    let tableBuilder: TableBuilder

    // MARK: Views

    var body: some View {
        tableBuilder {
            header($context)
        }
    }
}
