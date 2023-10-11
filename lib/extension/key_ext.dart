import 'package:flutter/widgets.dart';

extension KeyExt on GlobalKey {
  RenderObject? get renderObject => currentContext?.findRenderObject();

  Size get renderSize => (renderObject != null && renderObject is RenderBox)
      ? (renderObject as RenderBox).size
      : Size.zero;
}
