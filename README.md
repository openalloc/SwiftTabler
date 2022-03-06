# SwiftTabler

A multi-platform SwiftUI component for tabular data.

Available as an open source library to be incorporated in SwiftUI apps.

_SwiftTabular_ is part of the [OpenAlloc](https://github.com/openalloc) family of open source Swift software tools.

macOS | iOS
:---:|:---:
![](https://github.com/openalloc/SwiftTabler/blob/main/Images/macOSa.png)  |  ![](https://github.com/openalloc/SwiftTabler/blob/main/Images/iOSa.png)

## Features

* Convenient display of tabular data from `RandomAccessCollection` data sources
* Presently targeting macOS v11+ and iOS v14+\*
* Supporting both value and reference semantics (including Core Data, which uses the latter)
* Option to support a bound data source, where inline controls can directly mutate your data model
* Option to sort by column, with indicators and concise syntax
* Option to specify a row background
* Option to specify a row overlay
* On macOS, option for a hovering highlight, to indicate which row the mouse is over
* MINIMAL use of View erasure (i.e., use of `AnyView`), which can impact scalability and performance\*\*
* No external dependencies!

Three table types are supported, as determined by the mechanism by which their header and rows are rendered.

### List
* Based on SwiftUI's `List`
* Option to support moving of rows through drag and drop
* Support for single-select, multi-select, or no selection at all

### Stack
* Based on `ScrollView`/`LazyVStack`
* Support for single-select and no selection at all

### Grid
* Based on `ScrollView`/`LazyVGrid`
* Likely the most scalable and efficient, but least flexible

\* Other platforms like macCatalyst, iPad on Mac, watchOS, tvOS, etc. are poorly supported, if at all. Please contribute to improve support!

\*\* AnyView only used to specify sort configuration images in configuration, which shouldn't impact scalability.

## Tabler Example

The example below shows the display of tabular data from an array of values using `TablerList`, a simple variant based on `List`.

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
    
    private func row(fruit: Fruit) -> some View {
        LazyVGrid(columns: gridItems) {
            Text(fruit.id)
            Text(fruit.name).foregroundColor(fruit.color)
            Text(String(format: "%.0f g", fruit.weight))
            Image(systemName: "rectangle.fill").foregroundColor(fruit.color)
        }
    }

    var body: some View {
        TablerList(header: header,
                   row: row,
                   results: fruits)
    }
}
```

While `LazyVGrid` is used here to wrap the header and row items, you could alternatively wrap them with `HStack` or similar mechanism.

## Tabler Views

_Tabler_ offers twenty-one (21) variants of table views from which you can choose. They break down along the following lines:

* Table View - the View name
* Type - each of the three table types differ in how they render:
  - **List** - based on `List`
  - **Stack** - based on `ScrollView`/`LazyVStack`
  - **Grid** - based on `ScrollView`/`LazyVGrid`
* Select - single-select, multi-select, or selection not supported
* Value - if checked, can be used with value types (e.g., struct values)
* Reference - if checked, can be used with reference types (e.g., class objects, Core Data, etc.)
* Filter - if checked, `config.filter` is supported (see caveat below)

Table View      | Type      | Select | Value | Reference | Filter
:---            | :---      | :---   | :---: | :---:     | :---:   
`TablerList`    | **List**  |        |  ✓    |  ✓        |  ✓     
`TablerListB`   | **List**  |        |  ✓    |           |  ✓\*  
`TablerListC`   | **List**  |        |       |  ✓        |         
`TablerList1`   | **List**  | Single |  ✓    |  ✓        |  ✓     
`TablerList1B`  | **List**  | Single |  ✓    |           |  ✓\*   
`TablerList1C`  | **List**  | Single |       |  ✓        |         
`TablerListM`   | **List**  | Multi  |  ✓    |  ✓        |  ✓     
`TablerListMB`  | **List**  | Multi  |  ✓    |           |  ✓\*   
`TablerListMC`  | **List**  | Multi  |       |  ✓        |         
`TablerStack`   | **Stack** |        |  ✓    |  ✓        |  ✓     
`TablerStackB`  | **Stack** |        |  ✓    |           |  ✓\*   
`TablerStackC`  | **Stack** |        |       |  ✓        |         
`TablerStack1`  | **Stack** | Single |  ✓    |  ✓        |  ✓     
`TablerStack1B` | **Stack** | Single |  ✓    |           |  ✓\*   
`TablerStack1C` | **Stack** | Single |       |  ✓        |         
`TablerGrid`    | **Grid**  |        |  ✓    |  ✓        |  ✓     
`TablerGridB`   | **Grid**  |        |  ✓    |           |              
`TablerGridC`   | **Grid**  |        |       |  ✓        |                
`TablerGrid1`   | **Grid**  | Single |  ✓    |  ✓        |  ✓     
`TablerGrid1B`  | **Grid**  | Single |  ✓    |           |              
`TablerGrid1C`  | **Grid**  | Single |       |  ✓        |                

\* filtering with bound values likely not scalable as implemented. If you can find a better way to implement, please submit a pull request!

## Column Sorting

Column sorting is available through the `tablerSort` view function.

The examples below show how the header items can support sort.

`.columnTitle()` is a convenience function that displays header name along with an indicator showing the current sort state, if any. Alternatively, build your own header and call the `.indicator()` method to get the active indicator image.  

Caret images are used by default for indicators, but are configurable (see Configuration section below).

### Random Access Collection

From the _TablerDemo_ app:

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

### Core Data

The sort method used with Core Data differs. From the _TablerCoreDemo_ app:

```swift
private typealias Context = TablerContext<Fruit>
private typealias Sort = TablerSort<Fruit>

private func header(ctx: Binding<Context>) -> some View {
    LazyVGrid(columns: gridItems, alignment: .leading) {
        Sort.columnTitle("ID", ctx, \.id)
            .onTapGesture { fruits.sortDescriptors = [tablerSort(ctx, \.id)] }
        Sort.columnTitle("Name", ctx, \.name)
            .onTapGesture { fruits.sortDescriptors = [tablerSort(ctx, \.name)] }
        Sort.columnTitle("Weight", ctx, \.weight)
            .onTapGesture { fruits.sortDescriptors = [tablerSort(ctx, \.weight)] }
    }
}
```

## Bound data

macOS | iOS
:---:|:---:
![](https://github.com/openalloc/SwiftTabler/blob/main/Images/macOSb.png)  |  ![](https://github.com/openalloc/SwiftTabler/blob/main/Images/iOSb.png)

When used with 'bound' views (e.g., `TablerListB` or `TablerListC`), the data can be modified directly, mutating your data source. From the demo:

```swift
private func brow(fruit: BoundValue) -> some View {
    LazyVGrid(columns: gridItems) {
        Text(fruit.wrappedValue.id)
        TextField("Name", text: fruit.name)
            .textFieldStyle(.roundedBorder)
        Text(String(format: "%.0f g", fruit.wrappedValue.weight))
        ColorPicker("Color", selection: fruit.color)
            .labelsHidden()
    }
}
```

For value sources, `BoundValue` is a binding:

```swift
typealias BoundValue = Binding<Fruit>
```

For reference sources, including Core Data, `BoundValue` is an object wrapper (aka 'ProjectedValue'):

```swift
typealias BoundValue = ObservedObject<Fruit>.Wrapper
```

Note that for Core Data, the user's changes will need to be saved to the Managed Object Context. See the _TablerCoreData_ code for an example of how this might be done.

## Row Background

You have the option to specify a row background, such as to impart information, or as a selection indicator.

Row Background, as the name suggests, sits BEHIND the row.

macOS | iOS
:---:|:---:
![](https://github.com/openalloc/SwiftTabler/blob/main/Images/macOSc.png)  |  ![](https://github.com/openalloc/SwiftTabler/blob/main/Images/iOSc.png)

An example of using row background to impart information, as shown above:

```swift
var body: some View {
    TablerList(header: header,
               row: row,
               rowBackground: rowBackground,
               results: fruits)
}

private func rowBackground(fruit: Fruit) -> some View {
    LinearGradient(gradient: .init(colors: [fruit.color, fruit.color.opacity(0.2)]),
                   startPoint: .top, 
                   endPoint: .bottom)
}
```

An example of a selection indicator using row background, such as for **Stack** based tables which do not have a native selection indicator:

```swift
@State private var selected: Fruit.ID? = nil

var body: some View {
    TablerStack1(header: header,
                 row: row,
                 rowBackground: rowBackground,
                 results: fruits,
                 selected: $selected)
}

private func rowBackground(fruit: Fruit) -> some View {
    RoundedRectangle(cornerRadius: 5)
        .fill(fruit.id == selected ? Color.accentColor : Color.clear)
}
```

## Row Overlay

Similar to a row background, an overlay can be used to impart information, or to use as a selection indicator.

Row overlay, as the name suggests, sits ATOP the row.

An example of a selection indicator using row overlay:

```swift
@State private var selected: Fruit.ID? = nil

var body: some View {
    TablerStack1(header: header,
                 row: row,
                 rowOverlay: rowOverlay,
                 results: fruits,
                 selected: $selected)
}

private func rowOverlay(fruit: Fruit) -> some View {
    RoundedRectangle(cornerRadius: 5)
        .strokeBorder(fruit.id == selected ? .white : .clear,
                      lineWidth: 2,
                      antialiased: true)
}
```

## Hover Effect

Available for macOS. It's enabled by default using the system's accent color.

When using a row background or overlay on macOS, you might wish to disable the hover effect.

```swift
var body: some View {
    TablerList(.init(hoverColor: .clear),
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

Row moving via drag and drop is available for the **List** based variants.

An example for use with Random Access Collections, as seen in _TablerDemo_:

```swift
var body: some View {
    TablerList(.init(onMove: moveAction),
               row: row,
               results: fruits)
}

private func moveAction(from source: IndexSet, to destination: Int) {
    fruits.move(fromOffsets: source, toOffset: destination)
}
```

TODO need Core Data example, if it's possible to do so.

## Configuration

Configuration options will vary by table type.

Defaults can vary by platform (macOS, iOS, etc.). See the code for specifics.

Spacing defaults are driven by the goal of achieving uniform appearance among table types, with the *List* type serving as the standard.

### Base Defaults

Base defaults are defined in the `TablerConfig` module.

- `hoverColor: Color` - accent color with opacity of 0.2
- `tablePadding: EdgeInsets` - no padding
- `sortIndicatorForward: AnyView` - "chevron.up" image
- `sortIndicatorReverse: AnyView` - "chevron.down" image
- `sortIndicatorNeutral: AnyView` - "chevron.up" image, with opacity of 0

### List

List configuration is optional.

`TablerListConfig<Element>.init` parameters:

- `canMove: CanMove<Element>` - with a default of `{ _ in true }`, allowing any row to move (if `onMove` defined)
- `onMove: OnMove<Element>?` - with a default of `nil`, prohibiting any move
- `filter: Filter?` - with a default of `nil`, indicating no filtering
- `hoverColor: Color` - per Base defaults
- `tablePadding: EdgeInsets` - per Base defaults
- `sortIndicatorForward: AnyView` - per Base defaults
- `sortIndicatorReverse: AnyView` - per Base defaults
- `sortIndicatorNeutral: AnyView` - per Base defaults

### Stack

Stack configuration is optional.

`TablerStackConfig<Element>.init` parameters:

- `rowPadding: EdgeInsets` - Stack-specific default, varies by platform
- `headerSpacing: CGFloat` - Stack-specific default, varies by platform
- `rowSpacing: CGFloat` - Stack-specific default, varies by platform
- `filter: Filter?` - with a default of `nil`, indicating no filtering
- `hoverColor: Color` - per Base defaults
- `tablePadding: EdgeInsets` - per Stack defaults
- `sortIndicatorForward: AnyView` - per Base defaults
- `sortIndicatorReverse: AnyView` - per Base defaults
- `sortIndicatorNeutral: AnyView` - per Base defaults

### Grid

Grid configuration is required, where you supply a `GridItem` array.

`TablerGridConfig<Element>.init` parameters:

- `gridItems: [GridItem]` - required
- `alignment: HorizontalAlignment` - `LazyVGrid` alignment, with a default of `.leading`
- `itemPadding: EdgeInsets` - with a default of `.init()`, indicating no padding
- `headerSpacing: CGFloat` - Grid-specific default, varies by platform
- `rowSpacing: CGFloat` - Grid-specific default, varies by platform
- `filter: Filter?` - with a default of `nil`, indicating no filtering
- `hoverColor: Color` - per Base defaults
- `tablePadding: EdgeInsets` - Grid-specific default, varies by platform
- `sortIndicatorForward: AnyView` - per Base defaults
- `sortIndicatorReverse: AnyView` - per Base defaults
- `sortIndicatorNeutral: AnyView` - per Base defaults

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
