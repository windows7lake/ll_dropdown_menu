import 'package:flutter/foundation.dart';

class DropDownController extends ChangeNotifier {
  /// Whether the DropDownView is expanded.
  bool isExpand = false;

  /// The index of the currently selected header item.
  int headerIndex = 0;

  /// The text that user selected.
  List<String> headerText = [];

  /// The offset of the DropDownView in DropDownMenu
  double viewOffsetY = -1;

  /// Used to show DropDownView.
  void show(int index, {double? offsetY}) {
    isExpand = true;
    headerIndex = index;
    viewOffsetY = offsetY ?? -1;
    notifyListeners();
  }

  /// Used to hide DropDownView.
  void hide({int? index, String? text}) {
    if (index != null && text != null) {
      headerText[index] = text;
    }
    isExpand = false;
    notifyListeners();
  }

  /// Used to toggle DropDownView.
  void toggle(int index, {String? text, double? offsetY}) {
    if (isExpand && headerIndex == index) {
      hide(index: index, text: text);
    } else {
      show(index, offsetY: offsetY);
    }
  }
}
