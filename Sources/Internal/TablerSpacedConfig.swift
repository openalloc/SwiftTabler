//
//  TablerSpacedConfig.swift
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
#if os(macOS)
    public static let headerSpacing: CGFloat = 4
    public static let footerSpacing: CGFloat = -4
    public static let tablePadding = EdgeInsets(top: 10, leading: 16, bottom: 15, trailing: 16)
#elseif os(iOS)
    public static let headerSpacing: CGFloat = 10
    public static let footerSpacing: CGFloat = 3
    public static let tablePadding = EdgeInsets(top: 36, leading: 32, bottom: 20, trailing: 32)
#endif

    public static let rowSpacing: CGFloat = 0

    public static let headerFixed: Bool = true
    public static let footerFixed: Bool = false
}

public class TablerSpacedConfig<Element>: TablerConfig<Element>
where Element: Identifiable
{
    public let headerSpacing: CGFloat
    public let footerSpacing: CGFloat
    public let rowSpacing: CGFloat
    public let headerFixed: Bool
    public let footerFixed: Bool
    
    public init(headerSpacing: CGFloat = TablerSpacedConfigDefaults.headerSpacing,
                footerSpacing: CGFloat = TablerSpacedConfigDefaults.footerSpacing,
                rowSpacing: CGFloat = TablerSpacedConfigDefaults.rowSpacing,
                headerFixed: Bool = TablerSpacedConfigDefaults.headerFixed,
                footerFixed: Bool = TablerSpacedConfigDefaults.footerFixed,
                filter: Filter? = nil,
                onHover: @escaping OnHover = { _,_ in },
                tablePadding: EdgeInsets = TablerConfigDefaults.tablePadding,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.headerSpacing = headerSpacing
        self.footerSpacing = footerSpacing
        self.rowSpacing = rowSpacing
        self.headerFixed = headerFixed
        self.footerFixed = footerFixed

        super.init(filter: filter,
                   onHover: onHover,
                   tablePadding: tablePadding,
                   sortIndicatorForward: sortIndicatorForward,
                   sortIndicatorReverse: sortIndicatorReverse,
                   sortIndicatorNeutral: sortIndicatorNeutral)
    }
}
