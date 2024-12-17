import 'package:flutter/material.dart';

enum IconPosition { left, right, top, bottom }

/// Wrapper TextButton for customizing default values
class WrapperButton extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStatesController? statesController;
  final bool? isSemanticButton;
  final Widget? child;
  final String? text;
  final TextStyle? textStyle;
  final Color textColor;
  final double textSize;
  final FontWeight? textWeight;
  final TextAlign? textAlign;
  final bool textExpand;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? overlayColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry padding;
  final OutlinedBorder? shape;
  final double radius;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? borderColor;
  final double? borderWidth;
  final BorderStyle? borderStyle;
  final double? elevation;
  final IconPosition? iconPosition;
  final Widget? icon;
  final Color? iconColor;
  final double iconSize;
  final double gap;
  final double? width;
  final double? height;
  final Size? minimumSize;

  const WrapperButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.isSemanticButton,
    this.child,
    this.text,
    this.textStyle,
    this.textColor = Colors.black,
    this.textSize = 14,
    this.textWeight = FontWeight.normal,
    this.textAlign,
    this.textExpand = false,
    this.overflow,
    this.maxLines,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor = Colors.transparent,
    this.shadowColor,
    this.surfaceTintColor,
    this.alignment,
    this.padding = EdgeInsets.zero,
    this.shape,
    this.radius = 0,
    this.borderRadius,
    this.borderSide,
    this.borderColor = Colors.transparent,
    this.borderWidth,
    this.borderStyle,
    this.elevation,
    this.iconPosition = IconPosition.left,
    this.icon,
    this.iconColor,
    this.iconSize = 20,
    this.gap = 4,
    this.width,
    this.height,
    this.minimumSize,
  }) : assert(child != null || text != null);

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (text != null && text!.isNotEmpty) {
      child = Text(
        text!,
        style: textStyle ??
            TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: textWeight,
            ),
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign,
      );
    }

    if (icon != null) {
      IconTheme iconWidget = IconTheme(
        data: IconThemeData(
          color: iconColor,
          size: iconSize,
        ),
        child: icon!,
      );
      if (child != null) {
        if (textExpand) {
          child = Expanded(child: child);
        } else if (!textExpand && width != null) {
          double iconWidth = width! - iconSize - gap - padding.horizontal;
          child = ConstrainedBox(
            constraints: BoxConstraints(maxWidth: iconWidth),
            child: child,
          );
        }
      }
      if (child == null) {
        child = icon;
      } else if (iconPosition == IconPosition.left) {
        child = Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            iconWidget,
            SizedBox(width: gap),
            child,
          ],
        );
      } else if (iconPosition == IconPosition.right) {
        child = Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            child,
            SizedBox(width: gap),
            iconWidget,
          ],
        );
      } else if (iconPosition == IconPosition.top) {
        child = Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            iconWidget,
            SizedBox(height: gap),
            child,
          ],
        );
      } else if (iconPosition == IconPosition.bottom) {
        child = Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            child,
            SizedBox(height: gap),
            iconWidget,
          ],
        );
      }
    }
    if (this.child != null) {
      child = this.child!;
    }
    if (child == null) {
      throw Exception("text, icon or child can not be null");
    }
    child = TextButton(
      onPressed: onPressed,
      style: style ??
          ButtonStyle(
            textStyle: resolve<TextStyle?>(textStyle),
            backgroundColor: resolve<Color?>(backgroundColor),
            foregroundColor: resolve<Color?>(foregroundColor),
            overlayColor: resolve<Color?>(overlayColor),
            shadowColor: resolve<Color?>(shadowColor),
            surfaceTintColor: resolve<Color?>(surfaceTintColor),
            shape: resolve<OutlinedBorder?>(shape ??
                RoundedRectangleBorder(
                  borderRadius: borderRadius ??
                      BorderRadius.all(
                        Radius.circular(radius),
                      ),
                  side: borderSide ??
                      BorderSide(
                        color: borderColor ?? const Color(0xFF000000),
                        width: borderWidth ?? 1,
                        style: borderStyle ?? BorderStyle.solid,
                      ),
                )),
            side: resolve<BorderSide?>(borderSide ??
                BorderSide(
                  color: borderColor ?? const Color(0xFF000000),
                  width: borderWidth ?? 1,
                  style: borderStyle ?? BorderStyle.solid,
                )),
            padding: resolve<EdgeInsetsGeometry?>(padding),
            elevation: resolve<double?>(elevation),
            iconColor: resolve<Color?>(iconColor),
            iconSize: resolve<double?>(iconSize),
            alignment: alignment,
            minimumSize: resolve<Size?>(minimumSize),
          ),
      child: child,
    );
    if (width != null || height != null) {
      child = SizedBox(
        width: width,
        height: height,
        child: child,
      );
    }
    return child;
  }

  WidgetStateProperty<T>? resolve<T>(T value) {
    return value == null ? null : WidgetStateProperty.all<T>(value);
  }
}
