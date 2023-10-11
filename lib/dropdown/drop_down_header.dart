import 'package:flutter/material.dart';

import 'drop_down_controller.dart';
import 'drop_down_typedef.dart' hide IndexedWidgetBuilder;

/// Drop-down menu header
class DropDownHeader extends StatefulWidget {
  /// Controller of the drop-down menu
  final DropDownController controller;

  /// Data of the drop-down menu header component
  final List<DropDownItem> items;

  /// Width of the drop-down menu header component
  final double? width;

  /// Height of the drop-down menu header component
  final double height;

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

  /// Text style of the drop-down menu header component
  final TextStyle textStyle;

  /// Text style when the drop-down menu header component is selected
  final TextStyle activeTextStyle;

  /// The icon size of the drop-down menu header component
  final double iconSize;

  /// The icon size when the drop-down menu header component is selected
  final double activeIconSize;

  /// The icon color of the drop-down menu header component
  final Color iconColor;

  /// The color of the icon when the drop-down menu header component is selected
  final Color activeIconColor;

  /// Decorator for the sub-items of the drop-down menu header component, used to set the background color, border, etc.
  final Decoration? itemDecoration;

  /// The decorator of the sub-item when the drop-down menu header component is selected, used to set the background color, border, etc.
  final Decoration? activeItemDecoration;

  /// Margins of the sub-items of the drop-down menu header component
  final EdgeInsetsGeometry itemMargin;

  /// Padding of the child items of the drop-down menu header component
  final EdgeInsetsGeometry itemPadding;

  /// Alignment of the sub-items of the drop-down menu header component
  final AlignmentGeometry itemAlignment;

  /// Builder for the sub-items of the drop-down menu header component, used to customize Item
  final NullableIndexedWidgetBuilder? itemBuilder;

  /// Builder of the dividing line between the children of the drop-down menu header component, used to customize the dividing line
  final IndexedWidgetBuilder? dividerBuilder;

  /// Click event of the child item of the drop-down menu header component
  final OnDropDownHeaderItemTap? onItemTap;

  const DropDownHeader({
    super.key,
    required this.controller,
    required this.items,
    this.width,
    this.height = 50,
    this.backgroundColor = Colors.transparent,
    this.border,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.expand = true,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.activeTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.iconSize = 20,
    this.activeIconSize = 20,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.black,
    this.itemDecoration,
    this.activeItemDecoration,
    this.itemMargin = EdgeInsets.zero,
    this.itemPadding = EdgeInsets.zero,
    this.itemAlignment = Alignment.center,
    this.onItemTap,
    this.itemBuilder,
    this.dividerBuilder,
  }) : assert(items.length > 0);

  @override
  State<DropDownHeader> createState() => _DropDownHeaderState();
}

class _DropDownHeaderState extends State<DropDownHeader> {
  double _width = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.headerText =
        widget.items.map((e) => e.text ?? "").toList();
    widget.controller.addListener(dropDownListener);
  }

  void dropDownListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _width = (widget.width ?? MediaQuery.of(context).size.width) -
        widget.margin.horizontal;
    return Container(
      width: _width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      decoration: widget.decoration ??
          BoxDecoration(
            color: widget.backgroundColor,
            border: widget.border,
          ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: widget.itemBuilder ?? gridItem,
        separatorBuilder: widget.dividerBuilder ?? divider,
      ),
    );
  }

  Widget gridItem(BuildContext context, int index) {
    bool active =
        widget.controller.isExpand && widget.controller.headerIndex == index;
    var item = widget.items[index];
    List<Widget> children = [];
    if (item.text != null) {
      var text = widget.controller.headerText.elementAt(index);
      children.add(ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (_width - widget.padding.horizontal) / widget.items.length -
              widget.iconSize,
        ),
        child: Text(
          text.isEmpty ? item.text! : text,
          style: active ? widget.activeTextStyle : widget.textStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ));
    }
    if (item.icon != null) {
      children.add(IconTheme(
        data: IconThemeData(
          color: active ? widget.activeIconColor : widget.iconColor,
          size: active ? widget.activeIconSize : widget.iconSize,
        ),
        child: active ? item.activeIcon! : item.icon!,
      ));
    }

    Widget child = const SizedBox();
    if (children.isNotEmpty) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
    if (widget.expand) {
      child = Container(
        width: (_width - widget.padding.horizontal) / widget.items.length -
            widget.itemMargin.horizontal,
        margin: widget.itemMargin,
        padding: widget.itemPadding,
        alignment: widget.itemAlignment,
        decoration:
            active ? widget.activeItemDecoration : widget.itemDecoration,
        child: child,
      );
    } else if (widget.activeItemDecoration != null &&
        widget.itemDecoration != null) {
      child = Container(
        margin: widget.itemMargin,
        padding: widget.itemPadding,
        decoration:
            active ? widget.activeItemDecoration! : widget.itemDecoration!,
        child: child,
      );
    }
    return GestureDetector(
      onTap: () {
        if (widget.onItemTap != null) {
          widget.onItemTap!(index, item);
          return;
        }
        widget.controller.toggle(index);
      },
      child: child,
    );
  }

  Widget divider(BuildContext context, int index) {
    return const SizedBox();
  }
}
