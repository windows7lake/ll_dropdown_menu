import 'dart:math' as math;

import 'package:flutter/material.dart' hide IndexedWidgetBuilder;

import '../button/text_button.dart';
import '../sliver/sliver_grid_delegate_height.dart';
import 'drop_down_controller.dart';
import 'drop_down_style.dart';
import 'drop_down_typedef.dart';

/// The basic implementation of the drop-down menu. It is implemented internally
/// using `GridView` and supports single-selection and multi-selection operations.
class DropDownGridView extends DropDownViewStatefulWidget {
  /// Controller of the drop-down menu
  final DropDownController controller;

  /// Data controller of the drop-down menu content body
  final DropDownGridDataController? dataController;

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

  /// Whether the drop-down menu content body is scrollable
  final ScrollPhysics? physics;

  /// GridView in the drop-down menu content body
  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed.
  final bool? shrinkWrap;

  const DropDownGridView({
    super.key,
    required this.controller,
    required this.items,
    required this.crossAxisCount,
    this.dataController,
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
    this.btnWidget,
    this.resetWidget,
    this.confirmWidget,
    this.buttonStyle = const DropDownButtonStyle(),
    this.onDropDownItemsReset,
    this.onDropDownItemsConfirm,
    this.onDropDownHeaderUpdate,
    this.physics,
    this.shrinkWrap,
  });

  @override
  State<DropDownGridView> createState() => _DropDownGridViewState();

  @override
  double get actualHeight {
    int rowCount = items.length ~/ crossAxisCount +
        (items.length % crossAxisCount == 0 ? 0 : 1);
    return boxStyle.height ??
        itemStyle.height * rowCount +
            crossAxisSpacing * (rowCount - 1) +
            boxStyle.margin.vertical +
            boxStyle.padding.vertical +
            (itemStyle.margin?.vertical ?? 0) +
            ((maxMultiChoiceSize != null && maxMultiChoiceSize! > 0)
                ? math.max(buttonStyle.resetHeight, buttonStyle.confirmHeight)
                : 0);
  }
}

class _DropDownGridViewState extends State<DropDownGridView> {
  List<DropDownItem> items = [];
  List<DropDownItem> confirmItems = [];
  bool multipleChoice = false;

  @override
  void initState() {
    super.initState();
    initData();
    widget.controller.addListener(dropDownListener);
  }

  @override
  void didUpdateWidget(covariant DropDownGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length != oldWidget.items.length) {
      initData();
    }
  }

  void initData() {
    widget.dataController?.bind(this);
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
    Widget child = GridView.builder(
      shrinkWrap: widget.shrinkWrap ?? false,
      physics: widget.physics,
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
          child: GridView.builder(
            shrinkWrap: widget.shrinkWrap ?? true,
            physics: widget.physics,
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
              return gridItem(context, index, true);
            },
          ),
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
                          (index) => items[index].copyWith(),
                        );
                        var checkItems =
                            items.where((element) => element.check).toList();
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
    if (widget.boxStyle.height != null) {
      child = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.boxStyle.height!,
        ),
        child: child,
      );
    }
    return SingleChildScrollView(child: child);
  }

  Widget gridItem(BuildContext context, int index, bool multipleChoice) {
    var item = items[index];
    var active = item.check;

    Widget child = WrapperButton(
      onPressed: () {
        if (widget.onDropDownItemChanged != null) {
          widget.onDropDownItemChanged!(index, items);
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
      width: (widget.itemStyle.width ??
                  ((widget.boxStyle.width ??
                          MediaQuery.of(context).size.width) -
                      widget.boxStyle.margin.horizontal -
                      widget.boxStyle.padding.horizontal)) /
              widget.crossAxisCount -
          (widget.crossAxisCount - 1) * widget.crossAxisSpacing -
          (widget.itemStyle.margin?.horizontal ?? 0),
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
      elevation: widget.itemStyle.elevation,
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

  @override
  void dispose() {
    widget.dataController?.dispose();
    super.dispose();
  }

  void update() {
    setState(() {});
  }
}

class DropDownGridDataController {
  _DropDownGridViewState? _state;

  // ignore: library_private_types_in_public_api
  void bind(_DropDownGridViewState state) {
    _state = state;
  }

  void dispose() {
    _state = null;
  }

  void resetAllItemsStatus() {
    _state?.items.forEach((element) {
      element.check = false;
    });
    _state?.update();
  }

  void changeItemStatusByIndex(int index, bool check) {
    _state?.items[index].check = check;
    _state?.update();
  }

  void changeItemStatusByText(String text, bool check) {
    _state?.items.firstWhere((element) => element.text == text).check = check;
    _state?.update();
  }
}
