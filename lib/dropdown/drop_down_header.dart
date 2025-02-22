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

  /// The selected state change event of the child item of the drop-down menu header component
  final OnDropDownItemChanged? onItemChanged;

  /// The expansion state change event of the drop-down menu
  final OnDropDownExpandStateChanged? onExpandStateChanged;

  /// Whether the drop-down menu header is scrollable
  final ScrollPhysics? physics;

  const DropDownHeader({
    super.key,
    required this.controller,
    required this.items,
    this.boxStyle = const DropDownBoxStyle(height: 50),
    this.itemStyle = const DropDownItemStyle(),
    this.onItemTap,
    this.onItemChanged,
    this.onExpandStateChanged,
    this.itemBuilder,
    this.dividerBuilder,
    this.physics,
  }) : assert(items.length > 0);

  @override
  State<DropDownHeader> createState() => _DropDownHeaderState();
}

class _DropDownHeaderState extends State<DropDownHeader> {
  double _width = 0;
  bool expand = false;

  @override
  void initState() {
    super.initState();
    assert(widget.boxStyle.height != null);
    intiController();
  }

  @override
  void didUpdateWidget(covariant DropDownHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(dropDownListener);
      intiController();
    }
  }

  void intiController() {
    widget.controller.headerStatus = widget.items
        .map((e) => DropDownHeaderStatus(text: e.text ?? ""))
        .toList();
    widget.controller.addListener(dropDownListener);
  }

  void dropDownListener() {
    if (expand != widget.controller.isExpand) {
      expand = widget.controller.isExpand;
      widget.onExpandStateChanged?.call(expand);
    }
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
        physics: widget.physics ?? NeverScrollableScrollPhysics(),
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
    DropDownHeaderStatus status = widget.controller.headerStatus[index];

    var item = widget.items[index];
    double width = _width;
    if (widget.boxStyle.expand) {
      width =
          (_width - widget.boxStyle.padding.horizontal) / widget.items.length -
              (widget.itemStyle.margin?.horizontal ?? 0);
    }

    Widget child = WrapperButton(
      onPressed: () {
        if (widget.onItemChanged != null) {
          widget.onItemChanged!(index, widget.items);
        }
        if (widget.onItemTap != null) {
          widget.onItemTap!(index, item);
          return;
        }
        widget.controller.toggle(index);
      },
      text: status.text.isEmpty ? item.text : status.text,
      textStyle: active
          ? widget.itemStyle.activeTextStyle
          : (status.highlight
              ? widget.itemStyle.highlightTextStyle
              : widget.itemStyle.textStyle),
      textAlign: widget.itemStyle.textAlign,
      textExpand: widget.itemStyle.textExpand,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      icon: active
          ? (item.activeIcon ?? widget.itemStyle.activeIcon)
          : (status.highlight
              ? widget.itemStyle.highlightIcon
              : (item.icon ?? widget.itemStyle.icon)),
      iconColor: active
          ? widget.itemStyle.activeIconColor
          : (status.highlight
              ? widget.itemStyle.highlightIconColor
              : widget.itemStyle.iconColor),
      iconSize: active
          ? widget.itemStyle.activeIconSize
          : (status.highlight
              ? widget.itemStyle.highlightIconSize
              : widget.itemStyle.iconSize),
      iconPosition: widget.itemStyle.iconPosition,
      gap: widget.itemStyle.gap,
      padding: widget.itemStyle.padding,
      width: width,
      height: widget.itemStyle.height,
      alignment: widget.itemStyle.alignment,
      borderSide: active
          ? widget.itemStyle.activeBorderSide
          : (status.highlight
              ? widget.itemStyle.highlightBorderSide
              : widget.itemStyle.borderSide),
      borderRadius: active
          ? widget.itemStyle.activeBorderRadius
          : (status.highlight
              ? widget.itemStyle.highlightBorderRadius
              : widget.itemStyle.borderRadius),
      backgroundColor: active
          ? widget.itemStyle.activeBackgroundColor
          : (status.highlight
              ? widget.itemStyle.highlightBackgroundColor
              : widget.itemStyle.backgroundColor),
      elevation: widget.itemStyle.elevation,
    );

    if (widget.itemStyle.decoration != null && !active) {
      var decoration = widget.itemStyle.decoration!;
      if (status.highlight && widget.itemStyle.highlightDecoration != null) {
        decoration = widget.itemStyle.highlightDecoration!;
      }
      child = DecoratedBox(
        decoration: decoration,
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

    if (widget.itemStyle.painter != null && !active) {
      child = CustomPaint(
        size: Size(width, widget.itemStyle.height),
        painter: widget.itemStyle.painter!,
        child: child,
      );
    }
    if (widget.itemStyle.activePainter != null && active) {
      child = CustomPaint(
        size: Size(width, widget.itemStyle.height),
        painter: widget.itemStyle.activePainter!,
        child: child,
      );
    }

    return child;
  }

  Widget divider(BuildContext context, int index) {
    return const SizedBox();
  }
}
