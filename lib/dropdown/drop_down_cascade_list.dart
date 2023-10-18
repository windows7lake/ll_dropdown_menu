import 'dart:math' as math;

import 'package:flutter/material.dart' hide IndexedWidgetBuilder;

import '../button/text_button.dart';
import 'drop_down_controller.dart';
import 'drop_down_style.dart';
import 'drop_down_typedef.dart';

/// The basic implementation of drop-down menu, cascading list, supporting
/// single-selection and multi-selection operations.
class DropDownCascadeList extends DropDownViewStatefulWidget {
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

  /// Callback event triggered after the drop-down menu selection is confirmed, used to update the status of the header component by the return value of the callback
  /// headerIndex should not be null when using this callback
  final OnDropDownHeaderUpdate? onDropDownHeaderUpdate;

  const DropDownCascadeList({
    super.key,
    required this.controller,
    required this.items,
    this.headerIndex,
    this.boxStyle = const DropDownBoxStyle(),
    this.firstFloorItemStyle = const DropDownItemStyle(
      backgroundColor: const Color(0xFFF5F5F5),
      activeBackgroundColor: const Color(0xFFFEFEFE),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    ),
    this.firstFloorItemBuilder,
    this.onFirstFloorItemTap,
    this.secondFloorItemStyle = const DropDownItemStyle(
      backgroundColor: Colors.white,
      activeBackgroundColor: const Color(0xFFF5F5F5),
      activeTextStyle: const TextStyle(fontSize: 14, color: Colors.blue),
      activeIconColor: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
    ),
    this.secondFloorItemBuilder,
    this.onSecondFloorItemTap,
    this.onSecondFloorItemChanged,
    this.maxMultiChoiceSize,
    this.onDropDownItemLimitExceeded,
    this.btnWidget,
    this.resetWidget,
    this.confirmWidget,
    this.buttonStyle = const DropDownButtonStyle(),
    this.onDropDownItemsReset,
    this.onDropDownItemsConfirm,
    this.onDropDownHeaderUpdate,
  });

  @override
  State<DropDownCascadeList> createState() => _DropDownCascadeListState();

  @override
  double get actualHeight =>
      boxStyle.height ??
      firstFloorItemStyle.height * items.length +
          boxStyle.margin.vertical +
          boxStyle.padding.vertical +
          (firstFloorItemStyle.margin?.vertical ?? 0) +
          ((maxMultiChoiceSize != null && maxMultiChoiceSize! > 0)
              ? math.max(buttonStyle.resetHeight, buttonStyle.confirmHeight)
              : 0);
}

class _DropDownCascadeListState extends State<DropDownCascadeList> {
  List<DropDownItem<List<DropDownItem>>> items = [];
  List<DropDownItem<List<DropDownItem>>> confirmItems = [];
  bool multipleChoice = false;
  int firstFloorIndex = 0;
  int secondFloorIndex = 0;

  @override
  void initState() {
    super.initState();
    multipleChoice =
        widget.maxMultiChoiceSize != null && widget.maxMultiChoiceSize! > 0;
    if (widget.items.isNotEmpty) {
      widget.items.first.check = true;
    }
    items = List.generate(
      widget.items.length,
      (index) {
        var item = widget.items[index];
        return widget.items[index].copyWith(
          data: List.generate(
            item.data?.length ?? 0,
            (subIndex) => item.data![subIndex].copyWith(),
          ),
        );
      },
    );
    confirmItems = List.generate(
      widget.items.length,
      (index) {
        var item = widget.items[index];
        return widget.items[index].copyWith(
          data: List.generate(
            item.data?.length ?? 0,
            (subIndex) => item.data![subIndex].copyWith(),
          ),
        );
      },
    );
    widget.controller.addListener(dropDownListener);
  }

  void dropDownListener() {
    if (!multipleChoice) return;
    if (widget.controller.isExpand) {
      items = List.generate(
        confirmItems.length,
        (index) {
          var item = confirmItems[index];
          if (item.check) firstFloorIndex = index;
          return confirmItems[index].copyWith(
            data: List.generate(
              item.data?.length ?? 0,
              (subIndex) => item.data![subIndex].copyWith(),
            ),
          );
        },
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
        padding: widget.boxStyle.padding,
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
    Widget child = Row(children: [
      firstFloor(),
      secondFloor(),
    ]);
    if (widget.boxStyle.height != null) {
      child = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.boxStyle.height!,
        ),
        child: child,
      );
    }
    return child;
  }

  Widget multipleChoiceList() {
    Widget child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Row(children: [
            firstFloor(),
            secondFloor(),
          ]),
        ),
        widget.btnWidget ??
            Row(children: [
              Expanded(
                child: widget.resetWidget ??
                    WrapperButton(
                      height: widget.buttonStyle.resetHeight,
                      text: widget.buttonStyle.resetText,
                      textStyle: widget.buttonStyle.resetTextStyle,
                      textWeight: widget.buttonStyle.resetTextWeight,
                      textAlign: widget.buttonStyle.resetTextAlign,
                      backgroundColor: widget.buttonStyle.resetBackgroundColor,
                      elevation: widget.buttonStyle.resetElevation,
                      borderRadius: widget.buttonStyle.resetBorderRadius,
                      borderSide: widget.buttonStyle.resetBorderSide,
                      onPressed: () {
                        for (var element in items) {
                          if (element.data == null) continue;
                          for (var subElement in element.data!) {
                            subElement.check = false;
                          }
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
                    WrapperButton(
                      height: widget.buttonStyle.confirmHeight,
                      text: widget.buttonStyle.confirmText,
                      textStyle: widget.buttonStyle.confirmTextStyle,
                      textWeight: widget.buttonStyle.confirmTextWeight,
                      textAlign: widget.buttonStyle.confirmTextAlign,
                      backgroundColor:
                          widget.buttonStyle.confirmBackgroundColor,
                      elevation: widget.buttonStyle.confirmElevation,
                      borderRadius: widget.buttonStyle.confirmBorderRadius,
                      borderSide: widget.buttonStyle.confirmBorderSide,
                      onPressed: () {
                        setState(() {});
                        confirmItems = List.generate(
                          items.length,
                          (index) {
                            var item = items[index];
                            return items[index].copyWith(
                              data: List.generate(
                                item.data?.length ?? 0,
                                (subIndex) => item.data![subIndex].copyWith(),
                              ),
                            );
                          },
                        );
                        List<DropDownItem> checkItems = [];
                        for (var element in items) {
                          if (element.data == null) continue;
                          checkItems
                              .addAll(element.data!.where((e) => e.check));
                        }
                        if (widget.onDropDownItemsConfirm != null) {
                          widget.onDropDownItemsConfirm!(checkItems);
                        }
                        if (widget.onDropDownHeaderUpdate != null) {
                          DropDownHeaderStatus? status =
                              widget.onDropDownHeaderUpdate!(checkItems);
                          if (status != null) {
                            widget.controller.hide(
                              index: widget.headerIndex,
                              status: status,
                            );
                            return;
                          }
                        }
                        widget.controller.hide(
                          index: widget.headerIndex,
                          status: DropDownHeaderStatus(
                              highlight: checkItems.isNotEmpty),
                        );
                      },
                    ),
              ),
            ]),
      ],
    );

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.boxStyle.height ?? widget.actualHeight,
        ),
        child: child,
      ),
    );
  }

  Widget firstFloor() {
    double firstFloorItemWidth = widget.firstFloorItemStyle.width ??
        MediaQuery.of(context).size.width * 0.35;
    return Container(
      width: firstFloorItemWidth,
      color: widget.firstFloorItemStyle.backgroundColor,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          var active = item.check;

          Widget child = WrapperButton(
            onPressed: () {
              if (widget.onFirstFloorItemTap != null) {
                widget.onFirstFloorItemTap!(index, item);
                return;
              }
              firstFloorIndex = index;
              for (var element in items) {
                element.check = false;
              }
              item.check = true;
              setState(() {});
            },
            text: item.text,
            textStyle: active
                ? widget.firstFloorItemStyle.activeTextStyle
                : widget.firstFloorItemStyle.textStyle,
            textAlign: widget.firstFloorItemStyle.textAlign,
            textExpand: widget.firstFloorItemStyle.textExpand,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            icon: active
                ? (item.activeIcon ?? widget.firstFloorItemStyle.activeIcon)
                : (item.icon ?? widget.firstFloorItemStyle.icon),
            iconColor: active
                ? widget.firstFloorItemStyle.activeIconColor
                : widget.firstFloorItemStyle.iconColor,
            iconSize: active
                ? widget.firstFloorItemStyle.activeIconSize
                : widget.firstFloorItemStyle.iconSize,
            iconPosition: widget.firstFloorItemStyle.iconPosition,
            gap: widget.firstFloorItemStyle.gap,
            padding: widget.firstFloorItemStyle.padding,
            width: firstFloorItemWidth -
                (widget.firstFloorItemStyle.margin?.horizontal ?? 0),
            height: widget.firstFloorItemStyle.height,
            alignment: widget.firstFloorItemStyle.alignment,
            borderSide: active
                ? widget.firstFloorItemStyle.activeBorderSide
                : widget.firstFloorItemStyle.borderSide,
            borderRadius: active
                ? widget.firstFloorItemStyle.activeBorderRadius
                : widget.firstFloorItemStyle.borderRadius,
            backgroundColor: active
                ? widget.firstFloorItemStyle.activeBackgroundColor
                : widget.firstFloorItemStyle.backgroundColor,
            elevation: widget.firstFloorItemStyle.elevation,
          );

          if (widget.firstFloorItemStyle.decoration != null && !active) {
            child = DecoratedBox(
              decoration: widget.firstFloorItemStyle.decoration!,
              child: child,
            );
          }
          if (widget.firstFloorItemStyle.activeDecoration != null && active) {
            child = DecoratedBox(
              decoration: widget.firstFloorItemStyle.activeDecoration!,
              child: child,
            );
          }

          if (widget.firstFloorItemStyle.margin != null) {
            child = Padding(
              padding: widget.firstFloorItemStyle.margin!,
              child: child,
            );
          }

          return child;
        },
      ),
    );
  }

  Widget secondFloor() {
    List<DropDownItem> secondFloorItems = items[firstFloorIndex].data ?? [];
    double secondFloorItemWidth = widget.secondFloorItemStyle.width ??
        MediaQuery.of(context).size.width * 0.65;
    return Container(
      width: secondFloorItemWidth,
      color: widget.secondFloorItemStyle.backgroundColor,
      child: ListView.builder(
        itemCount: secondFloorItems.length,
        itemBuilder: (context, index) {
          var item = secondFloorItems[index];
          var active = item.check;

          Widget child = WrapperButton(
            onPressed: () {
              if (widget.onSecondFloorItemChanged != null) {
                widget.onSecondFloorItemChanged!(items);
              }
              if (widget.onSecondFloorItemTap != null) {
                widget.onSecondFloorItemTap!(index, item);
                return;
              }

              if (multipleChoice) {
                int checkedCount = 0;
                for (var element in items) {
                  if (element.data == null) continue;
                  checkedCount +=
                      element.data!.where((element) => element.check).length;
                }
                if (!item.check &&
                    widget.maxMultiChoiceSize != null &&
                    checkedCount >= widget.maxMultiChoiceSize!) {
                  widget.onDropDownItemLimitExceeded?.call(secondFloorItems);
                  return;
                }
                item.check = !item.check;
              } else {
                for (var element in items) {
                  if (element.data == null) continue;
                  for (var subElement in element.data!) {
                    subElement.check = false;
                  }
                }
                item.check = true;
                if (widget.onDropDownHeaderUpdate != null) {
                  DropDownHeaderStatus? status =
                      widget.onDropDownHeaderUpdate!([item]);
                  if (status != null) {
                    setState(() {});
                    widget.controller.hide(
                      index: widget.headerIndex,
                      status: status,
                    );
                    return;
                  }
                }
                widget.controller.hide(
                  index: widget.headerIndex,
                  status: DropDownHeaderStatus(highlight: item.check),
                );
              }
              setState(() {});
            },
            text: item.text,
            textStyle: active
                ? widget.secondFloorItemStyle.activeTextStyle
                : widget.secondFloorItemStyle.textStyle,
            textAlign: widget.secondFloorItemStyle.textAlign,
            textExpand: widget.secondFloorItemStyle.textExpand,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            icon: active
                ? (item.activeIcon ?? widget.secondFloorItemStyle.activeIcon)
                : (item.icon ?? widget.secondFloorItemStyle.icon),
            iconColor: active
                ? widget.secondFloorItemStyle.activeIconColor
                : widget.secondFloorItemStyle.iconColor,
            iconSize: active
                ? widget.secondFloorItemStyle.activeIconSize
                : widget.secondFloorItemStyle.iconSize,
            iconPosition: widget.secondFloorItemStyle.iconPosition,
            gap: widget.secondFloorItemStyle.gap,
            padding: widget.secondFloorItemStyle.padding,
            width: secondFloorItemWidth -
                (widget.secondFloorItemStyle.margin?.horizontal ?? 0),
            height: widget.secondFloorItemStyle.height,
            alignment: widget.secondFloorItemStyle.alignment,
            borderSide: active
                ? widget.secondFloorItemStyle.activeBorderSide
                : widget.secondFloorItemStyle.borderSide,
            borderRadius: active
                ? widget.secondFloorItemStyle.activeBorderRadius
                : widget.secondFloorItemStyle.borderRadius,
            backgroundColor: active
                ? widget.secondFloorItemStyle.activeBackgroundColor
                : widget.secondFloorItemStyle.backgroundColor,
            elevation: widget.secondFloorItemStyle.elevation,
          );

          if (widget.secondFloorItemStyle.decoration != null && !active) {
            child = DecoratedBox(
              decoration: widget.secondFloorItemStyle.decoration!,
              child: child,
            );
          }
          if (widget.secondFloorItemStyle.activeDecoration != null && active) {
            child = DecoratedBox(
              decoration: widget.secondFloorItemStyle.activeDecoration!,
              child: child,
            );
          }

          if (widget.secondFloorItemStyle.margin != null) {
            child = Padding(
              padding: widget.secondFloorItemStyle.margin!,
              child: child,
            );
          }

          return child;
        },
      ),
    );
  }
}
