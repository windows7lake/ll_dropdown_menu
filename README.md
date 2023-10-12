# ll_dropdown_menu

[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/LICENSE)

[中文文档](https://github.com/windows7lake/ll_dropdown_menu/blob/main/README_CN.md)

Powerful and customizable drop-down menu component.

## Directory navigation

- [Features](#Features)
- [Demo](#Demo)
- [Install](#install)
- [Introduction](#Introduction)
- [Use](#Use)

## Features

* Support using `Stack` or `Overlay` to implement drop-down menu.
* Customize the drop-down menu bar header
* Customize the main content of the drop-down menu
* Control the display and hiding of drop-down menu
* Support use in `CustomScrollView` and `NestedScrollView`
* Basic drop-down menu implementation: `ListView`, `GridView`, `CascadeList`
* Support single and multiple selection operations
* Support update the text of drop-down menu button after selection

## Demo

* [Demo1](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo1.dart):
  Basic drop-down menu implementation: `ListView`, `GridView` (Overlay implementation)

* [Demo2](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo2.dart):
  Basic drop-down menu implementation: `ListView`, `GridView` (Stack implementation)

* [Demo3](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo3.dart):
  Customize the drop-down menu bar and content with `CascadeList`

* [Demo4](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo4.dart):
  Used in `CustomScrollView` with `SliverPersistentHeader`

<a target="_blank" rel="noopener noreferrer" href="https://github.com/windows7lake/ll_dropdown_menu/blob/main/preview/demo1.gif">
<img src="https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/preview/demo1.gif" width="250" height="500" align="center" style="max-width:100%;">
</a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/windows7lake/ll_dropdown_menu/blob/main/preview/demo3.gif">
<img src="https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/preview/demo3.gif" width="250" height="500" align="center" style="max-width:100%;">
</a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/windows7lake/ll_dropdown_menu/blob/main/preview/demo4.gif">
<img src="https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/preview/demo4.gif" width="250" height="500" align="center" style="max-width:100%;">
</a>

## Install

Add dependencies in `pubspec.yaml`:

```yaml
ll_dropdown_menu: ^0.1.0
```

Run in terminal:

```bash
$ flutter packages get
```

## Introduction

### DropdownMenuController

`DropdownMenuController` is the controller of the drop-down menu, used to control the display and
hiding of the drop-down menu.

```dart
void show(int index, {double? offsetY}); // Display drop-down menu body

void hide({int? index, String? text}); // Hide drop-down menu body

void toggle({int? index, String? text}); // Show or hide the drop-down menu body
```

The `index` parameter in the `show` method represents the index of the drop-down menu to be
displayed, and `offsetY` represents the Y-axis offset of the drop-down menu. <br><br>
The `index` parameter in the `hide` method indicates the index of the drop-down menu to be hidden,
and `text` indicates that the text of the drop-down button needs to be modified to be the selected
content when it is to be hidden.

### DropDownHeader

`DropDownHeader` is the head component of the drop-down menu, used to display the drop-down menu
bar.

Parameter Description:

```dart
final DropDownController controller; // Controller of the drop-down menu
final List<DropDownItem> items; // Data of the drop-down menu header component
final double? width; // Width of the drop-down menu header component
final double height; // Height of the drop-down menu header component
final Color backgroundColor; // Background color of the drop-down menu header component
final BoxBorder? border; // Border of the drop-down menu header component
final Decoration? decoration; // Decorator of the drop-down menu header component, used to set the background color, border, etc.
final EdgeInsetsGeometry margin; // Margin of the drop-down menu header component
final EdgeInsetsGeometry padding; // Padding of the drop-down menu header component
final bool expand; // Whether the drop-down menu header component fills the parent component
final TextStyle textStyle; // Text style of the drop-down menu header component
final TextStyle activeTextStyle; // Text style when the drop-down menu header component is selected
final double iconSize; // The icon size of the drop-down menu header component
final double activeIconSize; // The icon size when the drop-down menu header component is selected
final Color iconColor; // The icon color of the drop-down menu header component
final Color activeIconColor; // The color of the icon when the drop-down menu header component is selected
final Decoration? itemDecoration; // Decorator for the sub-items of the drop-down menu header component, used to set the background color, border, etc.
final Decoration? activeItemDecoration; // The decorator of the sub-item when the drop-down menu header component is selected, used to set the background color, border, etc.
final EdgeInsetsGeometry itemMargin; // Margins of the sub-items of the drop-down menu header component
final EdgeInsetsGeometry itemPadding; // Padding of the child items of the drop-down menu header component
final AlignmentGeometry itemAlignment; // Alignment of the sub-items of the drop-down menu header component
final NullableIndexedWidgetBuilder? itemBuilder; // Builder for the sub-items of the drop-down menu header component, used to customize Item
final IndexedWidgetBuilder? dividerBuilder; // Builder of the dividing line between the children of the drop-down menu header component, used to customize the dividing line
final OnDropDownHeaderItemTap? onItemTap; // Click event of the child item of the drop-down menu header component
```

### DropDownView

`DropDownView` is the main component of the drop-down menu and is used to display the contents of
the drop-down menu.

Parameter Description:

```dart
final DropDownController controller; // Controller of the drop-down menu
final List<DropDownViewBuilder> builders; // Data for the body component of the drop-down menu
final Color? viewColor; // Background color of the drop-down menu body component
final Color? maskColor; // Color of the mask layer of the drop-down menu
final Duration animationDuration; // Animation duration of the drop-down menu body component
final double offsetY; // Y-axis offset of the drop-down menu body component
```

### DropDownMenu

`DropDownMenu` is a drop-down menu component, which internally integrates the buttons and content
body of the drop-down menu, and controls the display and hiding of the content body through
Overlay. <br><br>
It is more flexible in layout, as long as the normal layout of components such as buttons is enough,
there is no need to consider the layout of the content body. The position of the content body is
controlled through the `viewOffsetY` parameter.

Parameter Description:

```dart
final DropDownController controller; // Controller of the drop-down menu
final List<DropDownItem> headerItems; // Data of the drop-down menu header component
final List<DropDownViewBuilder> viewBuilders; // Data of the body component of the drop-down menu
final DropDownDisposeController? disposeController; // The destruction controller of the drop-down menu, used to close the drop-down menu in advance when the page is destroyed
final double? headerWidth; // Width of the drop-down menu header component
final double headerHeight; // Height of the drop-down menu header component
final Color headerBackgroundColor; // The background color of the drop-down menu header component
final BoxBorder? headerBorder; // The border of the drop-down menu header component
final Decoration? headerDecoration; // The decorator of the drop-down menu header component, used to set the background color, border, etc.
final EdgeInsetsGeometry headerMargin; // Margins of the drop-down menu header component
final EdgeInsetsGeometry headerPadding; // Padding of the drop-down menu header component
final bool headerExpand; // Whether the drop-down menu header component fills the parent component
final TextStyle headerTextStyle; // Text style of the drop-down menu header component
final TextStyle headerActiveTextStyle; // Text style when the drop-down menu header component is selected
final double headerIconSize; // The icon size of the drop-down menu header component
final double headerActiveIconSize; // The icon size when the drop-down menu header component is selected
final Color headerIconColor; // The icon color of the drop-down menu header component
final Color headerActiveIconColor; // The icon color when the drop-down menu header component is selected
final Decoration? headerItemDecoration; // Decorator for the sub-items of the drop-down menu header component, used to set background color, borders, etc.
final Decoration? headerActiveItemDecoration; // The decorator of the child item when the drop-down menu header component is selected, used to set the background color, border, etc.
final EdgeInsetsGeometry headerItemMargin; // Margins of the sub-items of the drop-down menu header component
final EdgeInsetsGeometry headerItemPadding; // Padding of the sub-items of the drop-down menu header component
final AlignmentGeometry headerItemAlignment; // Alignment of the sub-items of the drop-down menu header component
final NullableIndexedWidgetBuilder? headerItemBuilder; // Builder for the sub-items of the drop-down menu header component, used to customize Item
final IndexedWidgetBuilder? headerDividerBuilder; // Builder of the dividing line between the children of the drop-down menu header component, used to customize the dividing line
final OnDropDownHeaderItemTap? onHeaderItemTap; // Click event of the child item of the drop-down menu header component
final Color? viewColor; // Background color of the drop-down menu body component
final Color? maskColor; // Color of the mask layer in body component of the drop-down menu
final Duration animationDuration; // Animation duration of the drop-down menu body component
final double? viewOffsetY; // Y-axis offset of the drop-down menu body component
```

### DropDownListView

`DropDownListView` is the basic implementation of the drop-down menu. It is implemented internally using `ListView` and supports single-selection and multi-selection operations.

Parameter Description:

```dart
final DropDownController controller; // Controller of the drop-down menu
final List<DropDownItem> items; // The data of the drop-down menu content body
final int? headerIndex; // Index of the drop-down menu header component
final double itemHeight; // The height of the child items of the drop-down menu content body
final TextStyle textStyle; // Text style of the sub-items of the drop-down menu content body
final TextStyle activeTextStyle; // Text style when the sub-item of the drop-down menu content body is selected
final Widget? icon; // The icon of the child item of the drop-down menu content body
final Widget? activeIcon; // The icon when the sub-item of the drop-down menu content body is selected
final double iconSize; // The icon size of the sub-items of the drop-down menu content body
final double activeIconSize; // The size of the icon when the sub-item of the drop-down menu content body is selected
final Color iconColor; // The icon color of the sub-items of the drop-down menu content body
final Color activeIconColor; // The color of the icon when the sub-item of the drop-down menu content body is selected
final Color itemBackgroundColor; // The background color of the child items of the drop-down menu content body
final Color itemActiveBackgroundColor; // The background color of the sub-item of the drop-down menu content body when it is selected
final BoxBorder? itemBorder; // The border of the child item of the drop-down menu content body
final BoxBorder? itemActiveBorder; // The border when the sub-item of the drop-down menu content body is selected
final Decoration? itemDecoration; // Decorator for the sub-items of the drop-down menu content body, used to set background color, borders, etc.
final Decoration? activeItemDecoration; // Decorator when the sub-item of the drop-down menu content body is selected, used to set the background color, border, etc.
final double itemBorderRadius; // The corner radius of the child items of the drop-down menu content body
final AlignmentGeometry itemAlignment; // Alignment of the sub-items of the drop-down menu content body
final EdgeInsetsGeometry? itemPadding; // Padding of the sub-items of the drop-down menu content body
final IndexedWidgetBuilder? itemBuilder; // Builder for the sub-items of the drop-down menu content body, used to customize Item
final OnDropDownItemTap? onDropDownItemTap; // Click event for the child item of the drop-down menu content body
final OnDropDownItemChanged? onDropDownItemChanged; // The selected state change event of the child item of the drop-down menu content body
final int? maxMultiChoiceSize; // The maximum number of multiple choices for the sub-items of the drop-down menu content body
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded; // Callback event triggered when the number of multiple selections for the sub-items of the drop-down menu content body exceeds the maximum value
final double? maxListHeight; // The maximum height of the drop-down menu content body
final bool multipleChoice; // Whether the content body of the drop-down menu supports multiple selections
final Widget? btnWidget; // Button component of the drop-down menu content body in the multi-select state
final Widget? resetWidget; // The reset button component of the drop-down menu content body in the multi-select state
final Widget? confirmWidget; // The confirmation button component of the drop-down menu content body in the multi-select state
final double resetHeight; // The height of the reset button component of the drop-down menu content body in the multi-select state
final double confirmHeight; // The height of the confirmation button component of the drop-down menu content body in the multi-select state
final String resetText; // The text of the reset button component of the drop-down menu content body in the multi-select state
final String confirmText; // The text of the confirmation button component of the drop-down menu content body in the multi-select state
final TextStyle resetTextStyle; // The text style of the reset button component of the drop-down menu content body in the multi-select state
final TextStyle confirmTextStyle; // The text style of the confirmation button component of the drop-down menu content body in the multi-select state
final Color resetBackgroundColor; // The background color of the reset button component of the drop-down menu content body in the multi-select state
final Color confirmBackgroundColor; // The background color of the confirmation button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsReset? onDropDownItemsReset; // The click event of the reset button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsConfirm? onDropDownItemsConfirm; // Click event of the confirmation button component of the drop-down menu content body in the multi-select state
// Callback event triggered after the drop-down menu selection is confirmed, used to update the text of the header component by the return value of the callback
// headerIndex should not be null when using this callback
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

### DropDownGridView

`DropDownGridView` is the basic implementation of the drop-down menu. It is implemented internally using `GridView` and supports single-selection and multi-selection operations.

Parameter Description:

```dart
final DropDownController controller; // Controller of the drop-down menu
final List<DropDownItem> items; // Data of the drop-down menu content body
final int? headerIndex; // Index of the drop-down menu header component
final EdgeInsetsGeometry? padding; // Padding of the drop-down menu content body
final int crossAxisCount; // The number of columns of the sub-items of the drop-down menu content body
final double mainAxisSpacing; // The line spacing of the sub-items of the drop-down menu content body
final double crossAxisSpacing; // Column spacing of the sub-items of the drop-down menu content body
final double itemHeight; // The height of the child items of the drop-down menu content body
final TextStyle textStyle; // Text style of the sub-items of the drop-down menu content body
final TextStyle activeTextStyle; // Text style when the sub-item of the drop-down menu content body is selected
final Widget? icon; // The icon of the child item of the drop-down menu content body
final Widget? activeIcon; // The icon when the sub-item of the drop-down menu content body is selected
final double iconSize; // The icon size of the sub-items of the drop-down menu content body
final double activeIconSize; // The size of the icon when the sub-item of the drop-down menu content body is selected
final Color iconColor; // The icon color of the sub-items of the drop-down menu content body
final Color activeIconColor; // The color of the icon when the sub-item of the drop-down menu content body is selected
final Color itemBackgroundColor; // The background color of the child items of the drop-down menu content body
final Color itemActiveBackgroundColor; // The background color of the sub-item of the drop-down menu content body when it is selected
final BoxBorder? itemBorder; // The border of the child item of the drop-down menu content body
final BoxBorder? itemActiveBorder; // The border when the sub-item of the drop-down menu content body is selected
final Decoration? itemDecoration; // Decorator for the sub-items of the drop-down menu content body, used to set background color, borders, etc.
final Decoration? activeItemDecoration; // Decorator when the sub-item of the drop-down menu content body is selected, used to set the background color, border, etc.
final double itemBorderRadius; // The corner radius of the child items of the drop-down menu content body
final AlignmentGeometry itemAlignment; // Alignment of the sub-items of the drop-down menu content body
final EdgeInsetsGeometry? itemPadding; // Padding of the sub-items of the drop-down menu content body
final IndexedWidgetBuilder? itemBuilder; // Builder for the sub-items of the drop-down menu content body, used to customize Item
final OnDropDownItemTap? onDropDownItemTap; // Click event for the child item of the drop-down menu content body
final OnDropDownItemChanged? onDropDownItemChanged; // The selected state change event of the child item of the drop-down menu content body
final int? maxMultiChoiceSize; // The maximum number of multiple choices for the sub-items of the drop-down menu content body
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded; // Callback event triggered when the number of multiple selections for the sub-items of the drop-down menu content body exceeds the maximum value
final double? maxListHeight; // The maximum height of the drop-down menu content body
final bool multipleChoice; // Whether the content body of the drop-down menu supports multiple selections
final Widget? btnWidget; // Button component of the drop-down menu content body in the multi-select state
final Widget? resetWidget; // The reset button component of the drop-down menu content body in the multi-select state
final Widget? confirmWidget; // The confirmation button component of the drop-down menu content body in the multi-select state
final double resetHeight; // The height of the reset button component of the drop-down menu content body in the multi-select state
final double confirmHeight; // The height of the confirmation button component of the drop-down menu content body in the multi-select state
final String resetText; // The text of the reset button component of the drop-down menu content body in the multi-select state
final String confirmText; // The text of the confirmation button component of the drop-down menu content body in the multi-select state
final TextStyle resetTextStyle; // The text style of the reset button component of the drop-down menu content body in the multi-select state
final TextStyle confirmTextStyle; // The text style of the confirmation button component of the drop-down menu content body in the multi-select state
final Color resetBackgroundColor; // The background color of the reset button component of the drop-down menu content body in the multi-select state
final Color confirmBackgroundColor; // The background color of the confirmation button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsReset? onDropDownItemsReset; // The click event of the reset button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsConfirm? onDropDownItemsConfirm; // Click event of the confirmation button component of the drop-down menu content body in the multi-select state
// Callback event triggered after the drop-down menu selection is confirmed, used to update the text of the header component by the return value of the callback
// headerIndex should not be null when using this callback
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

### DropDownCascadeList

`DropDownCascadeList` is the basic implementation of drop-down menu, cascading list, supporting single-selection and multi-selection operations.

Parameter Description:

```dart
final DropDownController controller; // Controller of the drop-down menu
final List<DropDownItem<List<DropDownItem>>> items; // The data of the drop-down menu content body
final int? headerIndex; // Index of the drop-down menu header component
final double firstFloorRatio; // The width ratio of the first level of the drop-down menu content body
final Color? firstFloorBackgroundColor; // The background color of the first level of the drop-down menu content body
final double firstFloorItemHeight; // The height of the first-level sub-items of the drop-down menu content body
final TextStyle firstFloorTextStyle; // The text style of the first-level sub-items of the drop-down menu content body
final TextStyle firstFloorActiveTextStyle; // Text style when the first-level sub-item of the drop-down menu content body is selected
final Color firstFloorItemBackgroundColor; // The background color of the first-level sub-items of the drop-down menu content body
final Color firstFloorItemActiveBackgroundColor; // The background color of the first-level sub-item of the drop-down menu content body when it is selected
final Decoration? firstFloorItemDecoration; // Decorator for the first-level sub-items of the drop-down menu content body, used to set background color, borders, etc.
final Decoration? firstFloorActiveItemDecoration; // Decorator when the first-level sub-item of the drop-down menu content body is selected, used to set the background color, border, etc.
final AlignmentGeometry firstFloorItemAlignment; // Alignment of the first-level sub-items of the drop-down menu content body
final EdgeInsetsGeometry? firstFloorItemPadding; // Padding of the first-level sub-items of the drop-down menu content body
final IndexedWidgetBuilder? firstFloorItemBuilder; // Builder for the first-level sub-items of the drop-down menu content body, used to customize Item
final OnDropDownItemTap? onFirstFloorItemTap; // Click event for the first-level sub-item of the drop-down menu content body
final Color? secondFloorBackgroundColor; // The background color of the second level of the drop-down menu content body
final double secondFloorItemHeight; // The height of the second-level sub-items of the drop-down menu content body
final TextStyle secondFloorTextStyle; // The text style of the second-level sub-items of the drop-down menu content body
final TextStyle secondFloorActiveTextStyle; // Text style when the second-level sub-item of the drop-down menu content body is selected
final Color secondFloorItemBackgroundColor; // The background color of the second-level sub-items of the drop-down menu content body
final Color secondFloorItemActiveBackgroundColor; // The background color when the second-level sub-item of the drop-down menu content body is selected
final Decoration? secondFloorItemDecoration; // Decorator for the second-level sub-items of the drop-down menu content body, used to set background color, borders, etc.
final Decoration? secondFloorActiveItemDecoration; // Decorator when the second-level sub-item of the drop-down menu content body is selected, used to set the background color, border, etc.
final Widget? secondFloorItemIcon; // The icon of the second-level sub-item of the drop-down menu content body
final Widget? secondFloorItemActiveIcon; // The icon when the second-level sub-item of the drop-down menu content body is selected
final double secondFloorItemIconSize; // The icon size of the second-level sub-items of the drop-down menu content body
final double secondFloorItemActiveIconSize; // The icon size when the second-level sub-item of the drop-down menu content body is selected
final Color secondFloorItemIconColor; // The icon color of the second-level sub-item of the drop-down menu content body
final Color secondFloorItemActiveIconColor; // The icon color when the second-level sub-item of the drop-down menu content body is selected
final AlignmentGeometry secondFloorItemAlignment; // Alignment of the second-level sub-items of the drop-down menu content body
final EdgeInsetsGeometry? secondFloorItemPadding; // Padding of the second-level sub-items of the drop-down menu content body
final IndexedWidgetBuilder? secondFloorItemBuilder; // Builder for the second-level sub-items of the drop-down menu content body, used to customize Item
final OnDropDownItemTap? onSecondFloorItemTap; // Click event for the second-level sub-item of the drop-down menu content body
final OnDropDownItemChanged? onSecondFloorItemChanged; // Selected state change event of the second-level sub-item of the drop-down menu content body
final int? maxMultiChoiceSize; // The maximum number of multiple choices for the second-level sub-items of the drop-down menu content body
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded; // Callback event triggered when the number of multiple selections for the second-level sub-items of the drop-down menu content body exceeds the maximum value
final double? maxListHeight; // The maximum height of the drop-down menu content body
final bool multipleChoice; // Whether the content body of the drop-down menu supports multiple selections
final Widget? btnWidget; // Button component of the drop-down menu content body in the multi-select state
final Widget? resetWidget; // The reset button component of the drop-down menu content body in the multi-select state
final Widget? confirmWidget; // The confirmation button component of the drop-down menu content body in the multi-select state
final double resetHeight; // The height of the reset button component of the drop-down menu content body in the multi-select state
final double confirmHeight; // The height of the confirmation button component of the drop-down menu content body in the multi-select state
final String resetText; // The text of the reset button component of the drop-down menu content body in the multi-select state
final String confirmText; // The text of the confirmation button component of the drop-down menu content body in the multi-select state
final TextStyle resetTextStyle; // The text style of the reset button component of the drop-down menu content body in the multi-select state
final TextStyle confirmTextStyle; // The text style of the confirmation button component of the drop-down menu content body in the multi-select state
final Color resetBackgroundColor; // The background color of the reset button component of the drop-down menu content body in the multi-select state
final Color confirmBackgroundColor; // The background color of the confirmation button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsReset? onDropDownItemsReset; // The click event of the reset button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsConfirm? onDropDownItemsConfirm; // Click event of the confirmation button component of the drop-down menu content body in the multi-select state
// Callback event triggered after the drop-down menu selection is confirmed, used to update the text of the header component by the return value of the callback
// headerIndex should not be null when using this callback
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

## Use

### Use `Overlay` to implement drop-down menu, [specific code](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo1.dart)

```dart
DropDownMenu(
  // Controller for drop-down menu
  controller: dropDownController,
  // Destruction controller of drop-down menu
  disposeController: dropDownDisposeController,
  // The head height of the drop-down menu
  headerHeight: 50,
  headerActiveIconColor: Colors.blue,
  headerActiveTextStyle: const TextStyle(color: Colors.blue),
  // Header data of drop-down menu
  headerItems: List.generate(
    4,
    (index) => DropDownItem<Tab>(
      text: "Tab $index",
      icon: const Icon(Icons.arrow_drop_down),
      activeIcon: const Icon(Icons.arrow_drop_up),
    ),
  ),
  // Y-axis offset of the main content of the drop-down menu
  viewOffsetY: MediaQuery.of(context).padding.top + 50,
  // The body content of the drop-down menu
  viewBuilders: [
    DropDownViewBuilder(
      height: 300,
      widget: DropDownListView(
        controller: dropDownController,
        headerIndex: 0,
        itemActiveBackgroundColor: Colors.blue.shade100,
        items: items,
        // to update the text of the header component by the return value of the callback
        // headerIndex should not be null when using this callback
        onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
          return checkedItems.map((e) => e.text).toList().join("、");
        },
      ),
    ),
    DropDownViewBuilder(
      height: 300,
      widget: DropDownListView(
        controller: dropDownController,
        headerIndex: 1,
        items: items,
        multipleChoice: true,
        maxMultiChoiceSize: 2,
        onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
          return checkedItems.map((e) => e.text).toList().join("、");
        },
      ),
    ),
    DropDownViewBuilder(
      height: 300,
      widget: DropDownGridView(
        controller: dropDownController,
        headerIndex: 2,
        crossAxisCount: 3,
        items: items,
        onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
          return checkedItems.map((e) => e.text).toList().join("、");
        },
      ),
    ),
    DropDownViewBuilder(
      height: 310,
      widget: DropDownGridView(
        controller: dropDownController,
        headerIndex: 3,
        crossAxisCount: 3,
        items: items,
        multipleChoice: true,
        maxMultiChoiceSize: 2,
        onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
          return checkedItems.map((e) => e.text).toList().join("、");
        },
      ),
    ),
  ],
),
```

### Use `Stack` to implement drop-down menu, [specific code](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo2.dart)

```dart
Column(children: [
  DropDownHeader(
    controller: dropDownController,
    height: 50,
    activeIconColor: Colors.blue,
    activeTextStyle: const TextStyle(color: Colors.blue),
    items: List.generate(
      4,
      (index) => DropDownItem<Tab>(
        text: "Tab $index",
        icon: const Icon(Icons.arrow_drop_down),
        activeIcon: const Icon(Icons.arrow_drop_up),
      ),
    ),
  ),
  Expanded(
    child: Stack(
      children: [
        Container(
          color: Colors.blue[200],
        ),
        DropDownView(
          controller: dropDownController,
          builders: [
            DropDownViewBuilder(
              height: 300,
              widget: DropDownListView(
                headerIndex: 0,
                controller: dropDownController,
                itemActiveBackgroundColor: Colors.blue.shade100,
                items: List.generate(
                  6,
                  (index) => DropDownItem(
                    text: "Single Item $index",
                    data: index,
                  ),
                ),
              ),
            ),
            DropDownViewBuilder(
              height: 300,
              widget: DropDownListView(
                controller: dropDownController,
                items: List.generate(
                  8,
                  (index) => DropDownItem(
                    text: "Multi Item $index",
                    data: index,
                  ),
                ),
                multipleChoice: true,
                maxMultiChoiceSize: 2,
              ),
            ),
            DropDownViewBuilder(
              height: 300,
              widget: DropDownGridView(
                crossAxisCount: 3,
                controller: dropDownController,
                items: List.generate(
                  10,
                  (index) => DropDownItem(
                    text: "Single Item $index",
                    icon: const Icon(Icons.ac_unit),
                    activeIcon: const Icon(
                      Icons.ac_unit,
                      color: Colors.white,
                    ),
                    data: index,
                  ),
                ),
              ),
            ),
            DropDownViewBuilder(
              height: 310,
              widget: DropDownGridView(
                crossAxisCount: 3,
                controller: dropDownController,
                items: List.generate(
                  12,
                  (index) => DropDownItem(
                    text: "Multi Item $index",
                    data: index,
                  ),
                ),
                multipleChoice: true,
                maxMultiChoiceSize: 2,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
]),
```

## Used in `CustomScrollView`, [specific code](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo4.dart)

Variable declaration:

```dart 
final GlobalKey dropDownMenuKey = GlobalKey();
final dropDownMenuHeight = 50.0;

double get dropDownViewOffsetY {
  RenderBox? renderBox = dropDownMenuKey.renderObject as RenderBox?;
  if (renderBox == null) return 0;
  double dy = renderBox.localToGlobal(Offset.zero).dy;
  return dy;
}
```

Overlay implementation:

```dart
Widget usingOverlay() {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 100,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text(
            "Using Overlay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverPersistentHeaderBuilder(
          height: dropDownMenuHeight,
          builder: (context, offset) {
            return DropDownMenu(
              key: dropDownMenuKey,
              controller: dropDownController,
              disposeController: dropDownDisposeController,
              headerHeight: dropDownMenuHeight,
              headerBackgroundColor: Colors.white,
              headerActiveIconColor: Colors.blue,
              headerActiveTextStyle: const TextStyle(color: Colors.blue),
              headerItems: List.generate(
                4,
                (index) => DropDownItem<Tab>(
                  text: "Tab $index",
                  icon: const Icon(Icons.arrow_drop_down),
                  activeIcon: const Icon(Icons.arrow_drop_up),
                ),
              ),
              onHeaderItemTap: (index, item) {
                dropDownController.toggle(
                  index,
                  offsetY: dropDownViewOffsetY,
                );
              },
              viewOffsetY: MediaQuery.of(context).padding.top + // statusBar
                  55 + // appBar
                  100 + // blue Container
                  dropDownMenuHeight,
              viewBuilders: [
                DropDownViewBuilder(
                  height: 300,
                  widget: DropDownListView(
                    headerIndex: 0,
                    controller: dropDownController,
                    itemActiveBackgroundColor: Colors.blue.shade100,
                    items: items1,
                  ),
                ),
                DropDownViewBuilder(
                  height: 300,
                  widget: DropDownListView(
                    controller: dropDownController,
                    items: items2,
                    multipleChoice: true,
                    maxMultiChoiceSize: 2,
                  ),
                ),
                DropDownViewBuilder(
                  height: 300,
                  widget: DropDownGridView(
                    crossAxisCount: 3,
                    controller: dropDownController,
                    items: items3,
                  ),
                ),
                DropDownViewBuilder(
                  height: 310,
                  widget: DropDownGridView(
                    crossAxisCount: 3,
                    controller: dropDownController,
                    items: items4,
                    multipleChoice: true,
                    maxMultiChoiceSize: 2,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      SliverList.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            color:
                index % 2 == 0 ? Colors.grey.shade300 : Colors.grey.shade200,
          );
        },
        itemCount: 20,
      ),
    ],
  );
}
```

Stack implementation:

```dart
Widget usingStack() {
  return Stack(
    children: [
      CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text(
                "Using Stack",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentHeaderBuilder(
              height: dropDownMenuHeight,
              builder: (context, offset) {
                return DropDownHeader(
                  key: dropDownMenuKey,
                  controller: dropDownController,
                  height: dropDownMenuHeight,
                  backgroundColor: Colors.white,
                  activeIconColor: Colors.blue,
                  activeTextStyle: const TextStyle(color: Colors.blue),
                  items: List.generate(
                    4,
                            (index) => DropDownItem<Tab>(
                      text: "Tab $index",
                      icon: const Icon(Icons.arrow_drop_down),
                      activeIcon: const Icon(Icons.arrow_drop_up),
                    ),
                  ),
                  onItemTap: (index, item) {
                    dropDownController.toggle(
                      index,
                      offsetY: dropDownViewOffsetY - 55, // appBar
                    );
                  },
                );
              },
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                color: index % 2 == 0
                        ? Colors.grey.shade300
                        : Colors.grey.shade200,
              );
            },
            itemCount: 20,
          ),
        ],
      ),
      DropDownView(
        offsetY: dropDownViewOffsetY - 55, // appBar
        controller: dropDownController,
        builders: [
          DropDownViewBuilder(
            height: 300,
            widget: DropDownListView(
              headerIndex: 0,
              controller: dropDownController,
              itemActiveBackgroundColor: Colors.blue.shade100,
              items: items1,
            ),
          ),
          DropDownViewBuilder(
            height: 300,
            widget: DropDownListView(
              controller: dropDownController,
              items: items2,
              multipleChoice: true,
              maxMultiChoiceSize: 2,
            ),
          ),
          DropDownViewBuilder(
            height: 300,
            widget: DropDownGridView(
              crossAxisCount: 3,
              controller: dropDownController,
              items: items3,
            ),
          ),
          DropDownViewBuilder(
            height: 310,
            widget: DropDownGridView(
              crossAxisCount: 3,
              controller: dropDownController,
              items: items4,
              multipleChoice: true,
              maxMultiChoiceSize: 2,
            ),
          ),
        ],
      ),
    ],
  );
}
```