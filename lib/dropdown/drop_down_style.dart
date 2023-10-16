import 'package:flutter/material.dart';

import '../button/text_button.dart';

/// Drop-down menu Box style
class DropDownBoxStyle {
  const DropDownBoxStyle({
    this.width,
    this.height,
    this.backgroundColor = Colors.transparent,
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
    this.icon,
    this.activeIcon,
    this.iconSize = 20,
    this.activeIconSize = 20,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.activeBackgroundColor = Colors.transparent,
    this.borderSide = BorderSide.none,
    this.activeBorderSide = BorderSide.none,
    this.borderRadius = BorderRadius.zero,
    this.activeBorderRadius = BorderRadius.zero,
    this.decoration,
    this.activeDecoration,
    this.margin,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.textAlign,
    this.textExpand = false,
    this.iconPosition = IconPosition.right,
    this.gap = 0,
  });

  /// The width of the DropDownItem
  final double? width;

  /// The height of the DropDownItem
  final double height;

  /// Text style of the DropDownItem
  final TextStyle textStyle;

  /// Text style when DropDownItem is selected
  final TextStyle activeTextStyle;

  /// The icon of the DropDownItem
  final Widget? icon;

  /// The icon when DropDownItem is selected
  final Widget? activeIcon;

  /// The icon size of the DropDownItem
  final double iconSize;

  /// The icon size when DropDownItem is selected
  final double activeIconSize;

  /// The icon color of the DropDownItem
  final Color iconColor;

  /// The color of the icon when DropDownItem is selected
  final Color activeIconColor;

  /// The background color of the DropDownItem
  final Color backgroundColor;

  /// The background color of the DropDownItem when it is selected
  final Color activeBackgroundColor;

  /// The border of the DropDownItem
  final BorderSide borderSide;

  /// The border of the DropDownItem when it is selected
  final BorderSide activeBorderSide;

  /// The corner radius of the DropDownItem
  final BorderRadius borderRadius;

  /// The corner radius the DropDownItem when it is selected
  final BorderRadius activeBorderRadius;

  /// Decorator for the DropDownItem
  final Decoration? decoration;

  /// The decorator of the DropDownItem when DropDownItem is selected
  final Decoration? activeDecoration;

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
}

/// Drop-down menu button style in the multi-select state
class DropDownButtonStyle {
  const DropDownButtonStyle({
    this.resetText = "Reset",
    this.confirmText = "Confirm",
    this.resetTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.confirmTextStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.resetBackgroundColor = const Color(0xFFEEEEEE),
    this.confirmBackgroundColor = Colors.blue,
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

  /// The background color of the reset button
  final Color resetBackgroundColor;

  /// The background color of the confirmation button
  final Color confirmBackgroundColor;

  /// The height of the reset button
  final double resetHeight;

  /// The height of the confirmation button
  final double confirmHeight;
}
