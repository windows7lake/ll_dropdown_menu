import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/button/text_button.dart';

import 'drop_down_controller.dart';
import 'drop_down_style.dart';
import 'drop_down_typedef.dart' hide IndexedWidgetBuilder;

/// Drop-down menu header
class DropDownHeader extends StatefulWidget {
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

  const DropDownHeader({
    super.key,
    required this.controller,
    required this.items,
    this.boxStyle = const DropDownBoxStyle(height: 50),
    this.itemStyle = const DropDownItemStyle(),
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
    assert(widget.boxStyle.height != null);
    widget.controller.headerText =
        widget.items.map((e) => e.text ?? "").toList();
    widget.controller.addListener(dropDownListener);
  }

  void dropDownListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _width = (widget.boxStyle.width ?? screenWidth) -
        widget.boxStyle.margin.horizontal;
    return Container(
      width: _width,
      height: widget.boxStyle.height,
      margin: widget.boxStyle.margin,
      padding: widget.boxStyle.padding,
      decoration: widget.boxStyle.decoration ??
          BoxDecoration(
            color: widget.boxStyle.backgroundColor,
            border: widget.boxStyle.border,
          ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: widget.itemBuilder ?? listItem,
        separatorBuilder: widget.dividerBuilder ?? divider,
      ),
    );
  }

  Widget listItem(BuildContext context, int index) {
    bool active =
        widget.controller.isExpand && widget.controller.headerIndex == index;
    var item = widget.items[index];
    String text = widget.controller.headerText.elementAt(index);
    double width = _width;
    if (widget.boxStyle.expand) {
      width =
          (_width - widget.boxStyle.padding.horizontal) / widget.items.length -
              (widget.itemStyle.margin?.horizontal ?? 0);
    }

    Widget child = WrapperButton(
      onPressed: () {
        if (widget.onItemTap != null) {
          widget.onItemTap!(index, item);
          return;
        }
        widget.controller.toggle(index);
      },
      text: text.isEmpty ? item.text : text,
      textStyle: active
          ? widget.itemStyle.activeTextStyle
          : widget.itemStyle.textStyle,
      textAlign: widget.itemStyle.textAlign,
      textExpand: widget.itemStyle.textExpand,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      icon: active
          ? (item.activeIcon ?? widget.itemStyle.activeIcon)
          : (item.icon ?? widget.itemStyle.icon),
      iconColor: active
          ? widget.itemStyle.activeIconColor
          : widget.itemStyle.iconColor,
      iconSize:
          active ? widget.itemStyle.activeIconSize : widget.itemStyle.iconSize,
      iconPosition: widget.itemStyle.iconPosition,
      gap: widget.itemStyle.gap,
      padding: widget.itemStyle.padding,
      width: width,
      height: widget.itemStyle.height,
      alignment: widget.itemStyle.alignment,
      borderSide: active
          ? widget.itemStyle.activeBorderSide
          : widget.itemStyle.borderSide,
      borderRadius: active
          ? widget.itemStyle.activeBorderRadius
          : widget.itemStyle.borderRadius,
      backgroundColor: active
          ? widget.itemStyle.activeBackgroundColor
          : widget.itemStyle.backgroundColor,
    );

    if (widget.itemStyle.decoration != null && !active) {
      child = DecoratedBox(
        decoration: widget.itemStyle.decoration!,
        child: child,
      );
    }
    if (widget.itemStyle.activeDecoration != null && active) {
      child = DecoratedBox(
        decoration: widget.itemStyle.activeDecoration!,
        child: child,
      );
    }

    if (widget.itemStyle.margin != null) {
      child = Padding(
        padding: widget.itemStyle.margin!,
        child: child,
      );
    }

    return child;
  }

  Widget divider(BuildContext context, int index) {
    return const SizedBox();
  }
}
