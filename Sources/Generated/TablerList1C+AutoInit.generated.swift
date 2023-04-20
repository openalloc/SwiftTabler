// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SwiftUI

public extension TablerList1C {
    // omitting Header
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Results,
         selected: Binding<Selected>)
        where RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: footer,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Background
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Header AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header AND Background
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Background AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         results: Results,
         selected: Binding<Selected>)
        where RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header, Background, AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         results: Results,
         selected: Binding<Selected>)

        where Header == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Footer
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Footer == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Header, Footer
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, Footer == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Footer, Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Results,
         selected: Binding<Selected>)
        where Footer == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Footer, Background
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Footer == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Header, Footer AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, Footer == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header, Footer AND Background
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay,
         results: Results,
         selected: Binding<Selected>)
        where Header == EmptyView, Footer == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results,
                  selected: selected)
    }

    // omitting Footer, Background AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         results: Results,
         selected: Binding<Selected>)
        where Footer == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }

    // omitting Header, Footer, Background, AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent,
         results: Results,
         selected: Binding<Selected>)

        where Header == EmptyView, Footer == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results,
                  selected: selected)
    }
}
