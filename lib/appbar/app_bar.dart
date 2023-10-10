import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WrapperAppBar extends AppBar {
  static Widget? _defaultLeading;
  static Widget? _defaultTitle;
  static TextStyle? _defaultToolbarTextStyle;
  static TextStyle? _defaultTitleTextStyle;
  static double? _defaultToolbarHeight;
  static SystemUiOverlayStyle? _defaultSystemOverlayStyle;

  static void initConfig({
    Widget? defaultLeading,
    Widget? defaultTitle,
    TextStyle? defaultToolbarTextStyle,
    TextStyle? defaultTitleTextStyle,
    double? defaultToolbarHeight,
    SystemUiOverlayStyle? defaultSystemOverlayStyle,
  }) {
    _defaultLeading = defaultLeading;
    _defaultTitle = defaultTitle;
    _defaultToolbarTextStyle = defaultToolbarTextStyle;
    _defaultTitleTextStyle = defaultTitleTextStyle;
    _defaultToolbarHeight = defaultToolbarHeight;
    _defaultSystemOverlayStyle = defaultSystemOverlayStyle;
  }

  WrapperAppBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double elevation = 0,
    double? scrolledUnderElevation,
    ScrollNotificationPredicate notificationPredicate =
        defaultScrollNotificationPredicate,
    Color? shadowColor,
    Color? surfaceTintColor,
    ShapeBorder? shape,
    Color backgroundColor = Colors.white,
    Color? foregroundColor,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    bool primary = true,
    bool centerTitle = true,
    bool excludeHeaderSemantics = false,
    double? titleSpacing,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
    double? toolbarHeight,
    double? leadingWidth,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    SystemUiOverlayStyle? systemOverlayStyle,
    bool forceMaterialTransparency = false,
    Clip? clipBehavior,
    String? titleText,
  }) : super(
          key: key,
          leading:
              leading ?? (automaticallyImplyLeading ? _defaultLeading : null),
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title ??
              _defaultTitle ??
              Text(titleText ?? '', style: titleTextStyle),
          actions: actions,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          scrolledUnderElevation: scrolledUnderElevation,
          notificationPredicate: notificationPredicate,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          shape: shape,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          iconTheme: iconTheme,
          actionsIconTheme: actionsIconTheme,
          primary: primary,
          centerTitle: centerTitle,
          excludeHeaderSemantics: excludeHeaderSemantics,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
          bottomOpacity: bottomOpacity,
          toolbarHeight: toolbarHeight ?? _defaultToolbarHeight,
          leadingWidth: leadingWidth,
          toolbarTextStyle: toolbarTextStyle ?? _defaultToolbarTextStyle,
          titleTextStyle: titleTextStyle ??
              _defaultTitleTextStyle ??
              const TextStyle(color: Colors.black, fontSize: 18),
          systemOverlayStyle: systemOverlayStyle ?? _defaultSystemOverlayStyle,
          forceMaterialTransparency: forceMaterialTransparency,
          clipBehavior: clipBehavior,
        );
}
