# ll_dropdown_menu

[英文文档](https://github.com/windows7lake/ll_dropdown_menu/blob/main/README.md)

强大且支持自定义的下拉菜单组件。

## 目录导航

- [功能介绍](#功能介绍)
- [Demo展示](#Demo展示)
- [安装](#安装)
- [基础介绍](#基础介绍)
- [使用](#使用)

## 功能介绍

* 支持使用 `Stack` 或者 `Overlay` 实现下拉菜单。
* 自定义下拉菜单栏头部
* 自定义下拉菜单栏主体内容
* 控制下拉菜单的显示与隐藏
* 支持在 `CustomScrollView` 和 `NestedScrollView` 中使用
* 基础的下拉菜单实现：`ListView`、`GridView`、`CascadeList`(级联列表)
* 支持单选和多选操作

## Demo展示

* [Demo1](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo1.dart)
  ：基础的下拉菜单实现：`ListView`、`GridView`（Overlay实现）
* [Demo2](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo2.dart)
  ：基础的下拉菜单实现：`ListView`、`GridView`（Stack实现）
* [Demo3](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo3.dart)
  ：自定义下拉菜单栏头部：`CascadeList`(级联列表)
* [Demo4](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo4.dart)
  ：在 `CustomScrollView` 中使用及 `SliverPersistentHeader` 的使用

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
ll_dropdown_menu: ^0.1.0
```

在终端中运行：

```bash
$ flutter packages get
```

## 基础介绍

### DropdownMenuController

`DropdownMenuController` 是下拉菜单的控制器，用于控制下拉菜单的显示与隐藏。

```dart
void show(int index, {double? offsetY}); // 显示下拉菜单

void hide({int? index, String? text}); // 隐藏下拉菜单

void toggle({int? index, String? text}); // 显示或隐藏下拉菜单
```

`show` 方法中的 `index` 参数表示要显示的下拉菜单的索引，`offsetY` 表示下拉菜单的 Y 轴偏移量。<br>
`hide` 方法中的 `index` 参数表示要隐藏的下拉菜单的索引，`text` 表示要隐藏时需要修改下拉按钮的文本为选中的内容。

### DropDownHeader

`DropDownHeader` 是下拉菜单的头部组件，用于显示下拉菜单的按钮。

参数说明：

```dart
final DropDownController controller; // 下拉菜单的控制器
final List<DropDownItem> items; // 下拉菜单头部组件的数据
final double? width; // 下拉菜单头部组件的宽度
final double height; // 下拉菜单头部组件的高度
final Color backgroundColor; // 下拉菜单头部组件的背景颜色
final BoxBorder? border; // 下拉菜单头部组件的边框
final Decoration? decoration; // 下拉菜单头部组件的 装饰器，用于设置背景颜色、边框等
final EdgeInsetsGeometry margin; // 下拉菜单头部组件的外边距
final EdgeInsetsGeometry padding; // 下拉菜单头部组件的内边距
final bool expand; // 下拉菜单头部组件是否填充父组件
final TextStyle textStyle; // 下拉菜单头部组件的文本样式
final TextStyle activeTextStyle; // 下拉菜单头部组件选中时的文本样式
final double iconSize; // 下拉菜单头部组件的图标大小
final double activeIconSize; // 下拉菜单头部组件选中时的图标大小
final Color iconColor; // 下拉菜单头部组件的图标颜色
final Color activeIconColor; // 下拉菜单头部组件选中时的图标颜色
final Decoration? itemDecoration; // 下拉菜单头部组件的子项的装饰器，用于设置背景颜色、边框等
final Decoration? activeItemDecoration; // 下拉菜单头部组件选中时的子项的装饰器，用于设置背景颜色、边框等
final EdgeInsetsGeometry itemMargin; // 下拉菜单头部组件的子项的外边距
final EdgeInsetsGeometry itemPadding; // 下拉菜单头部组件的子项的内边距
final AlignmentGeometry itemAlignment; // 下拉菜单头部组件的子项的对齐方式
final NullableIndexedWidgetBuilder? itemBuilder; // 下拉菜单头部组件的子项的构建器，用于自定义Item
final IndexedWidgetBuilder? dividerBuilder; // 下拉菜单头部组件的子项之间分割线的构建器，用于自定义分割线
final OnDropDownHeaderItemTap? onItemTap; // 下拉菜单头部组件的子项的点击事件
```

### DropDownView

`DropDownView` 是下拉菜单的主体组件，用于显示下拉菜单的内容。

参数说明：

```dart
final DropDownController controller; // 下拉菜单的控制器
final List<DropDownViewBuilder> builders; // 下拉菜单主体组件的数据
final Color? viewColor; // 下拉菜单主体组件的背景颜色
final Color? maskColor; // 下拉菜单主体组件的遮罩层颜色
final Duration animationDuration; // 下拉菜单主体组件的动画时长
final double offsetY; // 下拉菜单主体组件的 Y 轴偏移量
```

### DropDownMenu

`DropDownMenu` 是下拉菜单组件，内部集合了下拉菜单的按钮和内容主体，通过 Overlay
来控制内容主体的显示和隐藏。<br>
其在布局上更加灵活，只要如同按钮等组件正常的布局即可，不需要考虑内容主体的布局。内容主体的位置是通过 `viewOffsetY`
参数来控制的。

参数说明：

```dart
final DropDownController controller; // 下拉菜单的控制器
final List<DropDownItem> headerItems; // 下拉菜单头部组件的数据
final List<DropDownViewBuilder> viewBuilders; // 下拉菜单主体组件的数据
final DropDownDisposeController? disposeController; // 下拉菜单的销毁控制器，用于在页面销毁时提前关闭下拉菜单
final double? headerWidth; // 下拉菜单头部组件的宽度
final double headerHeight; // 下拉菜单头部组件的高度
final Color headerBackgroundColor; // 下拉菜单头部组件的背景颜色
final BoxBorder? headerBorder; // 下拉菜单头部组件的边框
final Decoration? headerDecoration; // 下拉菜单头部组件的 装饰器，用于设置背景颜色、边框等
final EdgeInsetsGeometry headerMargin; // 下拉菜单头部组件的外边距
final EdgeInsetsGeometry headerPadding; // 下拉菜单头部组件的内边距
final bool headerExpand; // 下拉菜单头部组件是否填充父组件
final TextStyle headerTextStyle; // 下拉菜单头部组件的文本样式
final TextStyle headerActiveTextStyle; // 下拉菜单头部组件选中时的文本样式
final double headerIconSize; // 下拉菜单头部组件的图标大小
final double headerActiveIconSize; // 下拉菜单头部组件选中时的图标大小
final Color headerIconColor; // 下拉菜单头部组件的图标颜色
final Color headerActiveIconColor; // 下拉菜单头部组件选中时的图标颜色
final Decoration? headerItemDecoration; // 下拉菜单头部组件的子项的装饰器，用于设置背景颜色、边框等
final Decoration? headerActiveItemDecoration; // 下拉菜单头部组件选中时的子项的装饰器，用于设置背景颜色、边框等
final EdgeInsetsGeometry headerItemMargin; // 下拉菜单头部组件的子项的外边距
final EdgeInsetsGeometry headerItemPadding; // 下拉菜单头部组件的子项的内边距
final AlignmentGeometry headerItemAlignment; // 下拉菜单头部组件的子项的对齐方式
final NullableIndexedWidgetBuilder? headerItemBuilder; // 下拉菜单头部组件的子项的构建器，用于自定义Item
final IndexedWidgetBuilder? headerDividerBuilder; // 下拉菜单头部组件的子项之间分割线的构建器，用于自定义分割线
final OnDropDownHeaderItemTap? onHeaderItemTap; // 下拉菜单头部组件的子项的点击事件
final Color? viewColor; // 下拉菜单主体组件的背景颜色
final Color? maskColor; // 下拉菜单主体组件的遮罩层颜色
final Duration animationDuration; // 下拉菜单主体组件的动画时长
final double? viewOffsetY; // 下拉菜单主体组件的 Y 轴偏移量
```

### DropDownListView

`DropDownListView` 是下拉菜单的基础实现，内部使用 `ListView` 实现，支持单选和多选操作。

参数说明：

```dart
final DropDownController controller; // 下拉菜单的控制器
final List<DropDownItem> items; // 下拉菜单内容主体的数据
final int? headerIndex; // 下拉菜单头部组件的索引
final double itemHeight; // 下拉菜单内容主体的子项的高度
final TextStyle textStyle; // 下拉菜单内容主体的子项的文本样式
final TextStyle activeTextStyle; // 下拉菜单内容主体的子项选中时的文本样式
final Widget? icon; // 下拉菜单内容主体的子项的图标
final Widget? activeIcon; // 下拉菜单内容主体的子项选中时的图标
final double iconSize; // 下拉菜单内容主体的子项的图标大小
final double activeIconSize; // 下拉菜单内容主体的子项选中时的图标大小
final Color iconColor; // 下拉菜单内容主体的子项的图标颜色
final Color activeIconColor; // 下拉菜单内容主体的子项选中时的图标颜色
final Color itemBackgroundColor; // 下拉菜单内容主体的子项的背景颜色
final Color itemActiveBackgroundColor; // 下拉菜单内容主体的子项选中时的背景颜色
final BoxBorder? itemBorder; // 下拉菜单内容主体的子项的边框
final BoxBorder? itemActiveBorder; // 下拉菜单内容主体的子项选中时的边框
final Decoration? itemDecoration; // 下拉菜单内容主体的子项的装饰器，用于设置背景颜色、边框等
final Decoration? activeItemDecoration; // 下拉菜单内容主体的子项选中时的装饰器，用于设置背景颜色、边框等
final double itemBorderRadius; // 下拉菜单内容主体的子项的圆角半径
final AlignmentGeometry itemAlignment; // 下拉菜单内容主体的子项的对齐方式
final EdgeInsetsGeometry? itemPadding; // 下拉菜单内容主体的子项的内边距
final IndexedWidgetBuilder? itemBuilder; // 下拉菜单内容主体的子项的构建器，用于自定义Item
final OnDropDownItemTap? onDropDownItemTap; // 下拉菜单内容主体的子项的点击事件
final OnDropDownItemChanged? onDropDownItemChanged; // 下拉菜单内容主体的子项的选中状态改变事件
final int? maxMultiChoiceSize; // 下拉菜单内容主体的子项的最大多选数量
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded; // 下拉菜单内容主体的子项的多选数量超过最大值时触发的回调事件
final double? maxListHeight; // 下拉菜单内容主体的最大高度
final bool multipleChoice; // 下拉菜单内容主体的是否支持多选
final Widget? btnWidget; // 下拉菜单内容主体在多选状态下的按钮组件
final Widget? resetWidget; // 下拉菜单内容主体在多选状态下的重置按钮组件
final Widget? confirmWidget; // 下拉菜单内容主体在多选状态下的确认按钮组件
final double resetHeight; // 下拉菜单内容主体在多选状态下的重置按钮组件的高度
final double confirmHeight; // 下拉菜单内容主体在多选状态下的确认按钮组件的高度
final String resetText; // 下拉菜单内容主体在多选状态下的重置按钮组件的文本
final String confirmText; // 下拉菜单内容主体在多选状态下的确认按钮组件的文本
final TextStyle resetTextStyle; // 下拉菜单内容主体在多选状态下的重置按钮组件的文本样式
final TextStyle confirmTextStyle; // 下拉菜单内容主体在多选状态下的确认按钮组件的文本样式
final Color resetBackgroundColor; // 下拉菜单内容主体在多选状态下的重置按钮组件的背景颜色
final Color confirmBackgroundColor; // 下拉菜单内容主体在多选状态下的确认按钮组件的背景颜色
final OnDropDownItemsReset? onDropDownItemsReset; // 下拉菜单内容主体在多选状态下的重置按钮组件的点击事件
final OnDropDownItemsConfirm? onDropDownItemsConfirm; // 下拉菜单内容主体在多选状态下的确认按钮组件的点击事件
```

### DropDownGridView

`DropDownGridView` 是下拉菜单的基础实现，内部使用 `GridView` 实现，支持单选和多选操作。

参数说明：

```dart
final DropDownController controller; // 下拉菜单的控制器
final List<DropDownItem> items; // 下拉菜单内容主体的数据
final int? headerIndex; // 下拉菜单头部组件的索引
final EdgeInsetsGeometry? padding; // 下拉菜单内容主体的内边距
final int crossAxisCount; // 下拉菜单内容主体的子项的列数
final double mainAxisSpacing; // 下拉菜单内容主体的子项的行间距
final double crossAxisSpacing; // 下拉菜单内容主体的子项的列间距
final double itemHeight; // 下拉菜单内容主体的子项的高度
final TextStyle textStyle; // 下拉菜单内容主体的子项的文本样式
final TextStyle activeTextStyle; // 下拉菜单内容主体的子项选中时的文本样式
final Widget? icon; // 下拉菜单内容主体的子项的图标
final Widget? activeIcon; // 下拉菜单内容主体的子项选中时的图标
final double iconSize; // 下拉菜单内容主体的子项的图标大小
final double activeIconSize; // 下拉菜单内容主体的子项选中时的图标大小
final Color iconColor; // 下拉菜单内容主体的子项的图标颜色
final Color activeIconColor; // 下拉菜单内容主体的子项选中时的图标颜色
final Color itemBackgroundColor; // 下拉菜单内容主体的子项的背景颜色
final Color itemActiveBackgroundColor; // 下拉菜单内容主体的子项选中时的背景颜色
final BoxBorder? itemBorder; // 下拉菜单内容主体的子项的边框
final BoxBorder? itemActiveBorder; // 下拉菜单内容主体的子项选中时的边框
final Decoration? itemDecoration; // 下拉菜单内容主体的子项的装饰器，用于设置背景颜色、边框等
final Decoration? activeItemDecoration; // 下拉菜单内容主体的子项选中时的装饰器，用于设置背景颜色、边框等
final double itemBorderRadius; // 下拉菜单内容主体的子项的圆角半径
final AlignmentGeometry itemAlignment; // 下拉菜单内容主体的子项的对齐方式
final EdgeInsetsGeometry? itemPadding; // 下拉菜单内容主体的子项的内边距
final IndexedWidgetBuilder? itemBuilder; // 下拉菜单内容主体的子项的构建器，用于自定义Item
final OnDropDownItemTap? onDropDownItemTap; // 下拉菜单内容主体的子项的点击事件
final OnDropDownItemChanged? onDropDownItemChanged; // 下拉菜单内容主体的子项的选中状态改变事件
final int? maxMultiChoiceSize; // 下拉菜单内容主体的子项的最大多选数量
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded; // 下拉菜单内容主体的子项的多选数量超过最大值时触发的回调事件
final double? maxListHeight; // 下拉菜单内容主体的最大高度
final bool multipleChoice; // 下拉菜单内容主体的是否支持多选
final Widget? btnWidget; // 下拉菜单内容主体在多选状态下的按钮组件
final Widget? resetWidget; // 下拉菜单内容主体在多选状态下的重置按钮组件
final Widget? confirmWidget; // 下拉菜单内容主体在多选状态下的确认按钮组件
final double resetHeight; // 下拉菜单内容主体在多选状态下的重置按钮组件的高度
final double confirmHeight; // 下拉菜单内容主体在多选状态下的确认按钮组件的高度
final String resetText; // 下拉菜单内容主体在多选状态下的重置按钮组件的文本
final String confirmText; // 下拉菜单内容主体在多选状态下的确认按钮组件的文本
final TextStyle resetTextStyle; // 下拉菜单内容主体在多选状态下的重置按钮组件的文本样式
final TextStyle confirmTextStyle; // 下拉菜单内容主体在多选状态下的确认按钮组件的文本样式
final Color resetBackgroundColor; // 下拉菜单内容主体在多选状态下的重置按钮组件的背景颜色
final Color confirmBackgroundColor; // 下拉菜单内容主体在多选状态下的确认按钮组件的背景颜色
final OnDropDownItemsReset? onDropDownItemsReset; // 下拉菜单内容主体在多选状态下的重置按钮组件的点击事件
final OnDropDownItemsConfirm? onDropDownItemsConfirm; // 下拉菜单内容主体在多选状态下的确认按钮组件的点击事件
```

### DropDownCascadeList

`DropDownCascadeList` 是下拉菜单的基础实现，级联列表，支持单选和多选操作。

参数说明：

```dart
final DropDownController controller; // 下拉菜单的控制器
final List<DropDownItem<List<DropDownItem>>> items; // 下拉菜单内容主体的数据
final int? headerIndex; // 下拉菜单头部组件的索引
final double firstFloorRatio; // 下拉菜单内容主体的第一层级的宽度占比
final Color? firstFloorBackgroundColor; // 下拉菜单内容主体的第一层级的背景颜色
final double firstFloorItemHeight; // 下拉菜单内容主体的第一层级的子项的高度
final TextStyle firstFloorTextStyle; // 下拉菜单内容主体的第一层级的子项的文本样式
final TextStyle firstFloorActiveTextStyle; // 下拉菜单内容主体的第一层级的子项选中时的文本样式
final Color firstFloorItemBackgroundColor; // 下拉菜单内容主体的第一层级的子项的背景颜色
final Color firstFloorItemActiveBackgroundColor; // 下拉菜单内容主体的第一层级的子项选中时的背景颜色
final Decoration? firstFloorItemDecoration; // 下拉菜单内容主体的第一层级的子项的装饰器，用于设置背景颜色、边框等
final Decoration? firstFloorActiveItemDecoration; // 下拉菜单内容主体的第一层级的子项选中时的装饰器，用于设置背景颜色、边框等
final AlignmentGeometry firstFloorItemAlignment; // 下拉菜单内容主体的第一层级的子项的对齐方式
final EdgeInsetsGeometry? firstFloorItemPadding; // 下拉菜单内容主体的第一层级的子项的内边距
final IndexedWidgetBuilder? firstFloorItemBuilder; // 下拉菜单内容主体的第一层级的子项的构建器，用于自定义Item
final OnDropDownItemTap? onFirstFloorItemTap; // 下拉菜单内容主体的第一层级的子项的点击事件
final Color? secondFloorBackgroundColor; // 下拉菜单内容主体的第二层级的背景颜色
final double secondFloorItemHeight; // 下拉菜单内容主体的第二层级的子项的高度
final TextStyle secondFloorTextStyle; // 下拉菜单内容主体的第二层级的子项的文本样式
final TextStyle secondFloorActiveTextStyle; // 下拉菜单内容主体的第二层级的子项选中时的文本样式
final Color secondFloorItemBackgroundColor; // 下拉菜单内容主体的第二层级的子项的背景颜色
final Color secondFloorItemActiveBackgroundColor; // 下拉菜单内容主体的第二层级的子项选中时的背景颜色
final Decoration? secondFloorItemDecoration; // 下拉菜单内容主体的第二层级的子项的装饰器，用于设置背景颜色、边框等
final Decoration? secondFloorActiveItemDecoration; // 下拉菜单内容主体的第二层级的子项选中时的装饰器，用于设置背景颜色、边框等
final Widget? secondFloorItemIcon; // 下拉菜单内容主体的第二层级的子项的图标
final Widget? secondFloorItemActiveIcon; // 下拉菜单内容主体的第二层级的子项选中时的图标
final double secondFloorItemIconSize; // 下拉菜单内容主体的第二层级的子项的图标大小
final double secondFloorItemActiveIconSize; // 下拉菜单内容主体的第二层级的子项选中时的图标大小
final Color secondFloorItemIconColor; // 下拉菜单内容主体的第二层级的子项的图标颜色
final Color secondFloorItemActiveIconColor; // 下拉菜单内容主体的第二层级的子项选中时的图标颜色
final AlignmentGeometry secondFloorItemAlignment; // 下拉菜单内容主体的第二层级的子项的对齐方式
final EdgeInsetsGeometry? secondFloorItemPadding; // 下拉菜单内容主体的第二层级的子项的内边距
final IndexedWidgetBuilder? secondFloorItemBuilder; // 下拉菜单内容主体的第二层级的子项的构建器，用于自定义Item
final OnDropDownItemTap? onSecondFloorItemTap; // 下拉菜单内容主体的第二层级的子项的点击事件
final OnDropDownItemChanged? onSecondFloorItemChanged; // 下拉菜单内容主体的第二层级的子项的选中状态改变事件
final int? maxMultiChoiceSize; // 下拉菜单内容主体的第二层级的子项的最大多选数量
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded; // 下拉菜单内容主体的第二层级的子项的多选数量超过最大值时触发的回调事件
final double? maxListHeight; // 下拉菜单内容主体的最大高度
final bool multipleChoice; // 下拉菜单内容主体的是否支持多选
final Widget? btnWidget; // 下拉菜单内容主体在多选状态下的按钮组件
final Widget? resetWidget; // 下拉菜单内容主体在多选状态下的重置按钮组件
final Widget? confirmWidget; // 下拉菜单内容主体在多选状态下的确认按钮组件
final double resetHeight; // 下拉菜单内容主体在多选状态下的重置按钮组件的高度
final double confirmHeight; // 下拉菜单内容主体在多选状态下的确认按钮组件的高度
final String resetText; // 下拉菜单内容主体在多选状态下的重置按钮组件的文本
final String confirmText; // 下拉菜单内容主体在多选状态下的确认按钮组件的文本
final TextStyle resetTextStyle; // 下拉菜单内容主体在多选状态下的重置按钮组件的文本样式
final TextStyle confirmTextStyle; // 下拉菜单内容主体在多选状态下的确认按钮组件的文本样式
final Color resetBackgroundColor; // 下拉菜单内容主体在多选状态下的重置按钮组件的背景颜色
final Color confirmBackgroundColor; // 下拉菜单内容主体在多选状态下的确认按钮组件的背景颜色
final OnDropDownItemsReset? onDropDownItemsReset; // 下拉菜单内容主体在多选状态下的重置按钮组件的点击事件
final OnDropDownItemsConfirm? onDropDownItemsConfirm; // 下拉菜单内容主体在多选状态下的确认按钮组件的点击事件
```

## 使用

### 使用 `Overlay` 实现下拉菜单，[具体代码](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo1.dart)

```dart
DropDownMenu(
  // 下拉菜单的控制器
  controller: dropDownController,
  // 下拉菜单的销毁控制器
  disposeController: dropDownDisposeController,
  // 下拉菜单的头部高度
  headerHeight: 50,
  headerActiveIconColor: Colors.blue,
  headerActiveTextStyle: const TextStyle(color: Colors.blue),
  // 下拉菜单的头部数据
  headerItems: List.generate(
    4,
    (index) => DropDownItem<Tab>(
      text: "Tab $index",
      icon: const Icon(Icons.arrow_drop_down),
      activeIcon: const Icon(Icons.arrow_drop_up),
    ),
  ),
  // 下拉菜单的主体内容的 Y 轴偏移量
  viewOffsetY: MediaQuery.of(context).padding.top + 50,
  // 下拉菜单的主体内容
  viewBuilders: [
    DropDownViewBuilder(
      height: 300,
      widget: DropDownListView(
        headerIndex: 0,
        controller: dropDownController,
        itemActiveBackgroundColor: Colors.blue.shade100,
        items: items,
      ),
    ),
    DropDownViewBuilder(
      height: 300,
      widget: DropDownListView(
        controller: dropDownController,
        items: items,
        multipleChoice: true,
        maxMultiChoiceSize: 2,
      ),
    ),
    DropDownViewBuilder(
      height: 300,
      widget: DropDownGridView(
        crossAxisCount: 3,
        controller: dropDownController,
        items: items,
      ),
    ),
    DropDownViewBuilder(
      height: 310,
      widget: DropDownGridView(
        crossAxisCount: 3,
        controller: dropDownController,
        items: items,
        multipleChoice: true,
        maxMultiChoiceSize: 2,
      ),
    ),
  ],
),
```

### 使用 `Stack` 实现下拉菜单，[具体代码](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo2.dart)

```dart
Column(children: [
  DropDownHeader(
    // 下拉菜单的控制器
    controller: dropDownController,
    height: 50,
    activeIconColor: Colors.blue,
    activeTextStyle: const TextStyle(color: Colors.blue),
    // 下拉菜单的头部数据
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
          // 下拉菜单的控制器
          controller: dropDownController,
          // 下拉菜单的主体内容
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

### 在 `CustomScrollView` 中使用，[具体代码](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo4.dart)

变量声明：

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

Overlay实现：

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

Stack实现：

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