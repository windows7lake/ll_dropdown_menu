import 'package:flutter/material.dart' hide IndexedWidgetBuilder;

import '../button/text_button.dart';
import 'drop_down_controller.dart';
import 'drop_down_typedef.dart';

class DropDownCascadeList extends StatefulWidget {
  final DropDownController controller;
  final List<DropDownItem<List<DropDownItem>>> items;
  final int? headerIndex;
  final double firstFloorRatio;
  final Color? firstFloorBackgroundColor;
  final double firstFloorItemHeight;
  final TextStyle firstFloorTextStyle;
  final TextStyle firstFloorActiveTextStyle;
  final Color firstFloorItemBackgroundColor;
  final Color firstFloorItemActiveBackgroundColor;
  final Decoration? firstFloorItemDecoration;
  final Decoration? firstFloorActiveItemDecoration;
  final AlignmentGeometry firstFloorItemAlignment;
  final EdgeInsetsGeometry? firstFloorItemPadding;
  final IndexedWidgetBuilder? firstFloorItemBuilder;
  final OnDropDownItemTap? onFirstFloorItemTap;
  final Color? secondFloorBackgroundColor;
  final double secondFloorItemHeight;
  final TextStyle secondFloorTextStyle;
  final TextStyle secondFloorActiveTextStyle;
  final Color secondFloorItemBackgroundColor;
  final Color secondFloorItemActiveBackgroundColor;
  final Decoration? secondFloorItemDecoration;
  final Decoration? secondFloorActiveItemDecoration;
  final Widget? secondFloorItemIcon;
  final Widget? secondFloorItemActiveIcon;
  final double secondFloorItemIconSize;
  final double secondFloorItemActiveIconSize;
  final Color secondFloorItemIconColor;
  final Color secondFloorItemActiveIconColor;
  final AlignmentGeometry secondFloorItemAlignment;
  final EdgeInsetsGeometry? secondFloorItemPadding;
  final IndexedWidgetBuilder? secondFloorItemBuilder;
  final OnDropDownItemTap? onSecondFloorItemTap;
  final OnDropDownItemChanged? onSecondFloorItemChanged;
  final int? maxMultiChoiceSize;
  final OnDropDownItemLimitExceeded? onDropDownItemLimitExceeded;
  final double? maxListHeight;
  final bool multipleChoice;
  final Widget? btnWidget;
  final Widget? resetWidget;
  final Widget? confirmWidget;
  final double resetHeight;
  final double confirmHeight;
  final String resetText;
  final String confirmText;
  final TextStyle resetTextStyle;
  final TextStyle confirmTextStyle;
  final Color resetBackgroundColor;
  final Color confirmBackgroundColor;
  final OnDropDownItemsReset? onDropDownItemsReset;
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
