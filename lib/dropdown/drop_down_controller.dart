import 'package:flutter/foundation.dart';

class DropDownController extends ChangeNotifier {
  /// Whether the DropDownView is expanded.
  bool isExpand = false;

  /// The index of the currently selected header item.
  int headerIndex = 0;

  /// The text that user selected.
  List<String> headerText = [];

  /// Used to show DropDownView.
  void show(int index) {
    isExpand = true;
    headerIndex = index;
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
  void toggle(int index) {
    if (isExpand && headerIndex == index) {
      hide();
    } else {
      show(index);
    }
  }
}
