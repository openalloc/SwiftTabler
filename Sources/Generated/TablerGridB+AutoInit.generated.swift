// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import SwiftUI

public extension TablerGridB {
    // omitting Header
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Binding<Results>
                  )
        where Header == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results
                  )
    }

    // omitting Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground
        , results: Binding<Results>
                  )
        where RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: footer,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )

    }

    // omitting Background
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Binding<Results>
                  )
        where RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results
                  )
    }

    // omitting Header AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground
        , results: Binding<Results>
                  )
        where Header == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )
    }

    // omitting Header AND Background
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Binding<Results>
                  )
        where Header == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results
                  )
    }

    // omitting Background AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent
        , results: Binding<Results>
                  )
        where RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )
    }

    // omitting Header, Background, AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder footer: @escaping FooterContent,
         @ViewBuilder row: @escaping RowContent
        , results: Binding<Results>
                  )

        where Header == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: footer,
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )
    }
    // omitting Footer
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Binding<Results>
                  )
        where Footer == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results
                  )
    }

    // omitting Header, Footer
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Binding<Results>
                  )
        where Header == EmptyView, Footer == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: rowOverlay,
                  results: results
                  )
    }

    // omitting Footer, Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground
        , results: Binding<Results>
                  )
        where Footer == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )

    }

    // omitting Footer, Background
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Binding<Results>
                  )
        where Footer == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results
                  )
    }

    // omitting Header, Footer AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowBackground: @escaping RowBackground
        , results: Binding<Results>
                  )
        where Header == EmptyView, Footer == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: rowBackground,
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )
    }

    // omitting Header, Footer AND Background
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent,
         @ViewBuilder rowOverlay: @escaping RowOverlay
        , results: Binding<Results>
                  )
        where Header == EmptyView, Footer == EmptyView, RowBack == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: rowOverlay,
                  results: results
                  )
    }

    // omitting Footer, Background AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder header: @escaping HeaderContent,
         @ViewBuilder row: @escaping RowContent
        , results: Binding<Results>
                  )
        where Footer == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: header,
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )
    }

    // omitting Header, Footer, Background, AND Overlay
    init(_ config: Config = .init(),
         @ViewBuilder row: @escaping RowContent
        , results: Binding<Results>
                  )

        where Header == EmptyView, Footer == EmptyView, RowBack == EmptyView, RowOver == EmptyView
    {
        self.init(config,
                  header: { _ in EmptyView() },
                  footer: { _ in EmptyView() },
                  row: row,
                  rowBackground: { _ in EmptyView() },
                  rowOverlay: { _ in EmptyView() },
                  results: results
                  )
    }
}
