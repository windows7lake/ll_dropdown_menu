import 'package:flutter/material.dart' hide IndexedWidgetBuilder;

import '../button/text_button.dart';
import '../sliver/sliver_grid_delegate_height.dart';
import 'drop_down_controller.dart';
import 'drop_down_style.dart';
import 'drop_down_typedef.dart';

/// The basic implementation of the drop-down menu. It is implemented internally
/// using `GridView` and supports single-selection and multi-selection operations.
class DropDownGridView extends StatefulWidget {
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

  /// The maximum height of the drop-down menu content body
  final double maxHeight;

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

  const DropDownGridView({
    super.key,
    required this.controller,
    required this.items,
    required this.crossAxisCount,
    this.headerIndex,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.boxStyle = const DropDownBoxStyle(),
    this.itemStyle = const DropDownItemStyle(
      activeBackgroundColor: Color(0xFFF5F5F5),
      activeIconColor: Colors.blue,
      activeTextStyle: const TextStyle(color: Colors.blue),
    ),
    this.itemBuilder,
    this.onDropDownItemTap,
    this.onDropDownItemChanged,
    this.maxMultiChoiceSize,
    this.onDropDownItemLimitExceeded,
    this.maxHeight = 300,
    this.btnWidget,
    this.resetWidget,
    this.confirmWidget,
    this.buttonStyle = const DropDownButtonStyle(),
    this.onDropDownItemsReset,
    this.onDropDownItemsConfirm,
    this.onDropDownHeaderUpdate,
  });

  @override
  State<DropDownGridView> createState() => _DropDownGridViewState();
}

class _DropDownGridViewState extends State<DropDownGridView> {
  List<DropDownItem> items = [];
  List<DropDownItem> confirmItems = [];
  bool multipleChoice = false;

  @override
  void initState() {
    super.initState();
    multipleChoice =
        widget.maxMultiChoiceSize != null && widget.maxMultiChoiceSize! > 0;
    items = List.generate(
      widget.items.length,
      (index) => widget.items[index].copyWith(),
    );
    confirmItems = List.generate(
      widget.items.length,
      (index) => widget.items[index].copyWith(),
    );
    widget.controller.addListener(dropDownListener);
  }

  void dropDownListener() {
    if (!multipleChoice) return;
    if (widget.controller.isExpand) {
      items = List.generate(
        confirmItems.length,
        (index) => confirmItems[index].copyWith(),
      );
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: widget.boxStyle.width,
        height: widget.boxStyle.height,
        margin: widget.boxStyle.margin,
        decoration: widget.boxStyle.decoration ??
            BoxDecoration(
              color: widget.boxStyle.backgroundColor,
              border: widget.boxStyle.border,
            ),
        child: multipleChoice ? multipleChoiceList() : singleChoiceList(),
      ),
    );
  }

  Widget singleChoiceList() {
    return GridView.builder(
      padding: widget.boxStyle.padding,
      gridDelegate: SliverGridDelegateWithFixedHeight(
        crossAxisCount: widget.crossAxisCount,
        mainAxisSpacing: widget.mainAxisSpacing,
        crossAxisSpacing: widget.crossAxisSpacing,
        height: widget.itemStyle.height,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (widget.itemBuilder != null) {
          return widget.itemBuilder!(context, index, items[index].check);
        }
        return gridItem(context, index, false);
      },
    );
  }

  Widget multipleChoiceList() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.maxHeight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: GridView.builder(
                padding: widget.boxStyle.padding,
                gridDelegate: SliverGridDelegateWithFixedHeight(
                  crossAxisCount: widget.crossAxisCount,
                  mainAxisSpacing: widget.mainAxisSpacing,
                  crossAxisSpacing: widget.crossAxisSpacing,
                  height: widget.itemStyle.height,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  if (widget.itemBuilder != null) {
                    return widget.itemBuilder!(
                        context, index, items[index].check);
                  }
                  return gridItem(context, index, true);
                },
              ),
            ),
            widget.btnWidget ??
                Row(children: [
                  Expanded(
                    child: widget.resetWidget ??
                        WrapperTextButton(
                          height: widget.buttonStyle.resetHeight,
                          text: widget.buttonStyle.resetText,
                          textStyle: widget.buttonStyle.resetTextStyle,
                          backgroundColor:
                              widget.buttonStyle.resetBackgroundColor,
                          onPressed: () {
                            for (var element in items) {
                              element.check = false;
                            }
                            setState(() {});
                            if (widget.onDropDownItemsReset != null) {
                              widget.onDropDownItemsReset!(items);
                            }
                          },
                        ),
                  ),
                  Expanded(
                    child: widget.confirmWidget ??
                        WrapperTextButton(
                          height: widget.buttonStyle.confirmHeight,
                          text: widget.buttonStyle.confirmText,
                          textStyle: widget.buttonStyle.confirmTextStyle,
                          backgroundColor:
                              widget.buttonStyle.confirmBackgroundColor,
                          onPressed: () {
                            setState(() {});
                            confirmItems = List.generate(
                              items.length,
                              (index) => items[index].copyWith(),
                            );
                            var checkItems = items
                                .where((element) => element.check)
                                .toList();
                            if (widget.onDropDownItemsConfirm != null) {
                              widget.onDropDownItemsConfirm!(checkItems);
                            }
                            if (widget.onDropDownHeaderUpdate != null) {
                              String? text =
                                  widget.onDropDownHeaderUpdate!(checkItems);
                              if (text != null) {
                                widget.controller.hide(
                                  index: widget.headerIndex,
                                  text: text,
                                );
                                return;
                              }
                            }
                            widget.controller.hide();
                          },
                        ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  Widget gridItem(BuildContext context, int index, bool multipleChoice) {
    var item = items[index];
    var active = item.check;
    List<Widget> children = [];
    if (item.icon != null || widget.itemStyle.icon != null) {
      children.add(IconTheme(
        data: IconThemeData(
          color: active
              ? widget.itemStyle.activeIconColor
              : widget.itemStyle.iconColor,
          size: active
              ? widget.itemStyle.activeIconSize
              : widget.itemStyle.iconSize,
        ),
        child: (active ? item.activeIcon : item.icon) ??
            (active ? widget.itemStyle.activeIcon : widget.itemStyle.icon) ??
            const SizedBox(),
      ));
    }
    if (item.text != null) {
      children.add(ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth:
              ((widget.boxStyle.width ?? MediaQuery.of(context).size.width) -
                          widget.boxStyle.margin.horizontal -
                          widget.boxStyle.padding.horizontal) /
                      widget.crossAxisCount -
                  widget.crossAxisSpacing * (widget.crossAxisCount - 1) -
                  widget.itemStyle.iconSize,
        ),
        child: Text(
          item.text ?? "",
          style: active
              ? widget.itemStyle.activeTextStyle
              : widget.itemStyle.textStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ));
    }

    Widget child = const SizedBox();
    if (children.isNotEmpty) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }

    return GestureDetector(
      onTap: () {
        if (widget.onDropDownItemChanged != null) {
          widget.onDropDownItemChanged!(items);
        }
        if (widget.onDropDownItemTap != null) {
          widget.onDropDownItemTap!(index, item);
          return;
        }

        if (multipleChoice) {
          int checkedCount = items.where((element) => element.check).length;
          if (!item.check &&
              widget.maxMultiChoiceSize != null &&
              checkedCount >= widget.maxMultiChoiceSize!) {
            widget.onDropDownItemLimitExceeded?.call(items);
            return;
          }
          item.check = !item.check;
        } else {
          for (var element in items) {
            element.check = false;
          }
          item.check = true;
          if (widget.onDropDownHeaderUpdate != null) {
            String? text = widget.onDropDownHeaderUpdate!([item]);
            if (text != null) {
              setState(() {});
              widget.controller.hide(index: widget.headerIndex, text: text);
              return;
            }
          }
          widget.controller.hide(index: widget.headerIndex);
        }
        setState(() {});
      },
      child: Container(
        width: widget.itemStyle.width,
        height: widget.itemStyle.height,
        alignment: widget.itemStyle.alignment,
        margin: widget.itemStyle.margin,
        padding: widget.itemStyle.padding,
        decoration: (active
                ? widget.itemStyle.activeDecoration
                : widget.itemStyle.decoration) ??
            BoxDecoration(
              color: active
                  ? widget.itemStyle.activeBackgroundColor
                  : widget.itemStyle.backgroundColor,
              border: active
                  ? widget.itemStyle.activeBorder
                  : widget.itemStyle.border,
              borderRadius: BorderRadius.circular(active
                  ? widget.itemStyle.activeBorderRadius
                  : widget.itemStyle.borderRadius),
            ),
        child: child,
      ),
    );
  }
}
