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
    // TODO: these values probably need to be tweaked to match the basic layout of `List`
    #if os(macOS)
        public static let rowSpacing: CGFloat = 8
        public static let paddingInsets = EdgeInsets(top: 14, leading: 16, bottom: 15, trailing: 16)
    #elseif os(iOS)
        public static let rowSpacing: CGFloat = 17
        public static let paddingInsets = EdgeInsets(top: 48, leading: 32, bottom: 20, trailing: 32)
    #endif

    public static let alignment: HorizontalAlignment = .leading
}

public class TablerGridConfig<Element>: TablerConfig<Element>
    where Element: Identifiable
{
    public var gridItems: [GridItem]
    public var alignment: HorizontalAlignment
    public var rowSpacing: CGFloat
    public var paddingInsets: EdgeInsets

    public init(gridItems: [GridItem] = [],
                alignment: HorizontalAlignment = TablerGridConfigDefaults.alignment,
                rowSpacing: CGFloat = TablerGridConfigDefaults.rowSpacing,
                paddingInsets: EdgeInsets = TablerGridConfigDefaults.paddingInsets,
                filter: Filter? = nil,
                onRowColor: OnRowColor? = nil,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.gridItems = gridItems
        self.alignment = alignment
        self.rowSpacing = rowSpacing
        self.paddingInsets = paddingInsets
        super.init(filter: filter,
                   onRowColor: onRowColor,
                   sortIndicatorForward: sortIndicatorForward,
                   sortIndicatorReverse: sortIndicatorReverse,
                   sortIndicatorNeutral: sortIndicatorNeutral)
    }
}
