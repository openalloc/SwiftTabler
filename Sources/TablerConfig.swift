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

public enum TablerConfigDefaults {
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
    
    public static let rowSpacing: CGFloat = 0
    public static let paddingInsets = EdgeInsets()
    public static let alignment: HorizontalAlignment = .leading
    
    public static let rowColor: (Color, Color) = (.primary, .clear)
}

public struct TablerConfig<Element>
    where Element: Identifiable
{
    public typealias RowColor = (Color, Color)
    public typealias Filter = (Element) -> Bool
    public typealias OnRowColor = (Element) -> RowColor
    public typealias CanMove<Element> = (Element) -> Bool
    public typealias OnMove<Element> = (IndexSet, Int) -> Void

    // MARK: Parameters

    /// NOTE filtering not supported in Core Data-based tables, as it's assumed you'll use a predicate in your FetchRequest.
    public let filter: Filter?
    public let onRowColor: OnRowColor?
    public let canMove: CanMove<Element>
    public let onMove: OnMove<Element>?
    public let rowSpacing: CGFloat
    public let paddingInsets: EdgeInsets
    public let alignment: HorizontalAlignment
    public let sortIndicatorForward: AnyView
    public let sortIndicatorReverse: AnyView
    public let sortIndicatorNeutral: AnyView

    public init(filter: Filter? = nil,
                onRowColor: OnRowColor? = nil,
                canMove: @escaping CanMove<Element> = { _ in true },
                onMove: OnMove<Element>? = nil,
                rowSpacing: CGFloat = TablerConfigDefaults.rowSpacing,
                paddingInsets: EdgeInsets = TablerConfigDefaults.paddingInsets,
                alignment: HorizontalAlignment = TablerConfigDefaults.alignment,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.filter = filter
        self.onRowColor = onRowColor
        self.canMove = canMove
        self.onMove = onMove
        self.rowSpacing = rowSpacing
        self.paddingInsets = paddingInsets
        self.alignment = alignment
        self.sortIndicatorForward = sortIndicatorForward
        self.sortIndicatorReverse = sortIndicatorReverse
        self.sortIndicatorNeutral = sortIndicatorNeutral
    }
}
