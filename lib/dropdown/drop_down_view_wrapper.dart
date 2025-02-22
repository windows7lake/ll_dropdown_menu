import 'package:flutter/material.dart';

import 'drop_down_typedef.dart';

class DropDownViewWrapper extends DropDownViewStatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const DropDownViewWrapper({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  double get actualWidth => width;

  @override
  double get actualHeight => height;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
