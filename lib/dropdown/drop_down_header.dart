import 'package:flutter/material.dart';

import 'drop_down_controller.dart';
import 'drop_down_typedef.dart' hide IndexedWidgetBuilder;

class DropDownHeader extends StatefulWidget {
  final DropDownController controller;
  final List<DropDownItem> items;
  final double? width;
  final double height;
  final Color backgroundColor;
  final BoxBorder? border;
  final Decoration? decoration;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool expand;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final double iconSize;
  final double activeIconSize;
  final Color iconColor;
  final Color activeIconColor;
  final Decoration? itemDecoration;
  final Decoration? activeItemDecoration;
  final EdgeInsetsGeometry itemMargin;
  final EdgeInsetsGeometry itemPadding;
  final AlignmentGeometry itemAlignment;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? dividerBuilder;
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
