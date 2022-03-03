//
//  TablerListConfig.swift
//  
//
//  Created by Reed Esau on 3/3/22.
//

import SwiftUI

public class TablerListConfig<Element>: TablerConfig<Element>
where Element: Identifiable
{
    public typealias CanMove<Element> = (Element) -> Bool
    public typealias OnMove<Element> = (IndexSet, Int) -> Void

    public let canMove: CanMove<Element>
    public let onMove: OnMove<Element>?

    public init(canMove: @escaping CanMove<Element> = { _ in true },
                onMove: OnMove<Element>? = nil,
                filter: Filter? = nil,
                onRowColor: OnRowColor? = nil,
                sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward,
                sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse,
                sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral)
    {
        self.canMove = canMove
        self.onMove = onMove

        super.init(filter: filter,
                   onRowColor: onRowColor,
                   sortIndicatorForward: sortIndicatorForward,
                   sortIndicatorReverse: sortIndicatorReverse,
                   sortIndicatorNeutral: sortIndicatorNeutral)
    }
}
