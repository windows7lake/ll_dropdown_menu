import 'package:flutter/material.dart';

import 'drop_down_typedef.dart';

class DropDownViewWrapper extends DropDownViewStatefulWidget {
  final double height;
  final Widget child;

  const DropDownViewWrapper({
    super.key,
    required this.height,
    required this.child,
  });

  @override
  State<DropDownViewWrapper> createState() => _DropDownViewWrapperState();

  @override
  double get actualHeight => height;
}

class _DropDownViewWrapperState extends State<DropDownViewWrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
