//
//  TablerGridConfig.swift
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

public enum TablerGridConfigDefaults {
    
    // TODO these values probably need to be tweaked to match the basic layout of `List`
#if os(macOS)
    public static let rowSpacing: CGFloat = 8
    public static let paddingInsets = EdgeInsets(top: 14, leading: 16, bottom: 15, trailing: 16)
#elseif os(iOS)
    public static let rowSpacing: CGFloat = 17
    public static let paddingInsets = EdgeInsets(top: 48, leading: 32, bottom: 20, trailing: 32)
#endif
}

public class TablerGridConfig<Element>: TablerConfig<Element>
where Element: Identifiable
{
    public override init(gridItems: [GridItem],
                         alignment: HorizontalAlignment = TablerConfigDefaults.alignment,
                         filter: Filter? = nil,
                         onRowColor: OnRowColor? = nil,
                         rowSpacing: CGFloat = TablerGridConfigDefaults.rowSpacing,
                         paddingInsets: EdgeInsets = TablerGridConfigDefaults.paddingInsets,
                         sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                         sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                         sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        super.init(gridItems: gridItems,
                   alignment: alignment,
                   filter: filter,
                   onRowColor: onRowColor,
                   rowSpacing: rowSpacing,
                   paddingInsets: paddingInsets,
                   sortIndicatorForward: sortIndicatorForward,
                   sortIndicatorReverse: sortIndicatorReverse,
                   sortIndicatorNeutral: sortIndicatorNeutral)
    }
}
