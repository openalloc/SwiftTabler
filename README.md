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
* Option to support a bound data source, where inline controls can directly mutate your data model
* Option to sort by column, with indicators and concise syntax
* Option to specify a row background, with selection overlay
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

While `LazyVGrid` is used to wrap the header and row items, you could alternatively wrap them with `HStack` or similar mechanism.

## Tabler Views

_Tabler_ offers eighteen (18) views from which you can choose. They break down along the following lines:

* Type - each of the three table types differ in how they render:
  * **List** - based on `List`
  * **Stack** - based on `ScrollView`/`LazyVStack`
  * **Grid** - based on `ScrollView`/`LazyVGrid`
* Select - single-select, multi-select, or selection not supported
* RAC - if checked, can be used with `RandomAccessCollection` (e.g., array of struct values)
* CD - if checked, can be used with Core Data
* Filter - if checked, `config.filter` is supported (see caveat below)
* Bound - the mechanism through which values are bound, if at all
* View - the name of the view

Type      | Select | RAC | CD  | Filter | Bound               | View      
---       | ---    | --- | --- | ---    | ---                 | ---           
**List**  |        |  ✓  |  ✓  |  ✓     |                     | `TablerList`    
**List**  |        |  ✓  |     |  ✓\*   | `Binding<Element>`  | `TablerListB` 
**List**  |        |     |  ✓  |        | `NSManagedObject`   | `TablerListC`    
**List**  | Single |  ✓  |  ✓  |  ✓     |                     | `TablerList1`   
**List**  | Single |  ✓  |     |  ✓\*   | `Binding<Element>`  | `TablerList1B`  
**List**  | Single |     |  ✓  |        | `NSManagedObject`   | `TablerList1C`   
**List**  | Multi  |  ✓  |  ✓  |  ✓     |                     | `TablerListM`   
**List**  | Multi  |  ✓  |     |  ✓\*   | `Binding<Element>`  | `TablerListMB`  
**List**  | Multi  |     |  ✓  |        | `NSManagedObject`   | `TablerListMC`   
**Stack** |        |  ✓  |  ✓  |  ✓     |                     | `TablerStack`   
**Stack** |        |  ✓  |     |  ✓\*   | `Binding<Element>`  | `TablerStackB`  
**Stack** |        |     |  ✓  |        | `NSManagedObject`   | `TablerStackC`   
**Stack** | Single |  ✓  |  ✓  |  ✓     |                     | `TablerStack1`  
**Stack** | Single |  ✓  |     |  ✓\*   | `Binding<Element>`  | `TablerStack1B` 
**Stack** | Single |     |  ✓  |        | `NSManagedObject`   | `TablerStack1C`  
**Grid**  |        |  ✓  |  ✓  |  ✓     |                     | `TablerGrid`    
**Grid**  |        |  ✓  |     |        | `Binding<Element>`  | `TablerGridB`         
**Grid**  |        |     |  ✓  |        | `NSManagedObject`   | `TablerGridC`           

\* filtering with Binding-based data likely not scalable as implemented. If you can find a better way to implement, submit a pull request!

## Configuration

Configuration options will vary by table type.

Defaults can vary by platform (macOS, iOS, etc.). See the code for the default constants.

Spacing defaults are driven by the goal of achieving uniform appearance among table types, with the *List* type being the standard.

### List

* canMove: @escaping CanMove\<Element> = { \_ in true }
* onMove: OnMove\<Element>? = nil
* filter: Filter? = nil
* hoverColor: Color = TablerConfigDefaults.hoverColor
* tablePadding: EdgeInsets = TablerConfigDefaults.tablePadding
* sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward
* sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse
* sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral

### Stack

* rowPadding: EdgeInsets =  TablerStackConfigDefaults.rowPadding
* headerSpacing: CGFloat = TablerStackConfigDefaults.headerSpacing
* rowSpacing: CGFloat = TablerStackConfigDefaults.rowSpacing
* filter: Filter? = nil
* hoverColor: Color = TablerConfigDefaults.hoverColor
* tablePadding: EdgeInsets = TablerStackConfigDefaults.tablePadding
* sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward
* sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse
* sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral

### Grid

* gridItems: [GridItem] = []
* alignment: HorizontalAlignment = TablerGridConfigDefaults.alignment
* itemPadding: EdgeInsets = TablerGridConfigDefaults.itemPadding
* headerSpacing: CGFloat = TablerGridConfigDefaults.headerSpacing
* rowSpacing: CGFloat = TablerGridConfigDefaults.rowSpacing
* filter: Filter? = nil
* hoverColor: Color = TablerConfigDefaults.hoverColor
* tablePadding: EdgeInsets = TablerGridConfigDefaults.tablePadding
* sortIndicatorForward: AnyView = TablerConfigDefaults.sortIndicatorForward
* sortIndicatorReverse: AnyView = TablerConfigDefaults.sortIndicatorReverse
* sortIndicatorNeutral: AnyView = TablerConfigDefaults.sortIndicatorNeutral

## Column Sorting

Column sorting is available through the `tablerSort` view function.

The examples below show how the header items can support sort.

`.columnTitle()` is a convenience function that displays header name along with an indicator showing the current sort state, if any. Alternatively, build your own header and call the `.indicator()` method to get the active indicator image.  

Caret images are used by default for indicators, but are configurable.

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
private func brow(element: BoundValue) -> some View {
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

### Random Access Collection

For Random Access Collection sources, `BoundValue` is:

```swift
typealias BoundValue = Binding<Fruit>
```

### Core Data

For Core Data sources, `BoundValue` is:

```swift
typealias BoundValue = ObservedObject<Fruit>.Wrapper
```

Also known as `ProjectedValue`.

Note that for Core Data, the user's changes will need to be saved to the Managed Object Context. See the _TablerCoreData_ code for an example of how this might be done.

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

Where you're using selection with row background, you may want to use a 'selection overlay', as the normal selection may be obscured. See _TablerDemo_ for examples.

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
