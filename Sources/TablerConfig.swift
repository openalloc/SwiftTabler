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

open class TablerConfig<Element>
    where Element: Identifiable
{
    public typealias RowColor = (Color, Color)
    public typealias Filter = (Element) -> Bool
    public typealias OnRowColor = (Element) -> RowColor?

    public let DefaultRowColor: RowColor = (.primary, .clear)

    // MARK: Parameters

    public let filter: Filter?
    public let onRowColor: OnRowColor?

    public init(filter: Filter? = nil,
                onRowColor: OnRowColor? = nil)
    {
        self.filter = filter
        self.onRowColor = onRowColor
    }
}
