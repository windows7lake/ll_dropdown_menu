import 'package:flutter/material.dart';

typedef OnDropDownHeaderItemTap = void Function(int index, DropDownItem item);

typedef IndexedWidgetBuilder = Widget Function(
    BuildContext context, int index, bool check);
typedef OnDropDownItemLimitExceeded = void Function(List<DropDownItem> items);
typedef OnDropDownItemTap = void Function(int index, DropDownItem item);
typedef OnDropDownItemChanged = void Function(List<DropDownItem> items);
typedef OnDropDownItemsReset = void Function(List<DropDownItem> items);
typedef OnDropDownItemsConfirm = void Function(List<DropDownItem> checkedItems);

class DropDownItem<T> {
  final String? text;
  final Widget? icon;
  final Widget? activeIcon;
  final T? data;
  bool check;

  DropDownItem({
    this.text,
    this.icon,
    this.activeIcon,
    this.data,
    this.check = false,
  });

  DropDownItem<T> copyWith({
    String? text,
    Widget? icon,
    Widget? activeIcon,
    T? data,
    bool? check,
  }) {
    return DropDownItem<T>(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
      data: data ?? this.data,
      check: check ?? this.check,
    );
  }
}

class DropDownViewBuilder {
  final double height;
  final Widget widget;

  DropDownViewBuilder({
    required this.height,
    required this.widget,
  });
}
