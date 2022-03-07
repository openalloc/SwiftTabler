//
//  TablerConfig.swift
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

public enum TablerSpacedConfigDefaults {
    public static let headerSpacing: CGFloat = 0
    public static let rowSpacing: CGFloat = 0
}

public class TablerSpacedConfig<Element>: TablerConfig<Element>
where Element: Identifiable
{
    public let headerSpacing: CGFloat
    public let rowSpacing: CGFloat
    
    public init(headerSpacing: CGFloat = TablerSpacedConfigDefaults.headerSpacing,
                rowSpacing: CGFloat = TablerSpacedConfigDefaults.rowSpacing,
                filter: Filter? = nil,
                onHover: @escaping OnHover = { _,_ in },
                tablePadding: EdgeInsets = TablerConfigDefaults.tablePadding,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.headerSpacing = headerSpacing
        self.rowSpacing = rowSpacing
        
        super.init(filter: filter,
                   onHover: onHover,
                   tablePadding: tablePadding,
                   sortIndicatorForward: sortIndicatorForward,
                   sortIndicatorReverse: sortIndicatorReverse,
                   sortIndicatorNeutral: sortIndicatorNeutral)
    }
}
