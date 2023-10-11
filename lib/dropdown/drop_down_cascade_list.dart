import 'package:flutter/material.dart' hide IndexedWidgetBuilder;

import '../button/text_button.dart';
import 'drop_down_controller.dart';
import 'drop_down_typedef.dart';

/// The basic implementation of drop-down menu, cascading list, supporting
/// single-selection and multi-selection operations.
class DropDownCascadeList extends StatefulWidget {
  /// Controller of the drop-down menu
  final DropDownController controller;

  /// The data of the drop-down menu content body
  final List<DropDownItem<List<DropDownItem>>> items;

  /// Index of the drop-down menu header component
  final int? headerIndex;

  /// The width ratio of the first level of the drop-down menu content body
  final double firstFloorRatio;

  /// The background color of the first level of the drop-down menu content body
  final Color? firstFloorBackgroundColor;

  /// The height of the first-level sub-items of the drop-down menu content body
  final double firstFloorItemHeight;

  /// The text style of the first-level sub-items of the drop-down menu content body
  final TextStyle firstFloorTextStyle;

  /// Text style when the first-level sub-item of the drop-down menu content body is selected
  final TextStyle firstFloorActiveTextStyle;

  /// The background color of the first-level sub-items of the drop-down menu content body
  final Color firstFloorItemBackgroundColor;

  /// The background color of the first-level sub-item of the drop-down menu content body when it is selected
  final Color firstFloorItemActiveBackgroundColor;

  /// Decorator for the first-level sub-items of the drop-down menu content body, used to set background color, borders, etc.
  final Decoration? firstFloorItemDecoration;

  /// Decorator when the first-level sub-item of the drop-down menu content body is selected, used to set the background color, border, etc.
  final Decoration? firstFloorActiveItemDecoration;

  /// Alignment of the first-level sub-items of the drop-down menu content body
  final AlignmentGeometry firstFloorItemAlignment;

  /// Padding of the first-level sub-items of the drop-down menu content body
  final EdgeInsetsGeometry? firstFloorItemPadding;

  /// Builder for the first-level sub-items of the drop-down menu content body, used to customize Item
  final IndexedWidgetBuilder? firstFloorItemBuilder;

  /// Click event for the first-level sub-item of the drop-down menu content body
  final OnDropDownItemTap? onFirstFloorItemTap;

  /// The background color of the second level of the drop-down menu content body
  final Color? secondFloorBackgroundColor;

  /// The height of the second-level sub-items of the drop-down menu content body
  final double secondFloorItemHeight;

  /// The text style of the second-level sub-items of the drop-down menu content body
  final TextStyle secondFloorTextStyle;

  /// Text style when the second-level sub-item of the drop-down menu content body is selected
  final TextStyle secondFloorActiveTextStyle;

  /// The background color of the second-level sub-items of the drop-down menu content body
  final Color secondFloorItemBackgroundColor;

  /// The background color when the second-level sub-item of the drop-down menu content body is selected
  final Color secondFloorItemActiveBackgroundColor;

  /// Decorator for the second-level sub-items of the drop-down menu content body, used to set background color, borders, etc.
  final Decoration? secondFloorItemDecoration;

  /// Decorator when the second-level sub-item of the drop-down menu content body is selected, used to set the background color, border, etc.
  final Decoration? secondFloorActiveItemDecoration;

  /// The icon of the second-level sub-item of the drop-down menu content body
  final Widget? secondFloorItemIcon;

  /// The icon when the second-level sub-item of the drop-down menu content body is selected
  final Widget? secondFloorItemActiveIcon;

  /// The icon size of the second-level sub-items of the drop-down menu content body
  final double secondFloorItemIconSize;

  /// The icon size when the second-level sub-item of the drop-down menu content body is selected
  final double secondFloorItemActiveIconSize;

  /// The icon color of the second-level sub-item of the drop-down menu content body
  final Color secondFloorItemIconColor;

  /// The icon color when the second-level sub-item of the drop-down menu content body is selected
  final Color secondFloorItemActiveIconColor;

  /// Alignment of the second-level sub-items of the drop-down menu content body
  final AlignmentGeometry secondFloorItemAlignment;

  /// Padding of the second-level sub-items of the drop-down menu content body
  final EdgeInsetsGeometry? secondFloorItemPadding;

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

  const DropDownCascadeList({
    super.key,
    required this.controller,
    required this.items,
    this.headerIndex,
    this.firstFloorRatio = 0.3,
    this.firstFloorBackgroundColor = const Color(0xFFF5F5F5),
    this.firstFloorItemHeight = 50,
    this.firstFloorTextStyle =
        const TextStyle(fontSize: 14, color: Colors.black),
    this.firstFloorActiveTextStyle =
        const TextStyle(fontSize: 14, color: Colors.black),
    this.firstFloorItemBackgroundColor = const Color(0xFFF5F5F5),
    this.firstFloorItemActiveBackgroundColor = const Color(0xFFFEFEFE),
    this.firstFloorItemDecoration,
    this.firstFloorActiveItemDecoration,
    this.firstFloorItemAlignment = Alignment.center,
    this.firstFloorItemPadding = const EdgeInsets.symmetric(horizontal: 12),
    this.firstFloorItemBuilder,
    this.onFirstFloorItemTap,
    this.secondFloorBackgroundColor,
    this.secondFloorItemHeight = 50,
    this.secondFloorTextStyle =
        const TextStyle(fontSize: 14, color: Colors.black),
    this.secondFloorActiveTextStyle =
        const TextStyle(fontSize: 14, color: Colors.blue),
    this.secondFloorItemBackgroundColor = Colors.white,
    this.secondFloorItemActiveBackgroundColor = const Color(0xFFF5F5F5),
    this.secondFloorItemDecoration,
    this.secondFloorActiveItemDecoration,
    this.secondFloorItemIcon,
    this.secondFloorItemActiveIcon =
        const Icon(Icons.check, size: 20, color: Colors.blue),
    this.secondFloorItemIconSize = 20,
    this.secondFloorItemActiveIconSize = 20,
    this.secondFloorItemIconColor = Colors.black,
    this.secondFloorItemActiveIconColor = Colors.blue,
    this.secondFloorItemAlignment = Alignment.centerLeft,
    this.secondFloorItemPadding = const EdgeInsets.symmetric(horizontal: 20),
    this.secondFloorItemBuilder,
    this.onSecondFloorItemTap,
    this.onSecondFloorItemChanged,
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
  });

  @override
  State<DropDownCascadeList> createState() => _DropDownCascadeListState();
}

class _DropDownCascadeListState extends State<DropDownCascadeList> {
  List<DropDownItem<List<DropDownItem>>> items = [];
  List<DropDownItem<List<DropDownItem>>> confirmItems = [];
  int firstFloorIndex = 0;
  int secondFloorIndex = 0;

  @override
  void initState() {
    super.initState();
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
    if (!widget.multipleChoice) return;
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
      child: widget.multipleChoice ? multipleChoiceList() : singleChoiceList(),
    );
  }

  Widget singleChoiceList() {
    return Row(children: [
      firstFloor(),
      secondFloor(),
    ]);
  }

  Widget multipleChoiceList() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.maxListHeight ?? widget.firstFloorItemHeight * 5,
            child: Row(children: [
              firstFloor(),
              secondFloor(),
            ]),
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
                      WrapperTextButton(
                        height: widget.confirmHeight,
                        text: widget.confirmText,
                        textStyle: widget.confirmTextStyle,
                        backgroundColor: widget.confirmBackgroundColor,
                        onPressed: () {
                          widget.controller.hide();
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
                          if (widget.onDropDownItemsConfirm != null) {
                            List<DropDownItem> checkItems = [];
                            for (var element in items) {
                              if (element.data == null) continue;
                              checkItems
                                  .addAll(element.data!.where((e) => e.check));
                            }
                            widget.onDropDownItemsConfirm!(checkItems);
                          }
                        },
                      ),
                ),
              ]),
        ],
      ),
    );
  }

  Widget firstFloor() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * widget.firstFloorRatio,
      color: widget.firstFloorBackgroundColor,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          var active = item.check;
          return GestureDetector(
            onTap: () {
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
            child: Container(
              height: widget.firstFloorItemHeight,
              alignment: widget.firstFloorItemAlignment,
              padding: widget.firstFloorItemPadding,
              decoration: (active
                      ? widget.firstFloorActiveItemDecoration
                      : widget.firstFloorItemDecoration) ??
                  BoxDecoration(
                    color: active
                        ? widget.firstFloorItemActiveBackgroundColor
                        : widget.firstFloorItemBackgroundColor,
                  ),
              child: Text(
                item.text ?? "",
                style: active
                    ? widget.firstFloorActiveTextStyle
                    : widget.firstFloorTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget secondFloor() {
    double width = MediaQuery.of(context).size.width;
    List<DropDownItem> secondFloorItems = items[firstFloorIndex].data ?? [];
    return Container(
      width: width * (1 - widget.firstFloorRatio),
      color: widget.secondFloorBackgroundColor,
      child: ListView.builder(
        itemCount: secondFloorItems.length,
        itemBuilder: (context, index) {
          var item = secondFloorItems[index];
          var active = item.check;
          List<Widget> children = [];
          if (item.text != null) {
            children.add(Expanded(
              child: Text(
                item.text ?? "",
                style: active
                    ? widget.secondFloorActiveTextStyle
                    : widget.secondFloorTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ));
          }
          if (item.activeIcon != null ||
              widget.secondFloorItemActiveIcon != null) {
            children.add(IconTheme(
              data: IconThemeData(
                color: active
                    ? widget.secondFloorItemActiveIconColor
                    : widget.secondFloorItemIconColor,
                size: active
                    ? widget.secondFloorItemActiveIconSize
                    : widget.secondFloorItemIconSize,
              ),
              child: (active ? item.activeIcon : item.icon) ??
                  (active
                      ? widget.secondFloorItemActiveIcon!
                      : widget.secondFloorItemIcon) ??
                  const SizedBox(),
            ));
          }

          Widget child = const SizedBox();
          if (children.isNotEmpty) {
            child = Row(children: children);
          }
          return GestureDetector(
            onTap: () {
              if (!widget.multipleChoice &&
                  widget.onSecondFloorItemChanged != null) {
                widget.onSecondFloorItemChanged!(items);
              }
              if (widget.onSecondFloorItemTap != null) {
                widget.onSecondFloorItemTap!(index, item);
                return;
              }

              if (widget.multipleChoice) {
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
                widget.controller.hide(
                  index: widget.headerIndex,
                  text: item.text,
                );
              }
              setState(() {});
            },
            child: Container(
              height: widget.secondFloorItemHeight,
              alignment: widget.secondFloorItemAlignment,
              padding: widget.secondFloorItemPadding,
              decoration: (active
                      ? widget.secondFloorActiveItemDecoration
                      : widget.secondFloorItemDecoration) ??
                  BoxDecoration(
                    color: active
                        ? widget.secondFloorItemActiveBackgroundColor
                        : widget.secondFloorItemBackgroundColor,
                  ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
