//
//  BaseListRowO.swift
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

struct BaseListRowO<Element, Row>: View
where Element: Identifiable & ObservableObject,
      Row: View
{
    typealias Config = TablerListConfig<Element>
    typealias Hovered = Element.ID?
    typealias ProjectedValue = ObservedObject<Element>.Wrapper
    typealias RowContent = (ProjectedValue) -> Row
    
    // MARK: Parameters
    
    var config: Config
    @ObservedObject var element: Element
    @Binding var hovered: Hovered
    var rowContent: RowContent
    
    // MARK: Views
    
    var body: some View {
        let colorPair = config.onRowColor?(element) // NOTE okay if nil
        
        LazyVGrid(columns: config.gridItems,
                  alignment: config.alignment) {
            rowContent($element)
        }
        .moveDisabled(!config.canMove(element))
        
        .foregroundColor(colorPair?.0 ?? Color.primary)
        
#if os(macOS) || targetEnvironment(macCatalyst)
        // support hovering, but not for colored rows (yet)
        // no background for colored rows (yet)
        .onHover { if $0 { hovered = element.id } }
        .background((colorPair == nil && hovered == element.id)
                    ? Color.accentColor.opacity(0.2)
                    : Color.clear)
#endif
        
        .listRowBackground(colorPair?.1 ?? Color.clear)
    }
}
