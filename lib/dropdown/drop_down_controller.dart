import 'package:flutter/material.dart';

import 'drop_down_typedef.dart';

/// The controller of the drop-down menu, used to control the display and
/// hiding of the drop-down menu.
class DropDownController extends ChangeNotifier {
  /// Whether the DropDownView is expanded.
  bool isExpand = false;

  /// The index of the currently selected header item.
  int headerIndex = 0;

  /// The status of header after the user selects the item
  List<DropDownHeaderStatus> headerStatus = [];

  /// The offset of the DropDownView in DropDownMenu
  Offset? viewOffset;

  /// The height of the DropDownView in DropDownMenu
  double viewHeight = 0;

  /// Used to show DropDownView.
  /// offsetY: The Y-axis offset of the DropDownMenu in screen
  void show(int index, {Offset? offset}) {
    isExpand = true;
    headerIndex = index;
    viewOffset = offset;
    notifyListeners();
  }

  /// Used to hide DropDownView.
  /// status: The status of header after the user selects the item
  void hide({int? index, DropDownHeaderStatus? status}) {
    if (status != null) {
      headerStatus[index ?? headerIndex] = status;
    }
    isExpand = false;
    notifyListeners();
  }

  /// Used to toggle DropDownView.
  void toggle(int index, {Offset? offset, DropDownHeaderStatus? status}) {
    if (isExpand && headerIndex == index) {
      hide(index: index, status: status);
    } else {
      show(index, offset: offset);
    }
  }
}
