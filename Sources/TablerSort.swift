//
//  TablerSort.swift
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

/// Convenience alias to hide the noise.
public typealias TablerSortContext<E> = Binding<TablerSort<E>?> where E: Identifiable

public struct TablerSort<Element>
where Element: Identifiable
{
    public enum Direction {
        case forward
        case reverse
        public static func otherDirection(_ direction: TablerSort.Direction) -> Direction {
            direction == .forward ? .reverse : .forward
        }
        
        var indicator: String {
            switch self {
            case .forward:
                return "▲"
            case .reverse:
                return "▼"
            }
        }
    }
    
    // MARK: Parameters
    
    public let anyKeyPath: AnyKeyPath
    public let direction: Direction
    
    public init(_ anyKeyPath: AnyKeyPath, _ ascending: Direction) {
        self.anyKeyPath = anyKeyPath
        direction = ascending
    }
    
    // MARK: Methods
    
    public static func indicator<E, T>(_ ctx: TablerSortContext<E>, _ keyPath: KeyPath<E, T>) -> String {
        indicator(ctx.wrappedValue, keyPath)
    }
    
    public static func indicator<E, T>(_ ctx: TablerSort<E>?, _ keyPath: KeyPath<E, T>) -> String {
        guard let _ctx = ctx,
              _ctx.anyKeyPath == keyPath else { return "" }
        return _ctx.direction.indicator
    }
}

public extension View {
    func tablerSort<Element, Results, T>(_ ctx: TablerSortContext<Element>,
                                         _ results: inout Results,
                                         _ keyPath: KeyPath<Element, T>,
                                         _ onSort: (Element, Element) -> Bool)
    where Results: RandomAccessCollection & MutableCollection,
          Results.Element == Element
    {
        // NOTE type-erase to track sort state
        let anyKeyPath: AnyKeyPath = keyPath
        
        let origDirection: TablerSort<Element>.Direction = {
            if anyKeyPath == ctx.wrappedValue?.anyKeyPath {
                return ctx.wrappedValue?.direction ?? .reverse
            }
            return .reverse
        }()
        
        let otherDirection = TablerSort<Element>.Direction.otherDirection(origDirection)
        
        // store the new direction for future header taps for the field
        ctx.wrappedValue = TablerSort(anyKeyPath, otherDirection)
        
        if otherDirection == .forward {
            results.sort(by: onSort)
        } else {
            results.sort(by: { !onSort($0, $1) })
        }
    }
}
