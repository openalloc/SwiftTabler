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

public struct TablerConfigDefaults {
    public static let headerSpacing: CGFloat = 0
    public static let rowSpacing: CGFloat = 0
    public static let paddingInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    public static let alignment: HorizontalAlignment = .leading
    
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
    public typealias RowColor = (Color, Color)
    public typealias Filter = (Element) -> Bool
    public typealias OnRowColor = (Element) -> RowColor?

    public let DefaultRowColor: RowColor = (.primary, .clear)

    // MARK: Parameters

    public let gridItems: [GridItem]
    public let alignment: HorizontalAlignment
    
    /// NOTE filtering not supported in Core Data-based tables, as it's assumed you'll use a predicate in your FetchRequest.
    public let filter: Filter?
    public let onRowColor: OnRowColor?
    public let rowSpacing: CGFloat
    public let paddingInsets: EdgeInsets
    public let sortIndicatorForward: AnyView
    public let sortIndicatorReverse: AnyView
    public let sortIndicatorNeutral: AnyView

    public init(gridItems: [GridItem],
                alignment: HorizontalAlignment = TablerConfigDefaults.alignment,
                filter: Filter? = nil,
                onRowColor: OnRowColor? = nil,
                rowSpacing: CGFloat = TablerConfigDefaults.rowSpacing,
                paddingInsets: EdgeInsets = TablerConfigDefaults.paddingInsets,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.gridItems = gridItems
        self.alignment = alignment
        self.filter = filter
        self.onRowColor = onRowColor
        self.rowSpacing = rowSpacing
        self.paddingInsets = paddingInsets
        self.sortIndicatorForward = sortIndicatorForward
        self.sortIndicatorReverse = sortIndicatorReverse
        self.sortIndicatorNeutral = sortIndicatorNeutral
    }
}
