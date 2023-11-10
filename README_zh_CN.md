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
* 支持在选择完成之后更新下拉菜单的按钮样式

## Demo展示

* [Demo1](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo1.dart)
  ：基础的下拉菜单实现：`ListView`、`GridView`（Overlay实现）
* [Demo2](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo2.dart)
  ：基础的下拉菜单实现：`ListView`、`GridView`（Stack实现）
* [Demo3](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo3.dart)
  ：自定义下拉菜单栏头部：`CascadeList`(级联列表)
* [Demo4](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo4.dart)
  ：在 `CustomScrollView` 中使用及 `SliverPersistentHeader` 的使用

<a target="_blank" rel="noopener noreferrer" href="https://github.com/windows7lake/ll_dropdown_menu/blob/main/preview/demo1.gif">
<img src="https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/preview/demo1.gif" width="250" height="500" align="center" style="max-width:100%;">
</a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/windows7lake/ll_dropdown_menu/blob/main/preview/demo3.gif">
<img src="https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/preview/demo3.gif" width="250" height="500" align="center" style="max-width:100%;">
</a>
<a target="_blank" rel="noopener noreferrer" href="https://github.com/windows7lake/ll_dropdown_menu/blob/main/preview/demo4.gif">
<img src="https://raw.githubusercontent.com/windows7lake/ll_dropdown_menu/main/preview/demo4.gif" width="250" height="500" align="center" style="max-width:100%;">
</a>

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
ll_dropdown_menu: ^0.5.0
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

### DropDownBoxStyle

`DropDownBoxStyle` 是下拉菜单边框的样式，用于自定义头部及内容列表的边框样式

```dart
/// 下拉菜单-边框样式
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

  /// 下拉菜单-边框样式-宽度
  final double? width;

  /// 下拉菜单-边框样式-高度
  final double? height;

  /// 下拉菜单-边框样式-背景色
  final Color backgroundColor;

  /// 下拉菜单-边框样式-边框
  final BoxBorder? border;

  /// 下拉菜单-边框样式-装饰器，用于设置背景颜色、边框等
  final Decoration? decoration;

  /// 下拉菜单-边框样式-外边距
  final EdgeInsetsGeometry margin;

  /// 下拉菜单-边框样式-内边距
  final EdgeInsetsGeometry padding;

  /// 下拉菜单-边框样式-是否需要铺满父组件
  final bool expand;
}
```

### DropDownItemStyle

`DropDown Item Style` 是下拉菜单项的样式，用于自定义item的样式

```dart
/// 下拉菜单-Item样式
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

  /// 下拉菜单-Item样式-宽度
  final double? width;

  /// 下拉菜单-Item样式-高度
  final double height;

  /// 下拉菜单-Item样式-文本样式
  final TextStyle textStyle;

  /// 下拉菜单-Item样式-文本样式（选中时）
  final TextStyle activeTextStyle;

  /// 下拉菜单-Item样式-文本样式（选择后，且下拉菜单中有选项被选中）
  final TextStyle highlightTextStyle;
  
  /// 下拉菜单-Item样式-图标
  final Widget? icon;

  /// 下拉菜单-Item样式-图标（选中时）
  final Widget? activeIcon;

  /// 下拉菜单-Item样式-图标（选择后，且下拉菜单中有选项被选中）
  final Widget? highlightIcon;

  /// 下拉菜单-Item样式-图标大小
  final double iconSize;

  /// 下拉菜单-Item样式-图标大小（选中时）
  final double activeIconSize;

  /// 下拉菜单-Item样式-图标大小（选择后，且下拉菜单中有选项被选中）
  final double highlightIconSize;
  
  /// 下拉菜单-Item样式-图标颜色
  final Color iconColor;

  /// 下拉菜单-Item样式-图标颜色（选中时）
  final Color activeIconColor;

  /// 下拉菜单-Item样式-图标颜色（选择后，且下拉菜单中有选项被选中）
  final Color highlightIconColor;

  /// 下拉菜单-Item样式-背景色
  final Color backgroundColor;

  /// 下拉菜单-Item样式-背景色（选中时）
  final Color activeBackgroundColor;

  /// 下拉菜单-Item样式-背景色（选择后，且下拉菜单中有选项被选中）
  final Color highlightBackgroundColor;
  
  /// 下拉菜单-Item样式-边框
  final BorderSide borderSide;

  /// 下拉菜单-Item样式-边框（选中时）
  final BorderSide activeBorderSide;

  /// 下拉菜单-Item样式-边框（选择后，且下拉菜单中有选项被选中）
  final BorderSide highlightBorderSide;

  /// 下拉菜单-Item样式-边框圆角
  final BorderRadius borderRadius;

  /// 下拉菜单-Item样式-边框圆角（选中时）
  final BorderRadius activeBorderRadius;

  /// 下拉菜单-Item样式-边框圆角（选择后，且下拉菜单中有选项被选中）
  final BorderRadius highlightBorderRadius;

  /// 下拉菜单-Item样式-装饰器，用于设置背景颜色、边框等
  final Decoration? decoration;

  /// 下拉菜单-Item样式-装饰器，用于设置背景颜色、边框等（选中时）
  final Decoration? activeDecoration;

  /// 下拉菜单-Item样式-装饰器，用于设置背景颜色、边框等（选择后，且下拉菜单中有选项被选中）
  final Decoration? highlightDecoration;
  
  /// 下拉菜单-Item样式-外边距
  final EdgeInsetsGeometry? margin;

  /// 下拉菜单-Item样式-内边距
  final EdgeInsetsGeometry padding;

  /// 下拉菜单-Item样式-对齐方式
  final AlignmentGeometry alignment;

  /// 下拉菜单-Item样式-文本对齐方式
  final TextAlign? textAlign;

  /// 下拉菜单-Item样式-文本是否填充父组件
  final bool textExpand;

  /// 下拉菜单-Item样式-图标位置
  final IconPosition iconPosition;

  /// 下拉菜单-Item样式-图标与文本之间的间距
  final double gap;

  /// 下拉菜单-Item样式-阴影高度
  final double elevation;
}
```

### DropDownButtonStyle

`DropDownButtonStyle` 是多选状态下下拉菜单按钮组件的样式。

```dart
/// 多选状态下下拉菜单按钮组件的样式
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

  /// 下拉菜单按钮组件-重置按钮文本
  final String resetText;

  /// 下拉菜单按钮组件-确认按钮文本
  final String confirmText;

  /// 下拉菜单按钮组件-重置按钮文本样式
  final TextStyle resetTextStyle;

  /// 下拉菜单按钮组件-确认按钮文本样式
  final TextStyle confirmTextStyle;

  /// 下拉菜单按钮组件-重置按钮文本粗细
  final FontWeight? resetTextWeight;

  /// 下拉菜单按钮组件-确认按钮文本粗细
  final FontWeight? confirmTextWeight;

  /// 下拉菜单按钮组件-重置按钮文本对齐方式
  final TextAlign? resetTextAlign;

  /// 下拉菜单按钮组件-确认按钮文本对齐方式
  final TextAlign? confirmTextAlign;

  /// 下拉菜单按钮组件-重置按钮背景颜色
  final Color resetBackgroundColor;

  /// 下拉菜单按钮组件-确认按钮背景颜色
  final Color confirmBackgroundColor;

  /// 下拉菜单按钮组件-重置按钮阴影高度
  final double resetElevation;

  /// 下拉菜单按钮组件-确认按钮阴影高度
  final double confirmElevation;

  /// 下拉菜单按钮组件-重置按钮圆角
  final BorderRadius? resetBorderRadius;

  /// 下拉菜单按钮组件-确认按钮圆角
  final BorderRadius? confirmBorderRadius;

  /// 下拉菜单按钮组件-重置按钮边框
  final BorderSide? resetBorderSide;

  /// 下拉菜单按钮组件-确认按钮边框
  final BorderSide? confirmBorderSide;

  /// 下拉菜单按钮组件-重置按钮高度
  final double resetHeight;

  /// 下拉菜单按钮组件-确认按钮高度
  final double confirmHeight;
}
```

### DropDownHeader

`DropDownHeader` 是下拉菜单的头部组件，用于显示下拉菜单的按钮。

参数说明：

```dart
/// 下拉菜单的控制器
final DropDownController controller;

/// 下拉菜单头部组件的数据
final List<DropDownItem> items;

/// 下拉菜单头部组件的边框样式
final DropDownBoxStyle boxStyle;

/// 下拉菜单头部组件的Item的样式
final DropDownItemStyle itemStyle;

/// 下拉菜单头部组件的子项的构建器，用于自定义Item
final NullableIndexedWidgetBuilder? itemBuilder;

/// 下拉菜单头部组件的子项之间分割线的构建器，用于自定义分割线
final IndexedWidgetBuilder? dividerBuilder;

/// 下拉菜单头部组件的子项的点击事件
final OnDropDownHeaderItemTap? onItemTap;
```

### DropDownView

`DropDownView` 是下拉菜单的主体组件，用于显示下拉菜单的内容。

参数说明：

```dart
/// 下拉菜单的控制器
final DropDownController controller;

/// 下拉菜单主体组件的数据
final List<DropDownViewBuilder> builders;

/// 下拉菜单主体组件的背景颜色
final Color? viewColor;

/// 下拉菜单主体组件的遮罩层颜色
final Color? maskColor;

/// 下拉菜单主体组件的动画时长
final Duration animationDuration;

/// 下拉菜单主体组件的 Y 轴偏移量
final double offsetY;
```

### DropDownMenu

`DropDownMenu` 是下拉菜单组件，内部集合了下拉菜单的按钮和内容主体，通过 Overlay 来控制内容主体的显示和隐藏。<br><br>
其在布局上更加灵活，只要和按钮等组件一样，进行正常布局即可，不需要考虑内容主体的布局。内容主体的位置是通过 `viewOffsetY`
参数来控制的。

参数说明：

```dart
/// 下拉菜单的控制器
final DropDownController controller;

/// 下拉菜单头部组件的数据
final List<DropDownItem> headerItems;

/// 下拉菜单内容组件的数据
final List<DropDownViewBuilder> viewBuilders;

/// 下拉菜单的销毁控制器，用于在页面销毁时提前关闭下拉菜单
final DropDownDisposeController? disposeController;

/// 下拉菜单头部组件的边框样式
final DropDownBoxStyle headerBoxStyle;

/// 下拉菜单头部组件的Item样式
final DropDownItemStyle headerItemStyle;

/// 下拉菜单头部组件的子项的构建器，用于自定义Item
final NullableIndexedWidgetBuilder? headerItemBuilder;

/// 下拉菜单头部组件的子项之间分割线的构建器，用于自定义分割线
final IndexedWidgetBuilder? headerDividerBuilder;

/// 下拉菜单头部组件的子项的点击事件
final OnDropDownHeaderItemTap? onHeaderItemTap;

/// 下拉菜单内容组件的背景颜色
final Color? viewColor;

/// 下拉菜单内容组件的遮罩层颜色
final Color? maskColor;

/// 下拉菜单内容组件的动画时长
final Duration animationDuration;

/// 下拉菜单内容组件的 Y 轴偏移量
final double? viewOffsetY;
```

### DropDownListView

`DropDownListView` 是下拉菜单的基础实现，内部使用 `ListView` 实现，支持单选和多选操作。

参数说明：

```dart
/// 下拉菜单的控制器
final DropDownController controller;

/// 下拉菜单内容组件的数据
final List<DropDownItem> items;

/// 下拉菜单内容组件对应头部组件中的位置索引
final int? headerIndex;

/// 下拉菜单内容组件的边框样式
final DropDownBoxStyle boxStyle;

/// 下拉菜单内容组件的Item样式
final DropDownItemStyle itemStyle;

/// 下拉菜单内容组件的子项的构建器，用于自定义Item
final IndexedWidgetBuilder? itemBuilder;

/// 下拉菜单内容组件的子项的点击事件
final OnDropDownItemTap? onDropDownItemTap;

/// 下拉菜单内容组件的子项的选中状态改变时的回调监听事件
final OnDropDownItemChanged? onDropDownItemChanged;

/// 下拉菜单内容组件的子项的最大多选数量
final int? maxMultiChoiceSize;

/// 下拉菜单内容组件的子项的多选数量超过最大值时触发的回调事件
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded;

/// 下拉菜单内容组件在多选状态下的按钮组件
final Widget? btnWidget;

/// 下拉菜单内容组件在多选状态下的重置按钮组件
final Widget? resetWidget;

/// 下拉菜单内容组件在多选状态下的确认按钮组件
final Widget? confirmWidget;

/// 下拉菜单内容组件在多选状态下的按钮组件的样式
final DropDownButtonStyle buttonStyle;

/// 下拉菜单内容组件在多选状态下的重置按钮组件的点击事件
final OnDropDownItemsReset? onDropDownItemsReset;

/// 下拉菜单内容组件在多选状态下的确认按钮组件的点击事件
final OnDropDownItemsConfirm? onDropDownItemsConfirm;

/// 下拉菜单选择确认后触发的回调事件，用于通过回调的返回值更新header组件的文本，使用该回调时headerIndex不应该为null
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

### DropDownGridView

`DropDownGridView` 是下拉菜单的基础实现，内部使用 `GridView` 实现，支持单选和多选操作。

参数说明：

```dart
/// 下拉菜单的控制器
final DropDownController controller;

/// 下拉菜单内容组件的数据
final List<DropDownItem> items;

/// 下拉菜单内容组件对应头部组件中的位置索引
final int? headerIndex;

/// 下拉菜单内容组件的子项的列数
final int crossAxisCount;

/// 下拉菜单内容组件的子项的行间距
final double mainAxisSpacing;

/// 下拉菜单内容组件的子项的列间距
final double crossAxisSpacing;

/// 下拉菜单内容组件的边框样式
final DropDownBoxStyle boxStyle;

/// 下拉菜单内容组件的Item样式
final DropDownItemStyle itemStyle;

/// 下拉菜单内容组件的子项的构建器，用于自定义Item
final IndexedWidgetBuilder? itemBuilder;

/// 下拉菜单内容组件的子项的点击事件
final OnDropDownItemTap? onDropDownItemTap;

/// 下拉菜单内容组件的子项的选中状态改变时的回调监听事件
final OnDropDownItemChanged? onDropDownItemChanged;

/// 下拉菜单内容组件的子项的最大多选数量
final int? maxMultiChoiceSize;

/// 下拉菜单内容组件的子项的多选数量超过最大值时触发的回调事件
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded;

/// 下拉菜单内容组件在多选状态下的按钮组件
final Widget? btnWidget;

/// 下拉菜单内容组件在多选状态下的重置按钮组件
final Widget? resetWidget;

/// 下拉菜单内容组件在多选状态下的确认按钮组件
final Widget? confirmWidget;

/// 下拉菜单内容组件在多选状态下的按钮组件的样式
final DropDownButtonStyle buttonStyle;

/// 下拉菜单内容组件在多选状态下的重置按钮组件的点击事件
final OnDropDownItemsReset? onDropDownItemsReset;

/// 下拉菜单内容组件在多选状态下的确认按钮组件的点击事件
final OnDropDownItemsConfirm? onDropDownItemsConfirm;

/// 下拉菜单选择确认后触发的回调事件，用于通过回调的返回值更新header组件的文本，使用该回调时headerIndex不应该为null
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

### DropDownCascadeList

`DropDownCascadeList` 是下拉菜单的基础实现，级联列表，支持单选和多选操作。

参数说明：

```dart
/// 下拉菜单的控制器
final DropDownController controller;

/// 下拉菜单的数据控制器
final DropDownCascadeListDataController? dataController;

/// 下拉菜单内容组件的数据
final List<DropDownItem<List<DropDownItem>>> items;

/// 下拉菜单内容组件对应头部组件中的位置索引
final int? headerIndex;

/// 下拉菜单内容组件的边框样式
final DropDownBoxStyle boxStyle;

/// 下拉菜单内容组件的第一层级的子项的样式
final DropDownItemStyle firstFloorItemStyle;

/// 下拉菜单内容组件的第一层级的子项的构建器，用于自定义Item
final IndexedWidgetBuilder? firstFloorItemBuilder;

/// 下拉菜单内容组件的第一层级的子项的点击事件
final OnDropDownItemTap? onFirstFloorItemTap;

/// 下拉菜单内容组件的第二层级的子项的样式
final DropDownItemStyle secondFloorItemStyle;

/// 下拉菜单内容组件的第二层级的子项的构建器，用于自定义Item
final IndexedWidgetBuilder? secondFloorItemBuilder;

/// 下拉菜单内容组件的第二层级的子项的点击事件
final OnDropDownItemTap? onSecondFloorItemTap;

/// 下拉菜单内容组件的第二层级的子项的选中状态改变时的回调监听事件
final OnDropDownItemChanged? onSecondFloorItemChanged;

/// 下拉菜单内容组件的子项的最大多选数量
final int? maxMultiChoiceSize;

/// 下拉菜单内容组件的子项的多选数量超过最大值时触发的回调事件
final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded;

/// 下拉菜单内容组件在多选状态下的按钮组件
final Widget? btnWidget;

/// 下拉菜单内容组件在多选状态下的重置按钮组件
final Widget? resetWidget;

/// 下拉菜单内容组件在多选状态下的确认按钮组件
final Widget? confirmWidget;

/// 下拉菜单内容组件在多选状态下的按钮组件的样式
final DropDownButtonStyle buttonStyle;

/// 下拉菜单内容组件在多选状态下的重置按钮组件的点击事件
final OnDropDownItemsReset? onDropDownItemsReset;

/// 下拉菜单内容组件在多选状态下的确认按钮组件的点击事件
final OnDropDownItemsConfirm? onDropDownItemsConfirm;

/// 下拉菜单选择确认后触发的回调事件，用于通过回调的返回值更新header组件的文本，使用该回调时headerIndex不应该为null
final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;
```

## 使用

### 使用 `Overlay` 实现下拉菜单，[具体代码](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo1.dart)

```dart
DropDownMenu(
  // 下拉菜单的控制器
  controller: dropDownController,
  // 下拉菜单的销毁控制器
  disposeController: dropDownDisposeController,
  // 下拉菜单的头部组件的样式
  headerItemStyle: const DropDownItemStyle(
    activeIconColor: Colors.blue,
    activeTextStyle: TextStyle(color: Colors.blue),
  ),
  // 下拉菜单的头部组件的数据
  headerItems: List.generate(
    4,
    (index) => DropDownItem<Tab>(
      text: "Tab $index",
      icon: const Icon(Icons.arrow_drop_down),
      activeIcon: const Icon(Icons.arrow_drop_up),
    ),
  ),
  // 下拉菜单的内容组件的 Y 轴偏移量
  viewOffsetY: MediaQuery.of(context).padding.top + 50,
  // 下拉菜单的内容组件
  viewBuilders: [
    DropDownListView(
      controller: dropDownController,
      items: items1,
      headerIndex: 0,
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

### 使用 `Stack` 实现下拉菜单，[具体代码](https://github.com/windows7lake/ll_dropdown_menu/blob/main/example/lib/drop_down_demo2.dart)

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

Overlay实现:
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

Stack实现：

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