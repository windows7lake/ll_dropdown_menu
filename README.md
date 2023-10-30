# ll_dropdown_menu

[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/LICENSE)

[中文文档](https://github.com/windows7lake/ll_dropdown_menu/blob/main/README_zh_CN.md)

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
* Support update the style of drop-down menu button after selection

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
ll_dropdown_menu: ^0.5.0
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

### DropDownBoxStyle

`DropDownBoxStyle` is the style of the drop-down menu border, used to customize the border style of the header and content list

```dart
/// Drop-down menu Box style
class DropDownBoxStyle {
  const DropDownBoxStyle({
    this.width,
    this.height,
    this.backgroundColor = Colors.transparent,
    this.border,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.expand = true,
  });

  /// Width of the drop-down menu header component
  final double? width;

  /// Height of the drop-down menu header component
  final double? height;

  /// Background color of the drop-down menu header component
  final Color backgroundColor;

  /// Border of the drop-down menu header component
  final BoxBorder? border;

  /// Decorator of the drop-down menu header component, used to set the background color, border, etc.
  final Decoration? decoration;

  /// Margin of the drop-down menu header component
  final EdgeInsetsGeometry margin;

  /// Padding of the drop-down menu header component
  final EdgeInsetsGeometry padding;

  /// Whether the drop-down menu header component fills the parent component
  final bool expand;
}
```

### DropDownItemStyle

`DropDownItemStyle` is the style of the drop-down menu item, used to customize the style of item

```dart

/// Drop-down menu item style
class DropDownItemStyle {
  const DropDownItemStyle({
    this.width,
    this.height = 50,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.activeTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.highlightTextStyle =
    const TextStyle(fontSize: 14, color: Colors.black),
    this.icon,
    this.activeIcon,
    this.highlightIcon,
    this.iconSize = 20,
    this.activeIconSize = 20,
    this.highlightIconSize = 20,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.black,
    this.highlightIconColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.activeBackgroundColor = Colors.transparent,
    this.highlightBackgroundColor = Colors.transparent,
    this.borderSide = BorderSide.none,
    this.activeBorderSide = BorderSide.none,
    this.highlightBorderSide = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.activeBorderRadius = BorderRadius.zero,
    this.highlightBorderRadius = BorderRadius.zero,
    this.decoration,
    this.activeDecoration,
    this.highlightDecoration,
    this.margin,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.textAlign,
    this.textExpand = false,
    this.iconPosition = IconPosition.right,
    this.gap = 0,
    this.elevation = 0,
  });

  /// The width of the DropDownItem
  final double? width;

  /// The height of the DropDownItem
  final double height;

  /// Text style of the DropDownItem
  final TextStyle textStyle;

  /// Text style when DropDownItem is selected
  final TextStyle activeTextStyle;

  /// Text style after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final TextStyle highlightTextStyle;

  /// The icon of the DropDownItem
  final Widget? icon;

  /// The icon when DropDownItem is selected
  final Widget? activeIcon;

  /// The icon after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Widget? highlightIcon;

  /// The icon size of the DropDownItem
  final double iconSize;

  /// The icon size when DropDownItem is selected
  final double activeIconSize;

  /// The icon size after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final double highlightIconSize;

  /// The icon color of the DropDownItem
  final Color iconColor;

  /// The color of the icon when DropDownItem is selected
  final Color activeIconColor;

  /// The color of the icon after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Color highlightIconColor;

  /// The background color of the DropDownItem
  final Color backgroundColor;

  /// The background color of the DropDownItem when it is selected
  final Color activeBackgroundColor;

  /// The background color of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Color highlightBackgroundColor;

  /// The border of the DropDownItem
  final BorderSide borderSide;

  /// The border of the DropDownItem when it is selected
  final BorderSide activeBorderSide;

  /// The border of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final BorderSide highlightBorderSide;

  /// The corner radius of the DropDownItem
  final BorderRadius borderRadius;

  /// The corner radius of the DropDownItem when it is selected
  final BorderRadius activeBorderRadius;

  /// The corner radius of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final BorderRadius highlightBorderRadius;

  /// Decorator for the DropDownItem
  final Decoration? decoration;

  /// The decorator of the DropDownItem when DropDownItem is selected
  final Decoration? activeDecoration;

  /// The decorator of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Decoration? highlightDecoration;

  /// Margins of the DropDownItem
  final EdgeInsetsGeometry? margin;

  /// Padding of the child items of the DropDownItem
  final EdgeInsetsGeometry padding;

  /// Alignment of the DropDownItem
  final AlignmentGeometry alignment;

  /// Text alignment of the DropDownItem
  final TextAlign? textAlign;

  /// Whether the text fills the parent component
  final bool textExpand;

  /// Position of the icon in the DropDownItem
  final IconPosition iconPosition;

  /// Gap between the icon and the text in the DropDownItem
  final double gap;

  /// The elevation of the DropDownItem
  final double elevation;
}
```

### DropDownButtonStyle

`DropDownButtonStyle` is the style of the drop-down menu button component in the multi-select state

```dart
/// Drop-down menu button style in the multi-select state
class DropDownButtonStyle {
  const DropDownButtonStyle({
    this.resetText = "Reset",
    this.confirmText = "Confirm",
    this.resetTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.confirmTextStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.resetTextWeight,
    this.confirmTextWeight,
    this.resetTextAlign,
    this.confirmTextAlign,
    this.resetBackgroundColor = const Color(0xFFEEEEEE),
    this.confirmBackgroundColor = Colors.blue,
    this.resetElevation = 0,
    this.confirmElevation = 0,
    this.resetBorderRadius,
    this.confirmBorderRadius,
    this.resetBorderSide,
    this.confirmBorderSide,
    this.resetHeight = 50,
    this.confirmHeight = 50,
  });

  /// The text of the reset button
  final String resetText;

  /// The text of the confirmation button
  final String confirmText;

  /// The text style of the reset button
  final TextStyle resetTextStyle;

  /// The text style of the confirmation button
  final TextStyle confirmTextStyle;

  /// The font weight of the reset button
  final FontWeight? resetTextWeight;

  /// The font weight of the confirmation button
  final FontWeight? confirmTextWeight;

  /// The text alignment of the reset button
  final TextAlign? resetTextAlign;

  /// The text alignment of the confirmation button
  final TextAlign? confirmTextAlign;

  /// The background color of the reset button
  final Color resetBackgroundColor;

  /// The background color of the confirmation button
  final Color confirmBackgroundColor;

  /// The elevation of the reset button
  final double resetElevation;

  /// The elevation of the confirmation button
  final double confirmElevation;

  /// The border radius of the reset button
  final BorderRadius? resetBorderRadius;

  /// The border radius of the confirmation button
  final BorderRadius? confirmBorderRadius;

  /// The border side of the reset button
  final BorderSide? resetBorderSide;

  /// The border side of the confirmation button
  final BorderSide? confirmBorderSide;

  /// The height of the reset button
  final double resetHeight;

  /// The height of the confirmation button
  final double confirmHeight;
}
```

### DropDownHeader

`DropDownHeader` is the head component of the drop-down menu, used to display the drop-down menu
bar.

Parameter Description:

```dart
/// Controller of the drop-down menu
final DropDownController controller;

/// Data of the drop-down menu header component
final List<DropDownItem> items;

/// Style of the drop-down menu header component
final DropDownBoxStyle boxStyle;

/// Style of the drop-down menu header item
final DropDownItemStyle itemStyle;

/// Builder for the sub-items of the drop-down menu header component, used to customize Item
final NullableIndexedWidgetBuilder? itemBuilder;

/// Builder of the dividing line between the children of the drop-down menu header component, used to customize the dividing line
final IndexedWidgetBuilder? dividerBuilder;

/// Click event of the child item of the drop-down menu header component
final OnDropDownHeaderItemTap? onItemTap;
```

### DropDownView

`DropDownView` is the main component of the drop-down menu and is used to display the contents of
the drop-down menu.

Parameter Description:

```dart
/// Controller of the drop-down menu
final DropDownController controller;

/// Data for the body component of the drop-down menu
final List<DropDownViewBuilder> builders;

/// Background color of the drop-down menu body component
final Color? viewColor;

/// Color of the mask layer of the drop-down menu
final Color? maskColor;

/// Animation duration of the drop-down menu body component
final Duration animationDuration;

/// Y-axis offset of the drop-down menu body component
final double offsetY;
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
/// Controller of the drop-down menu
final DropDownController controller;

/// Data of the drop-down menu header component
final List<DropDownItem> headerItems;

/// Data of the body component of the drop-down menu
final List<DropDownViewBuilder> viewBuilders;

/// The destruction controller of the drop-down menu, used to close the drop-down menu in advance when the page is destroyed
final DropDownDisposeController? disposeController;

/// Style of the drop-down menu header component
final DropDownBoxStyle headerBoxStyle;

/// Style of the drop-down menu header item
final DropDownItemStyle headerItemStyle;

/// Builder for the sub-items of the drop-down menu header component, used to customize Item
final NullableIndexedWidgetBuilder? headerItemBuilder;

/// Builder of the dividing line between the children of the drop-down menu header component, used to customize the dividing line
final IndexedWidgetBuilder? headerDividerBuilder;

/// Click event of the child item of the drop-down menu header component
final OnDropDownHeaderItemTap? onHeaderItemTap;

/// Background color of the drop-down menu body component
final Color? viewColor;

/// Color of the mask layer in body component of the drop-down menu
final Color? maskColor;

/// Animation duration of the drop-down menu body component
final Duration animationDuration;

/// Y-axis offset of the drop-down menu body component
final double? viewOffsetY;
```

### DropDownListView

`DropDownListView` is the basic implementation of the drop-down menu. It is implemented internally using `ListView` and supports single-selection and multi-selection operations.

Parameter Description:

```dart
/// Controller of the drop-down menu
final DropDownController controller;

/// The data of the drop-down menu content body
final List<DropDownItem> items;

/// Index of the drop-down menu header component
final int? headerIndex;

/// Style of the drop-down menu list
final DropDownBoxStyle boxStyle;

/// Style of the drop-down menu list item
final DropDownItemStyle itemStyle;

/// Builder for the sub-items of the drop-down menu content body, used to customize Item
final IndexedWidgetBuilder? itemBuilder;

/// Click event for the child item of the drop-down menu content body
final OnDropDownItemTap? onDropDownItemTap;

/// The selected state change event of the child item of the drop-down menu content body
final OnDropDownItemChanged? onDropDownItemChanged;

/// The maximum number of multiple choices for the sub-items of the drop-down menu content body
final int? maxMultiChoiceSize;

/// Callback event triggered when the number of multiple selections for the sub-items of the drop-down menu content body exceeds the maximum value
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded;

/// Button component of the drop-down menu content body in the multi-select state
final Widget? btnWidget;

/// The reset button component of the drop-down menu content body in the multi-select state
final Widget? resetWidget;

/// The confirmation button component of the drop-down menu content body in the multi-select state
final Widget? confirmWidget;

/// The style of button component of the drop-down menu content body in the multi-select state
final DropDownButtonStyle buttonStyle;

/// The click event of the reset button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsReset? onDropDownItemsReset;

/// Click event of the confirmation button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsConfirm? onDropDownItemsConfirm;

/// Callback event triggered after the drop-down menu selection is confirmed, used to update the text of the header component by the return value of the callback
/// headerIndex should not be null when using this callback
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

### DropDownGridView

`DropDownGridView` is the basic implementation of the drop-down menu. It is implemented internally using `GridView` and supports single-selection and multi-selection operations.

Parameter Description:

```dart
/// Controller of the drop-down menu
final DropDownController controller;

/// Data of the drop-down menu content body
final List<DropDownItem> items;

/// Index of the drop-down menu header component
final int? headerIndex;

/// The number of columns of the sub-items of the drop-down menu content body
final int crossAxisCount;

/// The line spacing of the sub-items of the drop-down menu content body
final double mainAxisSpacing;

/// Column spacing of the sub-items of the drop-down menu content body
final double crossAxisSpacing;

/// Style of the drop-down menu grid
final DropDownBoxStyle boxStyle;

/// Style of the drop-down menu grid item
final DropDownItemStyle itemStyle;

/// Builder for the sub-items of the drop-down menu content body, used to customize Item
final IndexedWidgetBuilder? itemBuilder;

/// Click event for the child item of the drop-down menu content body
final OnDropDownItemTap? onDropDownItemTap;

/// The selected state change event of the child item of the drop-down menu content body
final OnDropDownItemChanged? onDropDownItemChanged;

/// The maximum number of multiple choices for the sub-items of the drop-down menu content body
final int? maxMultiChoiceSize;

/// Callback event triggered when the number of multiple selections for the sub-items of the drop-down menu content body exceeds the maximum value
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded;

/// Button component of the drop-down menu content body in the multi-select state
final Widget? btnWidget;

/// The reset button component of the drop-down menu content body in the multi-select state
final Widget? resetWidget;

/// The confirmation button component of the drop-down menu content body in the multi-select state
final Widget? confirmWidget;

/// The style of button component of the drop-down menu content body in the multi-select state
final DropDownButtonStyle buttonStyle;

/// The click event of the reset button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsReset? onDropDownItemsReset;

/// Click event of the confirmation button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsConfirm? onDropDownItemsConfirm;

/// Callback event triggered after the drop-down menu selection is confirmed, used to update the text of the header component by the return value of the callback
/// headerIndex should not be null when using this callback
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

### DropDownCascadeList

`DropDownCascadeList` is the basic implementation of drop-down menu, cascading list, supporting single-selection and multi-selection operations.

Parameter Description:

```dart
/// Controller of the drop-down menu
final DropDownController controller;

/// The data of the drop-down menu content body
final List<DropDownItem<List<DropDownItem>>> items;

/// Index of the drop-down menu header component
final int? headerIndex;

/// Style of the drop-down menu list
final DropDownBoxStyle boxStyle;

/// Style of the first-level sub-items of the drop-down menu content body
final DropDownItemStyle firstFloorItemStyle;

/// Builder for the first-level sub-items of the drop-down menu content body, used to customize Item
final IndexedWidgetBuilder? firstFloorItemBuilder;

/// Click event for the first-level sub-item of the drop-down menu content body
final OnDropDownItemTap? onFirstFloorItemTap;

/// Style of the second-level sub-items of the drop-down menu content body
final DropDownItemStyle secondFloorItemStyle;

/// Builder for the second-level sub-items of the drop-down menu content body, used to customize Item
final IndexedWidgetBuilder? secondFloorItemBuilder;

/// Click event for the second-level sub-item of the drop-down menu content body
final OnDropDownItemTap? onSecondFloorItemTap;

/// Selected state change event of the second-level sub-item of the drop-down menu content body
final OnDropDownItemChanged? onSecondFloorItemChanged;

/// The maximum number of multiple choices for the second-level sub-items of the drop-down menu content body
final int? maxMultiChoiceSize;

/// Callback event triggered when the number of multiple selections for the second-level sub-items of the drop-down menu content body exceeds the maximum value
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded;

/// Button component of the drop-down menu content body in the multi-select state
final Widget? btnWidget;

/// The reset button component of the drop-down menu content body in the multi-select state
final Widget? resetWidget;

/// The confirmation button component of the drop-down menu content body in the multi-select state
final Widget? confirmWidget;

/// The style of button component of the drop-down menu content body in the multi-select state
final DropDownButtonStyle buttonStyle;

/// The click event of the reset button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsReset? onDropDownItemsReset;

/// Click event of the confirmation button component of the drop-down menu content body in the multi-select state
final OnDropDownItemsConfirm? onDropDownItemsConfirm;

/// Callback event triggered after the drop-down menu selection is confirmed, used to update the text of the header component by the return value of the callback
/// headerIndex should not be null when using this callback
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
  // Style of the drop-down menu header component
  headerItemStyle: const DropDownItemStyle(
    activeIconColor: Colors.blue,
    activeTextStyle: TextStyle(color: Colors.blue),
  ),
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
  viewOffsetY: MediaQuery.of(context).padding.top + 56,
  // The body content of the drop-down menu
  viewBuilders: [
    DropDownListView(
      controller: dropDownController,
      items: items1,
      headerIndex: 0,
      // to update the style of the header component by the return value of the callback
      // headerIndex should not be null when using this callback
      onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
        return DropDownHeaderStatus(
          text: checkedItems.map((e) => e.text).toList().join("、"),
          highlight: checkedItems.isNotEmpty,
        );
      },
    ),
    DropDownListView(
      controller: dropDownController,
      items: items2,
      maxMultiChoiceSize: 2,
      headerIndex: 1,
      onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
        return DropDownHeaderStatus(
          text: checkedItems.map((e) => e.text).toList().join("、"),
          highlight: checkedItems.isNotEmpty,
        );
      },
    ),
    DropDownGridView(
      controller: dropDownController,
      crossAxisCount: 3,
      boxStyle: const DropDownBoxStyle(
        padding: EdgeInsets.all(16),
      ),
      itemStyle: DropDownItemStyle(
        activeBackgroundColor: const Color(0xFFF5F5F5),
        activeIconColor: Colors.blue,
        activeTextStyle: const TextStyle(color: Colors.blue),
        activeBorderRadius: BorderRadius.circular(6),
      ),
      items: items3,
      headerIndex: 2,
      onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
        return DropDownHeaderStatus(
          text: checkedItems.map((e) => e.text).toList().join("、"),
          highlight: checkedItems.isNotEmpty,
        );
      },
    ),
    DropDownGridView(
      controller: dropDownController,
      crossAxisCount: 3,
      boxStyle: const DropDownBoxStyle(
        padding: EdgeInsets.all(16),
      ),
      itemStyle: DropDownItemStyle(
        activeBackgroundColor: const Color(0xFFF5F5F5),
        activeIconColor: Colors.blue,
        activeTextStyle: const TextStyle(color: Colors.blue),
        activeBorderRadius: BorderRadius.circular(6),
      ),
      items: items4,
      maxMultiChoiceSize: 2,
      headerIndex: 3,
      onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
        return DropDownHeaderStatus(
          text: checkedItems.map((e) => e.text).toList().join("、"),
          highlight: checkedItems.isNotEmpty,
        );
      },
    ),
  ],
),
```

### Use `Stack` to implement drop-down menu, [specific code](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo2.dart)

```dart
Column(children: [
  DropDownHeader(
    controller: dropDownController,
    itemStyle: const DropDownItemStyle(
      activeIconColor: Colors.blue,
      activeTextStyle: TextStyle(color: Colors.blue),
    ),
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
            DropDownListView(
              controller: dropDownController,
              items: List.generate(
                6,
                (index) => DropDownItem(
                  text: "Single Item $index",
                  data: index,
                ),
              ),
            ),
            DropDownListView(
              controller: dropDownController,
              items: List.generate(
                8,
                (index) => DropDownItem(
                  text: "Multi Item $index",
                  data: index,
                ),
              ),
              maxMultiChoiceSize: 2,
            ),
            DropDownGridView(
              controller: dropDownController,
              crossAxisCount: 3,
              boxStyle: const DropDownBoxStyle(
                padding: EdgeInsets.all(16),
              ),
              itemStyle: DropDownItemStyle(
                activeBackgroundColor: const Color(0xFFF5F5F5),
                activeIconColor: Colors.blue,
                activeTextStyle: const TextStyle(color: Colors.blue),
                activeBorderRadius: BorderRadius.circular(6),
              ),
              items: List.generate(
                10,
                (index) => DropDownItem(
                  text: "Single Item $index",
                  icon: const Icon(Icons.ac_unit),
                  activeIcon: const Icon(Icons.ac_unit),
                  data: index,
                ),
              ),
            ),
            DropDownGridView(
              controller: dropDownController,
              crossAxisCount: 3,
              boxStyle: const DropDownBoxStyle(
                padding: EdgeInsets.all(16),
              ),
              itemStyle: DropDownItemStyle(
                activeBackgroundColor: const Color(0xFFF5F5F5),
                activeIconColor: Colors.blue,
                activeTextStyle: const TextStyle(color: Colors.blue),
                activeBorderRadius: BorderRadius.circular(6),
              ),
              items: List.generate(
                12,
                (index) => DropDownItem(
                  text: "Multi Item $index",
                  data: index,
                ),
              ),
              maxMultiChoiceSize: 2,
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
              headerBoxStyle: DropDownBoxStyle(
                height: dropDownMenuHeight,
                backgroundColor: Colors.white,
              ),
              headerItemStyle: const DropDownItemStyle(
                activeIconColor: Colors.blue,
                activeTextStyle: TextStyle(color: Colors.blue),
              ),
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
                DropDownListView(
                  controller: dropDownController,
                  items: List.generate(
                    6,
                    (index) => DropDownItem(
                      text: "Single Item $index",
                      data: index,
                    ),
                  ),
                ),
                DropDownListView(
                  controller: dropDownController,
                  items: List.generate(
                    8,
                    (index) => DropDownItem(
                      text: "Multi Item $index",
                      data: index,
                    ),
                  ),
                  maxMultiChoiceSize: 2,
                ),
                DropDownGridView(
                  crossAxisCount: 3,
                  boxStyle: const DropDownBoxStyle(
                    padding: EdgeInsets.all(16),
                  ),
                  itemStyle: DropDownItemStyle(
                    activeBackgroundColor: const Color(0xFFF5F5F5),
                    activeIconColor: Colors.blue,
                    activeTextStyle: const TextStyle(color: Colors.blue),
                    activeBorderRadius: BorderRadius.circular(6),
                  ),
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
                DropDownGridView(
                  crossAxisCount: 3,
                  boxStyle: const DropDownBoxStyle(
                    padding: EdgeInsets.all(16),
                  ),
                  itemStyle: DropDownItemStyle(
                    activeBackgroundColor: const Color(0xFFF5F5F5),
                    activeIconColor: Colors.blue,
                    activeTextStyle: const TextStyle(color: Colors.blue),
                    activeBorderRadius: BorderRadius.circular(6),
                  ),
                  controller: dropDownController,
                  items: List.generate(
                    12,
                    (index) => DropDownItem(
                      text: "Multi Item $index",
                      data: index,
                    ),
                  ),
                  maxMultiChoiceSize: 2,
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
  double statusBarHeight = MediaQuery.of(context).padding.top;
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
                  boxStyle: DropDownBoxStyle(
                    height: dropDownMenuHeight,
                    backgroundColor: Colors.white,
                  ),
                  itemStyle: const DropDownItemStyle(
                    activeIconColor: Colors.blue,
                    activeTextStyle: TextStyle(color: Colors.blue),
                  ),
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
                      offsetY: dropDownViewOffsetY +
                          dropDownMenuHeight -
                          statusBarHeight -
                          56, // appBar
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
        controller: dropDownController,
        builders: [
          DropDownListView(
            headerIndex: 0,
            controller: dropDownController,
            items: items1,
          ),
          DropDownListView(
            controller: dropDownController,
            items: items2,
            maxMultiChoiceSize: 2,
          ),
          DropDownGridView(
            crossAxisCount: 3,
            boxStyle: const DropDownBoxStyle(
              padding: EdgeInsets.all(16),
            ),
            itemStyle: DropDownItemStyle(
              activeBackgroundColor: const Color(0xFFF5F5F5),
              activeIconColor: Colors.blue,
              activeTextStyle: const TextStyle(color: Colors.blue),
              activeBorderRadius: BorderRadius.circular(6),
            ),
            controller: dropDownController,
            items: items3,
          ),
          DropDownGridView(
            crossAxisCount: 3,
            boxStyle: const DropDownBoxStyle(
              padding: EdgeInsets.all(16),
            ),
            itemStyle: DropDownItemStyle(
              activeBackgroundColor: const Color(0xFFF5F5F5),
              activeIconColor: Colors.blue,
              activeTextStyle: const TextStyle(color: Colors.blue),
              activeBorderRadius: BorderRadius.circular(6),
            ),
            controller: dropDownController,
            items: items4,
            maxMultiChoiceSize: 2,
          ),
        ],
      ),
    ],
  );
}
```