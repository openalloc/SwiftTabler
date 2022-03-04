//
//  StackRowMod1.swift
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

struct StackRowMod1<Element>: ViewModifier
where Element: Identifiable
{
    typealias Config = TablerStackConfig<Element>
    typealias Hovered = Element.ID?
    typealias Selected = Element.ID?
    
    let config: Config
    let element: Element
    @Binding var hovered: Hovered
    @Binding var selected: Selected
    
    init(_ config: Config,
         _ element: Element,
         _ hovered: Binding<Hovered>,
         _ selected: Binding<Selected>)
    {
        self.config = config
        self.element = element
        _hovered = hovered
        _selected = selected
    }
    
    func body(content: Content) -> some View {
        content
            .padding(config.rowPadding)
        
#if os(macOS) || targetEnvironment(macCatalyst)
        // NOTE keeping selection part of mac, as on iOS you press to get the context menu
            .contentShape(Rectangle())
            .onTapGesture {
                selectAction(element)
            }
#endif
        
#if os(macOS) || targetEnvironment(macCatalyst)
        // support hovering, but not for colored rows (yet)
        // no background for colored rows (yet)
            .onHover { if $0 { hovered = element.id } }
        
        // If hovering, set the background here.
            .background( // colorPair?.1 ?? (
                //            element.id == selected ? Color.accentColor : (
                hovered == element.id ? config.hoverColor : Color.clear
                //            )
            )
#endif
    }
    
    // MARK: Action Handlers
    
#if os(macOS) || targetEnvironment(macCatalyst)
    private func selectAction(_ element: Element) {
        selected = element.id
        // onSelect?(element)
    }
#endif
}
