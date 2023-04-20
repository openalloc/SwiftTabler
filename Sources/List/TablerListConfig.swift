//
//  TablerListConfig.swift
//
// Copyright 2021, 2022 OpenAlloc LLC
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

public class TablerListConfig<Element>: TablerConfig<Element>
    where Element: Identifiable
{
    public typealias CanMove<Element> = (Element) -> Bool
    public typealias OnMove<Element> = (IndexSet, Int) -> Void
    public typealias CanDelete<Element> = (Element) -> Bool
    public typealias OnDelete<Element> = (IndexSet) -> Void

    public let canMove: CanMove<Element>
    public let onMove: OnMove<Element>?
    public let canDelete: CanDelete<Element>
    public let onDelete: OnDelete<Element>?

    public init(canMove: @escaping CanMove<Element> = { _ in true },
                onMove: OnMove<Element>? = nil,
                canDelete: @escaping CanDelete<Element> = { _ in true },
                onDelete: OnDelete<Element>? = nil,
                filter: Filter? = nil,
                onHover: @escaping OnHover = { _, _ in },
                tablePadding: EdgeInsets = TablerConfigDefaults.tablePadding,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.canMove = canMove
        self.onMove = onMove
        self.canDelete = canDelete
        self.onDelete = onDelete

        super.init(filter: filter,
                   onHover: onHover,
                   tablePadding: tablePadding,
                   sortIndicatorForward: sortIndicatorForward,
                   sortIndicatorReverse: sortIndicatorReverse,
                   sortIndicatorNeutral: sortIndicatorNeutral)
    }
}
