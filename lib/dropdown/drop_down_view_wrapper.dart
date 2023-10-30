import 'package:flutter/material.dart';

import 'drop_down_typedef.dart';

class DropDownViewWrapper extends DropDownViewStatelessWidget {
  final double height;
  final Widget child;

  DropDownViewWrapper({
    required this.height,
    required this.child,
  });

  @override
  double get actualHeight => height;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
