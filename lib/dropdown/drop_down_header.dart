import 'package:flutter/material.dart';

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
    List<Widget> children = [];
    if (item.text != null) {
      var text = widget.controller.headerText.elementAt(index);
      children.add(Expanded(
        flex: widget.itemStyle.textExpand ? 1 : 0,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (_width -
                        widget.itemStyle.margin.horizontal -
                        widget.itemStyle.padding.horizontal) /
                    widget.items.length -
                widget.itemStyle.iconSize -
                widget.itemStyle.margin.horizontal -
                widget.itemStyle.padding.horizontal,
          ),
          child: Text(
            text.isEmpty ? item.text! : text,
            style: active
                ? widget.itemStyle.activeTextStyle
                : widget.itemStyle.textStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ));
    }
    if (item.icon != null) {
      children.add(IconTheme(
        data: IconThemeData(
          color: active
              ? widget.itemStyle.activeIconColor
              : widget.itemStyle.iconColor,
          size: active
              ? widget.itemStyle.activeIconSize
              : widget.itemStyle.iconSize,
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
    if (widget.boxStyle.expand) {
      double width =
          (_width - widget.boxStyle.padding.horizontal) / widget.items.length -
              widget.itemStyle.margin.horizontal -
              widget.itemStyle.padding.horizontal;
      child = Container(
        width: widget.itemStyle.width ?? width,
        height: widget.itemStyle.height,
        margin: widget.itemStyle.margin,
        padding: widget.itemStyle.padding,
        alignment: widget.itemStyle.alignment,
        decoration: active
            ? widget.itemStyle.activeDecoration
            : widget.itemStyle.decoration,
        child: child,
      );
    } else if (widget.itemStyle.activeDecoration != null &&
        widget.itemStyle.decoration != null) {
      child = Container(
        width: widget.itemStyle.width,
        height: widget.itemStyle.height,
        margin: widget.itemStyle.margin,
        padding: widget.itemStyle.padding,
        decoration: active
            ? widget.itemStyle.activeDecoration!
            : widget.itemStyle.decoration!,
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
