import 'package:flutter/material.dart' hide IndexedWidgetBuilder;

import '../button/text_button.dart';
import 'drop_down_controller.dart';
import 'drop_down_typedef.dart';

class DropDownListView extends StatefulWidget {
  final DropDownController controller;
  final List<DropDownItem> items;
  final int? headerIndex;
  final double itemHeight;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final Widget? icon;
  final Widget? activeIcon;
  final double iconSize;
  final double activeIconSize;
  final Color iconColor;
  final Color activeIconColor;
  final Color itemBackgroundColor;
  final Color itemActiveBackgroundColor;
  final BoxBorder? itemBorder;
  final BoxBorder? itemActiveBorder;
  final Decoration? itemDecoration;
  final Decoration? activeItemDecoration;
  final double itemBorderRadius;
  final AlignmentGeometry itemAlignment;
  final EdgeInsetsGeometry? itemPadding;
  final IndexedWidgetBuilder? itemBuilder;
  final OnDropDownItemTap? onDropDownItemTap;
  final OnDropDownItemChanged? onDropDownItemChanged;
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

  const DropDownListView({
    super.key,
    required this.controller,
    required this.items,
    this.headerIndex,
    this.itemHeight = 50,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.activeTextStyle = const TextStyle(fontSize: 14, color: Colors.blue),
    this.icon,
    this.activeIcon = const Icon(Icons.check, size: 20, color: Colors.blue),
    this.iconSize = 20,
    this.activeIconSize = 20,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.blue,
    this.itemBackgroundColor = Colors.transparent,
    this.itemActiveBackgroundColor = Colors.transparent,
    this.itemBorder,
    this.itemActiveBorder,
    this.itemDecoration,
    this.activeItemDecoration,
    this.itemBorderRadius = 0,
    this.itemAlignment = Alignment.center,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 20),
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
  });

  @override
  State<DropDownListView> createState() => _DropDownListViewState();
}

class _DropDownListViewState extends State<DropDownListView> {
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
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (widget.itemBuilder != null) {
          return widget.itemBuilder!(context, index, items[index].check);
        }
        return listItem(context, index, false);
      },
    );
  }

  Widget multipleChoiceList() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.maxListHeight ?? widget.itemHeight * 5,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (widget.itemBuilder != null) {
                  return widget.itemBuilder!(
                      context, index, items[index].check);
                }
                return listItem(context, index, true);
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
                          widget.controller.hide();
                          setState(() {});
                          confirmItems = List.generate(
                            items.length,
                            (index) => items[index].copyWith(),
                          );
                          if (widget.onDropDownItemsConfirm != null) {
                            var checkItems = items
                                .where((element) => element.check)
                                .toList();
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

  Widget listItem(BuildContext context, int index, bool multipleChoice) {
    var item = items[index];
    var active = item.check;
    List<Widget> children = [];
    if (item.text != null) {
      children.add(Expanded(
        child: Text(
          item.text ?? "",
          style: active ? widget.activeTextStyle : widget.textStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ));
    }
    if (item.activeIcon != null || widget.activeIcon != null) {
      children.add(IconTheme(
        data: IconThemeData(
          color: active ? widget.activeIconColor : widget.iconColor,
          size: active ? widget.activeIconSize : widget.iconSize,
        ),
        child: (active ? item.activeIcon : item.icon) ??
            (active ? widget.activeIcon! : widget.icon) ??
            const SizedBox(),
      ));
    }

    Widget child = const SizedBox();
    if (children.isNotEmpty) {
      child = Row(children: children);
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
          widget.controller.hide(index: widget.headerIndex, text: item.text);
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
