import 'package:flutter/material.dart';

typedef OnDropDownHeaderItemTap = void Function(int index, DropDownItem item);
typedef OnDropDownHeaderUpdate = DropDownHeaderStatus? Function(
    List<DropDownItem> checkedItems);
typedef IndexedWidgetBuilder = Widget Function(
    BuildContext context, int index, bool check);
typedef OnDropDownItemLimitExceeded = void Function(List<DropDownItem> items);
typedef OnDropDownItemTap = void Function(int index, DropDownItem item);
typedef OnDropDownItemChanged = void Function(int index, List<DropDownItem> items);
typedef OnDropDownItemsReset = void Function(List<DropDownItem> items);
typedef OnDropDownItemsConfirm = void Function(List<DropDownItem> checkedItems);
typedef OnDropDownExpandStateChanged = void Function(bool expand);

/// DropDownMenu data model
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

/// DropDownMenu body component property
abstract class DropDownViewProperty {
  /// The height of the DropDownMenu content view
  double get actualHeight;
}

/// DropDownMenu body component StatefulWidget
abstract class DropDownViewStatefulWidget extends StatefulWidget
    implements DropDownViewProperty {
  const DropDownViewStatefulWidget({Key? key}) : super(key: key);
}

/// DropDownMenu header component status
class DropDownHeaderStatus {
  DropDownHeaderStatus({
    this.text = "",
    this.highlight = false,
  });

  /// The text of the header item after the user selects the item
  String text;

  /// The highlight status of the header item after the user selects the item
  /// If the highlight is true, the text style of the header item will be changed to the highlightTextStyle of DropDownItemStyle,
  /// and the icon will be changed to the highlightIcon of DropDownItemStyle.
  /// etc.
  bool highlight;
}
