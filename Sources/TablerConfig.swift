//
//  TablerBaseConfig.swift
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

public enum TablerConfigDefaults {
    
    public static let hoverColor = Color.accentColor.opacity(0.2)
    
    public static let tablePadding: EdgeInsets = .init()

    public static let sortIndicatorForward = AnyView(
        Image(systemName: "chevron.up")
            .foregroundColor(.secondary)
    )
    public static let sortIndicatorReverse = AnyView(
        Image(systemName: "chevron.down")
            .foregroundColor(.secondary)
    )
    public static let sortIndicatorNeutral = AnyView(
        // The same width as the other two, to avoid title changing position as indicator changes.
        Image(systemName: "chevron.up")
            .opacity(0)
    )
}

open class TablerConfig<Element>
    where Element: Identifiable
{
    public typealias Filter = (Element) -> Bool

    public let filter: Filter?
    public let hoverColor: Color
    public let tablePadding: EdgeInsets

    public let sortIndicatorForward: AnyView
    public let sortIndicatorReverse: AnyView
    public let sortIndicatorNeutral: AnyView

    public init(filter: Filter? = nil,
                hoverColor: Color = TablerConfigDefaults.hoverColor,
                tablePadding: EdgeInsets = TablerConfigDefaults.tablePadding,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.filter = filter
        self.hoverColor = hoverColor
        self.tablePadding = tablePadding
        self.sortIndicatorForward = sortIndicatorForward
        self.sortIndicatorReverse = sortIndicatorReverse
        self.sortIndicatorNeutral = sortIndicatorNeutral
    }
}
