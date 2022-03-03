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
    typealias Context = TablerContext<Element>

    // MARK: Parameters

    @Binding var context: Context
    @ViewBuilder var content: (Binding<Context>) -> Header

    init(context: Binding<Context>, content: @escaping (Binding<Context>) -> Header) {
        _context = context
        self.content = content
    }

    // MARK: Views

    var body: some View {
        content($context)
    }
}
