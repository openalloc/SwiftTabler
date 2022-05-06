//
//  TablerStackConfig.swift
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

public enum TablerStackConfigDefaults {
#if os(macOS)
    public static let rowPadding = EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
#elseif os(iOS)
    public static let rowPadding = EdgeInsets(top: 11, leading: 0, bottom: 12, trailing: 0)
#endif
}

public class TablerStackConfig<Element>: TablerSpacedConfig<Element>
where Element: Identifiable
{
    public let rowPadding: EdgeInsets
    
    public init(rowPadding: EdgeInsets = TablerStackConfigDefaults.rowPadding,
                headerSpacing: CGFloat = TablerSpacedConfigDefaults.headerSpacing,
                footerSpacing: CGFloat = TablerSpacedConfigDefaults.footerSpacing,
                rowSpacing: CGFloat = TablerSpacedConfigDefaults.rowSpacing,
                headerFixed: Bool = TablerSpacedConfigDefaults.headerFixed,
                footerFixed: Bool = TablerSpacedConfigDefaults.footerFixed,
                filter: Filter? = nil,
                onHover: @escaping OnHover = { _,_ in },
                tablePadding: EdgeInsets = TablerSpacedConfigDefaults.tablePadding,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.rowPadding = rowPadding
        
        super.init(headerSpacing: headerSpacing,
                   footerSpacing: footerSpacing,
                   rowSpacing: rowSpacing,
                   headerFixed: headerFixed,
                   footerFixed: footerFixed,
                   filter: filter,
                   onHover: onHover,
                   tablePadding: tablePadding,
                   sortIndicatorForward: sortIndicatorForward,
                   sortIndicatorReverse: sortIndicatorReverse,
                   sortIndicatorNeutral: sortIndicatorNeutral)
    }
}
