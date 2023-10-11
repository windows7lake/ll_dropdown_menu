import 'package:flutter/widgets.dart';

extension KeyExt on GlobalKey {
  /// Returns the [RenderObject] of the current context.
  RenderObject? get renderObject => currentContext?.findRenderObject();

  /// Returns the [Size] of the [RenderObject] of the current context.
  Size get renderSize => (renderObject != null && renderObject is RenderBox)
      ? (renderObject as RenderBox).size
      : Size.zero;
}
