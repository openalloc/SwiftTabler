# SwiftTabler

A multi-platform SwiftUI component for tabular data.

**NOTE** <em>this component is BRAND NEW and under active development. If you need stability, you should fork, at least until the API has stabilized with version 1.x.x.</em>


Available as an open source library to be incorporated in SwiftUI apps.

_SwiftTabular_ is part of the [OpenAlloc](https://github.com/openalloc) family of open source Swift software tools.

macOS | iOS
:---:|:---:
![](https://github.com/openalloc/SwiftTabler/blob/main/Images/macOSa.png)  |  ![](https://github.com/openalloc/SwiftTabler/blob/main/Images/iOSa.png)

## Features

* Convenient display of tabular data from a `RandomAccessCollection` or Core Data source
* Presently targeting macOS v11+ and iOS v14+\*
* Supporting bound and unbound arrays, and Core Data too
* With bound data, add inline controls to interactively change (and mutate) your data model
* Optional sort-by-column support, with concise syntax
* Optional support for colored rows, with selection overlay
* MINIMAL use of View erasure (i.e., use of `AnyView`), which can impact scalability and performance\*\*
* No external dependencies!

For List-based tables:
* Optional moving of rows through drag and drop
* Support for no-select, single-select, and multi-select

For ScrollView/LazyVStack-based tables:
* Support for no-select and single-select (possibily multi-select in future)

For ScrollView/LazyVGrid-based tables:
* Likely the most scalable and efficient, but least flexible

On macOS:
* Hovering highlight, indicating which row the mouse is over

\* Other platforms like macCatalyst, iPad on Mac, watchOS, tvOS, etc. are poorly supported, if at all. Please contribute to improve support!

\*\* AnyView only used to specify sort configuration images in configuration, which shouldn't impact scalability.

## Tabler Example

The basic example below shows the display of tabular data using `TablerList`, which is for the display of unbound data without any selection capability.

```swift
import SwiftUI
import Tabler

struct Fruit: Identifiable {
    var id: String
    var name: String
    var weight: Double
    var color: Color
}

struct ContentView: View {

    @State private var fruits: [Fruit] = [
        Fruit(id: "🍌", name: "Banana", weight: 118, color: .brown),
        Fruit(id: "🍓", name: "Strawberry", weight: 12, color: .red),
        Fruit(id: "🍊", name: "Orange", weight: 190, color: .orange),
        Fruit(id: "🥝", name: "Kiwi", weight: 75, color: .green),
        Fruit(id: "🍇", name: "Grape", weight: 7, color: .purple),
        Fruit(id: "🫐", name: "Blueberry", weight: 2, color: .blue),
    ]
    
    private var gridItems: [GridItem] = [
        GridItem(.flexible(minimum: 35, maximum: 40), alignment: .leading),
        GridItem(.flexible(minimum: 100), alignment: .leading),
        GridItem(.flexible(minimum: 40, maximum: 80), alignment: .trailing),
        GridItem(.flexible(minimum: 35, maximum: 50), alignment: .leading),
    ]

    private typealias Context = TablerContext<Fruit>

    private func header(ctx: Binding<Context>) -> some View {
        LazyVGrid(columns: gridItems) {
            Text("ID")
            Text("Name")
            Text("Weight")
            Text("Color")
        }
    }
    
    private func row(element: Fruit) -> some View {
        LazyVGrid(columns: gridItems) {
            Text(element.id)
            Text(element.name).foregroundColor(element.color)
            Text(String(format: "%.0f g", element.weight))
            Image(systemName: "rectangle.fill").foregroundColor(element.color)
        }
    }

    var body: some View {
        TablerList(header: header,
                   row: row,
                   results: fruits)
    }
}
```

## Tables

You can choose from any of sixteen (16) variants, which break down along the following lines:

* Three foundations: List-based, ScrollView/LazyVStack-based, and ScrollView/LazyVGrid-based
* Selection types offered: none, single-select, and multi-select; availability depending on base
* RAC - usable with `RandomAccessCollection` (e.g., array of struct), with or without binding
* CD - usable with Core Data, with or without binding
* Filter - is `config.filter` supported?

Base   | Row Selection | RAC | CD  | Filter | View name     | Element wrapping  
---    | ---           | --- | --- | ---    | ---           | ---               
List   | No Select     |  ✓  |  ✓  |  ✓     | TablerList    | (none)            
List   | No Select     |  ✓  |     |  ✓     | TablerListB   | Binding\<Element> 
List   | No Select     |     |  ✓  |        | TablerListC   | ObservedObject    
List   | Single-select |  ✓  |  ✓  |  ✓     | TablerList1   | (none)            
List   | Single-select |  ✓  |     |  ✓     | TablerList1B  | Binding\<Element> 
List   | Single-Select |     |  ✓  |        | TablerList1C  | ObservedObject    
List   | Multi-select  |  ✓  |  ✓  |  ✓     | TablerListM   | (none)            
List   | Multi-select  |  ✓  |     |  ✓     | TablerListMB  | Binding\<Element> 
List   | Multi-select  |     |  ✓  |        | TablerListMC  | ObservedObject    
Stack  | No Select     |  ✓  |  ✓  |  ✓     | TablerStack   | (none)            
Stack  | No Select     |  ✓  |     |  ✓     | TablerStackB  | Binding\<Element> 
Stack  | No Select     |     |  ✓  |        | TablerStackC  | ObservedObject    
Stack  | Single-select |  ✓  |  ✓  |  ✓     | TablerStack1  | (none)            
Stack  | Single-select |  ✓  |     |  ✓     | TablerStack1B | Binding\<Element> 
Stack  | Single-select |     |  ✓  |        | TablerStack1C | ObservedObject    
Grid   | No Select     |  ✓  |  ✓  |  ✓     | TablerGrid    | (none)            
Grid   | No Select     |  ✓  |  ✓  |        | TablerGridB   | Binding\<Element       
Grid   | No Select     |  ✓  |  ✓  |        | TablerGridC   | ObservedObject           

## Column Sorting

Column sorting is available through `tablerSort` view function.

From the demo app, an example of using the sort capability, where an indicator displays in the header if the column is actively sorted: 

```swift
private typealias Context = TablerContext<Fruit>
private typealias Sort = TablerSort<Fruit>

private func header(ctx: Binding<Context>) -> some View {
    LazyVGrid(columns: gridItems) {
        Sort.columnTitle("ID", ctx, \.id)
            .onTapGesture { tablerSort(ctx, &fruits, \.id) { $0.id < $1.id } }
        Sort.columnTitle("Name", ctx, \.name)
            .onTapGesture { tablerSort(ctx, &fruits, \.name) { $0.name < $1.name } }
        Sort.columnTitle("Weight", ctx, \.weight)
            .onTapGesture { tablerSort(ctx, &fruits, \.weight) { $0.weight < $1.weight } }
        Text("Color")
    }
}
```

When the user clicks on a header column for the first time, it is sorted in ascending order, with an up-chevron "^" indicator. If clicked a successive time, a descending sort is executed, with a down-chevron "v" indicator. See `TablerConfig` for configuration.

For sorting with Core Data, see the _TablerCoreDemo_ app.

## Bound data

macOS | iOS
:---:|:---:
![](https://github.com/openalloc/SwiftTabler/blob/main/Images/macOSb.png)  |  ![](https://github.com/openalloc/SwiftTabler/blob/main/Images/iOSb.png)

When used with 'bound' variants (e.g., `TablerListB`), the data can be modified directly, mutating your data source. From the demo:

```swift
private func brow(element: Binding<Fruit>) -> some View {
    LazyVGrid(columns: gridItems) {
        Text(element.wrappedValue.id)
        TextField("Name", text: element.name)
            .textFieldStyle(.roundedBorder)
        Text(String(format: "%.0f g", element.wrappedValue.weight))
        ColorPicker("Color", selection: element.color)
            .labelsHidden()
    }
}
```

## Row Background

macOS | iOS
:---:|:---:
![](https://github.com/openalloc/SwiftTabler/blob/main/Images/macOSc.png)  |  ![](https://github.com/openalloc/SwiftTabler/blob/main/Images/iOSc.png)

```swift
var body: some View {
    TablerList(header: header,
               row: row,
               rowBackground: rowBackgroundAction,
               results: fruits)
}

private func rowBackgroundAction(fruit: Fruit) -> some View {
    LinearGradient(gradient: .init(colors: [fruit.color, fruit.color.opacity(0.2)]),
                   startPoint: .top, 
                   endPoint: .bottom)
}
```

Where you're using selection with colored rows, you may want to use a 'selection overlay', as the normal selection is obscured with colored rows. See _TablerDemo_ for examples.

Also, when using a row background on macOS, you might wish to disable the hover effect.

```swift
typealias Config = TablerListConfig<Fruit>

var body: some View {
    TablerList(Config(hoverColor: .clear),
               header: header,
               row: row,
               rowBackground: rowBackgroundAction,
               results: fruits)
}
```

## Headless Tables

Where you don't want a header, simply omit it from the declaration of the table:

```swift
var body: some View {
    TablerList(row: row,
               results: fruits)
}
```

## Moving Rows

TODO add details here, with example of move action handler.

## Horizontal Scrolling

On compact displays you may wish to scroll the table horizontally. _TablerDemo_ does this through a `ScrollView` wrapper:

```swift
public struct SidewaysScroller<Content: View>: View {
    var minWidth: CGFloat
    @ViewBuilder var content: () -> Content

    public init(minWidth: CGFloat,
                @ViewBuilder content: @escaping () -> Content)
    {
        self.minWidth = minWidth
        self.content = content
    }

    public var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    content()
                }
                .frame(minWidth: max(minWidth, geo.size.width))
            }
        }
    }
}
```

## See Also

* [TablerDemo](https://github.com/openalloc/TablerDemo) - the demonstration app for this library, for `RandomAccessCollection` data sources
* [TablerCoreDemo](https://github.com/openalloc/TablerCoreDemo) - the demonstration app for this library, for Core Data sources

Swift open-source libraries (by the same author):

* [SwiftDetailer](https://github.com/openalloc/SwiftDetailer) - multi-platform SwiftUI component for editing fielded data
* [SwiftDetailerMenu](https://github.com/openalloc/SwiftDetailerMenu) - optional menu support for _SwiftDetailer_
* [AllocData](https://github.com/openalloc/AllocData) - standardized data formats for investing-focused apps and tools
* [FINporter](https://github.com/openalloc/FINporter) - library and command-line tool to transform various specialized finance-related formats to the standardized schema of AllocData
* [SwiftCompactor](https://github.com/openalloc/SwiftCompactor) - formatters for the concise display of Numbers, Currency, and Time Intervals
* [SwiftModifiedDietz](https://github.com/openalloc/SwiftModifiedDietz) - A tool for calculating portfolio performance using the Modified Dietz method
* [SwiftNiceScale](https://github.com/openalloc/SwiftNiceScale) - generate 'nice' numbers for label ticks over a range, such as for y-axis on a chart
* [SwiftRegressor](https://github.com/openalloc/SwiftRegressor) - a linear regression tool that’s flexible and easy to use
* [SwiftSeriesResampler](https://github.com/openalloc/SwiftSeriesResampler) - transform a series of coordinate values into a new series with uniform intervals
* [SwiftSimpleTree](https://github.com/openalloc/SwiftSimpleTree) - a nested data structure that’s flexible and easy to use

And commercial apps using this library (by the same author):

* [FlowAllocator](https://flowallocator.app/FlowAllocator/index.html) - portfolio rebalancing tool for macOS
* [FlowWorth](https://flowallocator.app/FlowWorth/index.html) - a new portfolio performance and valuation tracking tool for macOS

## License

Copyright 2022 FlowAllocator LLC

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Contributing

Contributions are welcome. You are encouraged to submit pull requests to fix bugs, improve documentation, or offer new features. 

The pull request need not be a production-ready feature or fix. It can be a draft of proposed changes, or simply a test to show that expected behavior is buggy. Discussion on the pull request can proceed from there.
