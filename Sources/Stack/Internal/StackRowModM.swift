//
//  StackRowModM.swift
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

/// Support for multi-select Stack-based rows
struct StackRowModM<Element>: ViewModifier
where Element: Identifiable
{
    typealias Config = TablerStackConfig<Element>
    typealias Hovered = Element.ID?
    typealias Selected = Set<Element.ID>
    
    let config: Config
    let element: Element
    @Binding var selected: Selected
    
    func body(content: Content) -> some View {
        content
            .padding(config.rowPadding)
        
            // simple tap to select (or unselect)
            .contentShape(Rectangle())
            .onTapGesture {
                if selected.contains(element.id) {
                    selected.remove(element.id)
                } else {
                    selected.insert(element.id)
                }
            }
        
#if os(macOS) || targetEnvironment(macCatalyst)
            .onHover(perform: { config.onHover(element.id, $0) })
#endif
    }
}
