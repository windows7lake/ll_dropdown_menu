import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/extension/key_ext.dart';
import 'package:ll_dropdown_menu/extension/list_extension.dart';

import '../button/text_button.dart';
import 'drop_down_controller.dart';
import 'drop_down_style.dart';
import 'drop_down_typedef.dart' hide IndexedWidgetBuilder;

/// DropDownMenu component, which internally integrates the buttons and content
/// body of the drop-down menu, and controls the display and hiding of the
/// content body through Overlay.
class DropDownMenu extends StatefulWidget {
  /// Controller of the drop-down menu
  final DropDownController controller;

  /// Data of the drop-down menu header component
  final List<DropDownItem> headerItems;

  /// Data of the body component of the drop-down menu
  final List<DropDownViewProperty> viewBuilders;

  /// The destruction controller of the drop-down menu, used to close the drop-down menu in advance when the page is destroyed
  final DropDownDisposeController? disposeController;

  /// Whether the drop-down menu header is scrollable
  final ScrollPhysics? headerPhysics;

  /// Style of the drop-down menu header component
  final DropDownBoxStyle headerBoxStyle;

  /// Style of the drop-down menu header item
  final DropDownItemStyle headerItemStyle;

  /// Builder for the sub-items of the drop-down menu header component, used to customize Item
  final NullableIndexedWidgetBuilder? headerItemBuilder;

  /// Builder of the dividing line between the children of the drop-down menu header component, used to customize the dividing line
  final IndexedWidgetBuilder? headerDividerBuilder;

  /// Click event of the child item of the drop-down menu header component
  final OnDropDownHeaderItemTap? onHeaderItemTap;

  /// The selected state change event of the child item of the drop-down menu header component
  final OnDropDownItemChanged? onHeaderItemChanged;

  /// The expansion state change event of the drop-down menu
  final OnDropDownExpandStateChanged? onExpandStateChanged;

  /// Background color of the drop-down menu body component
  final Color? viewColor;

  /// Color of the mask layer in body component of the drop-down menu
  final Color? maskColor;

  /// Whether the mask layer is visible
  final bool maskVisible;

  /// Whether the mask layer cover full screen
  final bool maskFullScreen;

  /// Animation duration of the drop-down menu body component
  final Duration animationDuration;

  /// offset of the drop-down menu body component
  final Offset? viewOffset;

  /// offset of the drop-down menu body component relative to the header
  final Offset? relativeOffset;

  const DropDownMenu({
    super.key,
    required this.controller,
    required this.headerItems,
    required this.viewBuilders,
    this.viewOffset,
    this.relativeOffset,
    this.disposeController,
    this.headerPhysics,
    this.headerBoxStyle = const DropDownBoxStyle(height: 50),
    this.headerItemStyle = const DropDownItemStyle(),
    this.headerItemBuilder,
    this.headerDividerBuilder,
    this.onHeaderItemTap,
    this.onHeaderItemChanged,
    this.onExpandStateChanged,
    this.viewColor = Colors.white,
    this.maskColor,
    this.maskVisible = true,
    this.maskFullScreen = true,
    this.animationDuration = const Duration(milliseconds: 150),
  }) : assert(headerItems.length > 0);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu>
    with TickerProviderStateMixin {
  final GlobalKey headerKey = GlobalKey();
  Animation<double>? animation;
  AnimationController? animationController;
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;
  double viewHeight = 0;
  double animationViewHeight = 0;
  double maskOpacity = 0;
  int currentIndex = 0;
  bool expand = false;

  double get headerWidth =>
      (widget.headerBoxStyle.width ?? MediaQuery.of(context).size.width) -
      widget.headerBoxStyle.margin.horizontal;

  double? get headerHeight => widget.headerBoxStyle.height;

  Offset get headerOffset =>
      widget.controller.viewOffset ??
      widget.viewOffset ??
      headerKey.localToGlobal;

  double get bodyWidth =>
      widget.viewBuilders.item(currentIndex)?.actualWidth ??
      MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    intiController();
  }

  void intiController() {
    widget.disposeController?.bind(this);
    overlayState = Overlay.of(context);
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    widget.controller.headerStatus = widget.headerItems
        .map((e) => DropDownHeaderStatus(text: e.text ?? ""))
        .toList();
    widget.controller.addListener(dropDownListener);
  }

  void dropDownListener() async {
    currentIndex = widget.controller.headerIndex;
    if (currentIndex >= widget.viewBuilders.length) {
      throw ArgumentError("DropDownView index out of range, "
          "currentIndex >= builders.length");
    }
    if (expand && widget.controller.isExpand) {
      await animationController?.reverse();
      animationViewHeight = 0;
    }

    if (expand != widget.controller.isExpand) {
      expand = widget.controller.isExpand;
      widget.onExpandStateChanged?.call(expand);
    }
    if (mounted) setState(() {});
    if (expand) {
      viewHeight = widget.viewBuilders.item(currentIndex)?.actualHeight ?? 0;
      animation?.removeListener(animationListener);
      animation = Tween<double>(begin: 0, end: viewHeight).animate(
          CurvedAnimation(
              parent: animationController!, curve: Curves.easeInOut))
        ..addListener(animationListener);
      if (overlayEntry == null) {
        overlayEntry = buildOverlayEntry();
        overlayState!.insert(overlayEntry!);
      }
      overlayState?.setState(() {});
      animationController?.forward();
    } else {
      await animationController?.reverse();
      overlayState?.setState(() {});
    }
  }

  void animationListener() {
    animationViewHeight = animation!.value;
    widget.controller.viewHeight = animationViewHeight;
    maskOpacity =
        (animation!.value / viewHeight) * (widget.maskColor?.opacity ?? 0);
    if (overlayState != null && overlayState!.mounted) {
      overlayState?.setState(() {});
    }
  }

  OverlayEntry buildOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        double offsetX = headerOffset.dx + (widget.relativeOffset?.dx ?? 0);
        double offsetY = headerOffset.dy +
            (headerHeight ?? 0) +
            (widget.relativeOffset?.dy ?? 0);

        Widget? maskWidget = mask();
        if (!widget.maskFullScreen) {
          maskWidget = Positioned(
            top: offsetY,
            child: mask(),
          );
        }
        if (!widget.maskVisible || !expand) {
          maskWidget = null;
        }
        return Stack(children: [
          if (maskWidget != null) maskWidget,
          Positioned(
            top: offsetY,
            left: offsetX,
            child: body(),
          ),
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = header(key: headerKey);
    if (widget.controller.isExpand) {
      child = PopScope(
        onPopInvokedWithResult: (didPop, result) async {
          if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
            await animationController?.reverse();
          }
        },
        child: child,
      );
    }
    return child;
  }

  Widget header({GlobalKey? key}) {
    return Container(
      key: key,
      width: headerWidth,
      height: headerHeight,
      margin: widget.headerBoxStyle.margin,
      padding: widget.headerBoxStyle.padding,
      decoration: widget.headerBoxStyle.decoration ??
          BoxDecoration(
            color: widget.headerBoxStyle.backgroundColor,
            border: widget.headerBoxStyle.border,
          ),
      child: ListView.separated(
        physics: widget.headerPhysics ?? NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.headerItems.length,
        itemBuilder: widget.headerItemBuilder ?? headerItem,
        separatorBuilder: widget.headerDividerBuilder ?? headerDivider,
      ),
    );
  }

  Widget headerItem(BuildContext context, int index) {
    bool active =
        widget.controller.isExpand && widget.controller.headerIndex == index;
    DropDownHeaderStatus status = widget.controller.headerStatus[index];

    var item = widget.headerItems.item(index);
    double itemWidth = headerWidth;
    double itemHeight = widget.headerItemStyle.height;
    if (widget.headerBoxStyle.expand) {
      itemWidth = (headerWidth - widget.headerBoxStyle.padding.horizontal) /
              widget.headerItems.length -
          (widget.headerItemStyle.margin?.horizontal ?? 0);
    }

    Widget child = WrapperButton(
      width: itemWidth,
      height: itemHeight,
      onPressed: () {
        if (widget.onHeaderItemChanged != null) {
          widget.onHeaderItemChanged!(index, widget.headerItems);
        }
        if (widget.onHeaderItemTap != null) {
          widget.onHeaderItemTap!(index, item!);
          return;
        }
        widget.controller.toggle(index);
      },
      text: status.text.isEmpty ? item?.text : status.text,
      textStyle: active
          ? widget.headerItemStyle.activeTextStyle
          : (status.highlight
              ? widget.headerItemStyle.highlightTextStyle
              : widget.headerItemStyle.textStyle),
      textAlign: widget.headerItemStyle.textAlign,
      textExpand: widget.headerItemStyle.textExpand,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      icon: active
          ? (item?.activeIcon ?? widget.headerItemStyle.activeIcon)
          : (status.highlight ? widget.headerItemStyle.highlightIcon : null) ??
              (item?.icon ?? widget.headerItemStyle.icon),
      iconColor: active
          ? widget.headerItemStyle.activeIconColor
          : (status.highlight
                  ? widget.headerItemStyle.highlightIconColor
                  : null) ??
              widget.headerItemStyle.iconColor,
      iconSize: active
          ? widget.headerItemStyle.activeIconSize
          : (status.highlight
                  ? widget.headerItemStyle.highlightIconSize
                  : null) ??
              widget.headerItemStyle.iconSize,
      iconPosition: widget.headerItemStyle.iconPosition,
      gap: widget.headerItemStyle.gap,
      padding: widget.headerItemStyle.padding,
      alignment: widget.headerItemStyle.alignment,
      borderSide: active
          ? widget.headerItemStyle.activeBorderSide
          : (status.highlight
              ? widget.headerItemStyle.highlightBorderSide
              : widget.headerItemStyle.borderSide),
      borderRadius: active
          ? widget.headerItemStyle.activeBorderRadius
          : (status.highlight
              ? widget.headerItemStyle.highlightBorderRadius
              : widget.headerItemStyle.borderRadius),
      backgroundColor: active
          ? widget.headerItemStyle.activeBackgroundColor
          : (status.highlight
              ? widget.headerItemStyle.highlightBackgroundColor
              : widget.headerItemStyle.backgroundColor),
      elevation: widget.headerItemStyle.elevation,
    );

    if (widget.headerItemStyle.decoration != null && !active) {
      var decoration = widget.headerItemStyle.decoration!;
      if (status.highlight &&
          widget.headerItemStyle.highlightDecoration != null) {
        decoration = widget.headerItemStyle.highlightDecoration!;
      }
      child = DecoratedBox(
        decoration: decoration,
        child: child,
      );
    }
    if (widget.headerItemStyle.activeDecoration != null && active) {
      child = DecoratedBox(
        decoration: widget.headerItemStyle.activeDecoration!,
        child: child,
      );
    }

    if (widget.headerItemStyle.margin != null) {
      child = Padding(
        padding: widget.headerItemStyle.margin!,
        child: child,
      );
    }

    if (widget.headerItemStyle.painter != null && !active) {
      child = CustomPaint(
        size: Size(headerWidth, widget.headerItemStyle.height),
        painter: widget.headerItemStyle.painter!,
        child: child,
      );
    }
    if (widget.headerItemStyle.activePainter != null && active) {
      child = CustomPaint(
        size: Size(headerWidth, widget.headerItemStyle.height),
        painter: widget.headerItemStyle.activePainter!,
        child: child,
      );
    }

    if (widget.controller.isExpand) {
      child = GestureDetector(
        onVerticalDragDown: (details) {},
        onHorizontalDragDown: (details) {},
        child: child,
      );
    }

    return child;
  }

  Widget headerDivider(BuildContext context, int index) {
    return const SizedBox();
  }

  Widget body() {
    return Container(
      width: bodyWidth,
      height: animationViewHeight,
      color: widget.viewColor,
      child: IndexedStack(
        index: currentIndex,
        children: widget.viewBuilders,
      ),
    );
  }

  Widget mask() {
    if (maskOpacity.isNaN) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        widget.controller.hide();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: (widget.maskColor ?? Colors.black).withOpacity(maskOpacity),
      ),
    );
  }

  @override
  void dispose() async {
    widget.controller.removeListener(dropDownListener);
    animation?.removeListener(animationListener);
    animationController?.dispose();
    overlayEntry?.remove();
    overlayEntry?.dispose();
    super.dispose();
  }
}

class DropDownDisposeController {
  _DropDownMenuState? _state;

  // ignore: library_private_types_in_public_api
  void bind(_DropDownMenuState state) {
    _state = state;
  }

  void dispose() {
    _state = null;
  }

  TickerFuture? hideMenu() {
    return _state?.animationController?.reverse();
  }

  void hideMenuThenPop() {
    if (_state == null) return;
    _state!.animationController
        ?.reverse()
        .whenComplete(() => Navigator.of(_state!.context).pop());
  }
}
