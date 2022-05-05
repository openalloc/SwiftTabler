// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SwiftUI

extension TablerList1C {
    // omitting Header
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Results
        , selected: Binding<Selected>
                  )
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results
                  , selected: selected
                  )
    }

    // omitting Overlay
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground
        , results: Results
        , selected: Binding<Selected>
                  )
        where RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  , selected: selected
                  )

    }

    // omitting Background
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Results
        , selected: Binding<Selected>
                  )
        where RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results
                  , selected: selected
                  )
    }

    // omitting Header AND Overlay
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground
        , results: Results
        , selected: Binding<Selected>
                  )
        where Header == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  , selected: selected
                  )
    }

    // omitting Header AND Background
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Results
        , selected: Binding<Selected>
                  )
        where Header == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results
                  , selected: selected
                  )
    }

    // omitting Background AND Overlay
    init(_ config: Config,
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent
        , results: Results
        , selected: Binding<Selected>
                  )
        where RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  , selected: selected
                  )
    }

    // omitting Header, Background, AND Overlay
    init(_ config: Config,
         @ViewBuilder row: @escaping RowContent
        , results: Results
        , selected: Binding<Selected>
                  )

        where Header == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  , selected: selected
                  )
    }
}
