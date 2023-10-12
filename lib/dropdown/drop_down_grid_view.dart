import 'package:flutter/material.dart' hide IndexedWidgetBuilder;

import '../button/text_button.dart';
import '../sliver/sliver_grid_delegate_height.dart';
import 'drop_down_controller.dart';
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

  /// Padding of the drop-down menu content body
  final EdgeInsetsGeometry? padding;

  /// The number of columns of the sub-items of the drop-down menu content body
  final int crossAxisCount;

  /// The line spacing of the sub-items of the drop-down menu content body
  final double mainAxisSpacing;

  /// Column spacing of the sub-items of the drop-down menu content body
  final double crossAxisSpacing;

  /// The height of the child items of the drop-down menu content body
  final double itemHeight;

  /// Text style of the sub-items of the drop-down menu content body
  final TextStyle textStyle;

  /// Text style when the sub-item of the drop-down menu content body is selected
  final TextStyle activeTextStyle;

  /// The icon of the child item of the drop-down menu content body
  final Widget? icon;

  /// The icon when the sub-item of the drop-down menu content body is selected
  final Widget? activeIcon;

  /// The icon size of the sub-items of the drop-down menu content body
  final double iconSize;

  /// The size of the icon when the sub-item of the drop-down menu content body is selected
  final double activeIconSize;

  /// The icon color of the sub-items of the drop-down menu content body
  final Color iconColor;

  /// The color of the icon when the sub-item of the drop-down menu content body is selected
  final Color activeIconColor;

  /// The background color of the child items of the drop-down menu content body
  final Color itemBackgroundColor;

  /// The background color of the sub-item of the drop-down menu content body when it is selected
  final Color itemActiveBackgroundColor;

  /// The border of the child item of the drop-down menu content body
  final BoxBorder? itemBorder;

  /// The border when the sub-item of the drop-down menu content body is selected
  final BoxBorder? itemActiveBorder;

  /// Decorator for the sub-items of the drop-down menu content body, used to set background color, borders, etc.
  final Decoration? itemDecoration;

  /// Decorator when the sub-item of the drop-down menu content body is selected, used to set the background color, border, etc.
  final Decoration? activeItemDecoration;

  /// The corner radius of the child items of the drop-down menu content body
  final double itemBorderRadius;

  /// Alignment of the sub-items of the drop-down menu content body
  final AlignmentGeometry itemAlignment;

  /// Padding of the sub-items of the drop-down menu content body
  final EdgeInsetsGeometry? itemPadding;

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
  final double? maxListHeight;

  /// Whether the content body of the drop-down menu supports multiple selections
  final bool multipleChoice;

  /// Button component of the drop-down menu content body in the multi-select state
  final Widget? btnWidget;

  /// The reset button component of the drop-down menu content body in the multi-select state
  final Widget? resetWidget;

  /// The confirmation button component of the drop-down menu content body in the multi-select state
  final Widget? confirmWidget;

  /// The height of the reset button component of the drop-down menu content body in the multi-select state
  final double resetHeight;

  /// The height of the confirmation button component of the drop-down menu content body in the multi-select state
  final double confirmHeight;

  /// The text of the reset button component of the drop-down menu content body in the multi-select state
  final String resetText;

  /// The text of the confirmation button component of the drop-down menu content body in the multi-select state
  final String confirmText;

  /// The text style of the reset button component of the drop-down menu content body in the multi-select state
  final TextStyle resetTextStyle;

  /// The text style of the confirmation button component of the drop-down menu content body in the multi-select state
  final TextStyle confirmTextStyle;

  /// The background color of the reset button component of the drop-down menu content body in the multi-select state
  final Color resetBackgroundColor;

  /// The background color of the confirmation button component of the drop-down menu content body in the multi-select state
  final Color confirmBackgroundColor;

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
    this.padding = const EdgeInsets.all(16),
    this.headerIndex,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.itemHeight = 50,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.activeTextStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.icon,
    this.activeIcon,
    this.iconSize = 20,
    this.activeIconSize = 20,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.black,
    this.itemBackgroundColor = const Color(0xFFF6F6F6),
    this.itemActiveBackgroundColor = const Color(0xFF42A5F5),
    this.itemBorder,
    this.itemActiveBorder,
    this.itemDecoration,
    this.activeItemDecoration,
    this.itemBorderRadius = 4,
    this.itemAlignment = Alignment.center,
    this.itemPadding,
    this.itemBuilder,
    this.onDropDownItemTap,
    this.onDropDownItemChanged,
    this.maxMultiChoiceSize,
    this.onDropDownItemLimitExceeded,
    this.maxListHeight,
    this.multipleChoice = false,
    this.btnWidget,
    this.resetWidget,
    this.confirmWidget,
    this.resetHeight = 50,
    this.confirmHeight = 50,
    this.resetText = "Reset",
    this.confirmText = "Confirm",
    this.resetTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.confirmTextStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.resetBackgroundColor = const Color(0xFFEEEEEE),
    this.confirmBackgroundColor = Colors.blue,
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

  @override
  void initState() {
    super.initState();
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
    if (!widget.multipleChoice) return;
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
      child: widget.multipleChoice ? multipleChoiceList() : singleChoiceList(),
    );
  }

  Widget singleChoiceList() {
    return GridView.builder(
      padding: widget.padding,
      gridDelegate: SliverGridDelegateWithFixedHeight(
        crossAxisCount: widget.crossAxisCount,
        mainAxisSpacing: widget.mainAxisSpacing,
        crossAxisSpacing: widget.crossAxisSpacing,
        height: widget.itemHeight,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.maxListHeight ??
                widget.itemHeight * 4 +
                    widget.mainAxisSpacing * 3 +
                    (widget.padding?.vertical ?? 0),
            child: GridView.builder(
              padding: widget.padding,
              gridDelegate: SliverGridDelegateWithFixedHeight(
                crossAxisCount: widget.crossAxisCount,
                mainAxisSpacing: widget.mainAxisSpacing,
                crossAxisSpacing: widget.crossAxisSpacing,
                height: widget.itemHeight,
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
                        height: widget.resetHeight,
                        text: widget.resetText,
                        textStyle: widget.resetTextStyle,
                        backgroundColor: widget.resetBackgroundColor,
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
                        height: widget.confirmHeight,
                        text: widget.confirmText,
                        textStyle: widget.confirmTextStyle,
                        backgroundColor: widget.confirmBackgroundColor,
                        onPressed: () {
                          setState(() {});
                          confirmItems = List.generate(
                            items.length,
                            (index) => items[index].copyWith(),
                          );
                          var checkItems =
                              items.where((element) => element.check).toList();
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
    );
  }

  Widget gridItem(BuildContext context, int index, bool multipleChoice) {
    var item = items[index];
    var active = item.check;
    List<Widget> children = [];
    if (item.icon != null || widget.icon != null) {
      children.add(IconTheme(
        data: IconThemeData(
          color: active ? widget.activeIconColor : widget.iconColor,
          size: active ? widget.activeIconSize : widget.iconSize,
        ),
        child: (active ? item.activeIcon : item.icon) ??
            (active ? widget.activeIcon : widget.icon) ??
            const SizedBox(),
      ));
    }
    if (item.text != null) {
      children.add(ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (MediaQuery.of(context).size.width -
                      widget.padding!.horizontal -
                      widget.crossAxisSpacing * (widget.crossAxisCount - 1)) /
                  widget.crossAxisCount -
              widget.activeIconSize,
        ),
        child: Text(
          item.text ?? "",
          style: active ? widget.activeTextStyle : widget.textStyle,
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

        if (widget.multipleChoice) {
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
        height: widget.itemHeight,
        alignment: widget.itemAlignment,
        padding: widget.itemPadding,
        decoration:
            (active ? widget.activeItemDecoration : widget.itemDecoration) ??
                BoxDecoration(
                  color: active
                      ? widget.itemActiveBackgroundColor
                      : widget.itemBackgroundColor,
                  border: active ? widget.itemActiveBorder : widget.itemBorder,
                  borderRadius: BorderRadius.circular(widget.itemBorderRadius),
                ),
        child: child,
      ),
    );
  }
}
