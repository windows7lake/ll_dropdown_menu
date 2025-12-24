import 'package:flutter/material.dart';

import '../button/text_button.dart';

/// Drop-down menu Box style
class DropDownBoxStyle {
  const DropDownBoxStyle({
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.border,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.expand = true,
  });

  /// Width of the drop-down menu header component
  final double? width;

  /// Height of the drop-down menu header component
  final double? height;

  /// Background color of the drop-down menu header component
  final Color backgroundColor;

  /// Border of the drop-down menu header component
  final BoxBorder? border;

  /// Decorator of the drop-down menu header component, used to set the background color, border, etc.
  final Decoration? decoration;

  /// Margin of the drop-down menu header component
  final EdgeInsetsGeometry margin;

  /// Padding of the drop-down menu header component
  final EdgeInsetsGeometry padding;

  /// Whether the drop-down menu header component fills the parent component
  final bool expand;
}

/// Drop-down menu item style
class DropDownItemStyle {
  const DropDownItemStyle({
    this.width,
    this.height = 50,
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.activeTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.highlightTextStyle =
        const TextStyle(fontSize: 14, color: Colors.black),
    this.icon,
    this.activeIcon,
    this.highlightIcon,
    this.iconSize = 20,
    this.activeIconSize = 20,
    this.highlightIconSize = 20,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.black,
    this.highlightIconColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.activeBackgroundColor = Colors.transparent,
    this.highlightBackgroundColor = Colors.transparent,
    this.borderSide = BorderSide.none,
    this.activeBorderSide = BorderSide.none,
    this.highlightBorderSide = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.activeBorderRadius = BorderRadius.zero,
    this.highlightBorderRadius = BorderRadius.zero,
    this.decoration,
    this.activeDecoration,
    this.highlightDecoration,
    this.margin,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.textAlign,
    this.textExpand = false,
    this.iconPosition = IconPosition.right,
    this.gap = 0,
    this.elevation = 0,
    this.painter,
    this.activePainter,
  });

  /// The width of the DropDownItem
  final double? width;

  /// The height of the DropDownItem
  final double height;

  /// Text style of the DropDownItem
  final TextStyle textStyle;

  /// Text style when DropDownItem is selected
  final TextStyle activeTextStyle;

  /// Text style after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final TextStyle highlightTextStyle;

  /// The icon of the DropDownItem
  final Widget? icon;

  /// The icon when DropDownItem is selected
  final Widget? activeIcon;

  /// The icon after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Widget? highlightIcon;

  /// The icon size of the DropDownItem
  final double iconSize;

  /// The icon size when DropDownItem is selected
  final double activeIconSize;

  /// The icon size after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final double highlightIconSize;

  /// The icon color of the DropDownItem
  final Color iconColor;

  /// The color of the icon when DropDownItem is selected
  final Color activeIconColor;

  /// The color of the icon after DropDownItem was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Color highlightIconColor;

  /// The background color of the DropDownItem
  final Color backgroundColor;

  /// The background color of the DropDownItem when it is selected
  final Color activeBackgroundColor;

  /// The background color of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Color highlightBackgroundColor;

  /// The border of the DropDownItem
  final BorderSide borderSide;

  /// The border of the DropDownItem when it is selected
  final BorderSide activeBorderSide;

  /// The border of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final BorderSide highlightBorderSide;

  /// The corner radius of the DropDownItem
  final BorderRadius borderRadius;

  /// The corner radius of the DropDownItem when it is selected
  final BorderRadius activeBorderRadius;

  /// The corner radius of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final BorderRadius highlightBorderRadius;

  /// Decorator for the DropDownItem
  final Decoration? decoration;

  /// The decorator of the DropDownItem when DropDownItem is selected
  final Decoration? activeDecoration;

  /// The decorator of the DropDownItem after it was selected and one of the DropDownItem in dropdown-menu content must be selected
  final Decoration? highlightDecoration;

  /// Margins of the DropDownItem
  final EdgeInsetsGeometry? margin;

  /// Padding of the child items of the DropDownItem
  final EdgeInsetsGeometry padding;

  /// Alignment of the DropDownItem
  final AlignmentGeometry alignment;

  /// Text alignment of the DropDownItem
  final TextAlign? textAlign;

  /// Whether the text fills the parent component
  final bool textExpand;

  /// Position of the icon in the DropDownItem
  final IconPosition iconPosition;

  /// Gap between the icon and the text in the DropDownItem
  final double gap;

  /// The elevation of the DropDownItem
  final double elevation;

  /// The painter of the DropDownItem
  final CustomPainter? painter;

  /// The painter of the DropDownItem when it is selected
  final CustomPainter? activePainter;
}

/// Drop-down menu button style in the multi-select state
class DropDownButtonStyle {
  const DropDownButtonStyle({
    this.resetText = "Reset",
    this.confirmText = "Confirm",
    this.resetTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.confirmTextStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.resetTextWeight,
    this.confirmTextWeight,
    this.resetTextAlign,
    this.confirmTextAlign,
    this.resetBackgroundColor = const Color(0xFFEEEEEE),
    this.confirmBackgroundColor = Colors.blue,
    this.resetElevation = 0,
    this.confirmElevation = 0,
    this.resetBorderRadius,
    this.confirmBorderRadius,
    this.resetBorderSide,
    this.confirmBorderSide,
    this.resetHeight = 50,
    this.confirmHeight = 50,
  });

  /// The text of the reset button
  final String resetText;

  /// The text of the confirmation button
  final String confirmText;

  /// The text style of the reset button
  final TextStyle resetTextStyle;

  /// The text style of the confirmation button
  final TextStyle confirmTextStyle;

  /// The font weight of the reset button
  final FontWeight? resetTextWeight;

  /// The font weight of the confirmation button
  final FontWeight? confirmTextWeight;

  /// The text alignment of the reset button
  final TextAlign? resetTextAlign;

  /// The text alignment of the confirmation button
  final TextAlign? confirmTextAlign;

  /// The background color of the reset button
  final Color resetBackgroundColor;

  /// The background color of the confirmation button
  final Color confirmBackgroundColor;

  /// The elevation of the reset button
  final double resetElevation;

  /// The elevation of the confirmation button
  final double confirmElevation;

  /// The border radius of the reset button
  final BorderRadius? resetBorderRadius;

  /// The border radius of the confirmation button
  final BorderRadius? confirmBorderRadius;

  /// The border side of the reset button
  final BorderSide? resetBorderSide;

  /// The border side of the confirmation button
  final BorderSide? confirmBorderSide;

  /// The height of the reset button
  final double resetHeight;

  /// The height of the confirmation button
  final double confirmHeight;
}
