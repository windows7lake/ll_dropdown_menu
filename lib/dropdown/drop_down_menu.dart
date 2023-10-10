import 'package:flutter/material.dart';

import 'drop_down_controller.dart';
import 'drop_down_typedef.dart' hide IndexedWidgetBuilder;

class DropDownMenu extends StatefulWidget {
  final DropDownController controller;
  final List<DropDownItem> headerItems;
  final List<DropDownViewBuilder> viewBuilders;
  final double? viewOffsetY;
  final DropDownDisposeController? disposeController;
  final double? headerWidth;
  final double headerHeight;
  final Color headerBackgroundColor;
  final BoxBorder? headerBorder;
  final Decoration? headerDecoration;
  final EdgeInsetsGeometry headerMargin;
  final EdgeInsetsGeometry headerPadding;
  final bool headerExpand;
  final TextStyle headerTextStyle;
  final TextStyle headerActiveTextStyle;
  final double headerIconSize;
  final double headerActiveIconSize;
  final Color headerIconColor;
  final Color headerActiveIconColor;
  final Decoration? headerItemDecoration;
  final Decoration? headerActiveItemDecoration;
  final EdgeInsetsGeometry headerItemMargin;
  final EdgeInsetsGeometry headerItemPadding;
  final AlignmentGeometry headerItemAlignment;
  final NullableIndexedWidgetBuilder? headerItemBuilder;
  final IndexedWidgetBuilder? headerDividerBuilder;
  final OnDropDownHeaderItemTap? onHeaderItemTap;
  final Color? viewColor;
  final Color? maskColor;
  final Duration animationDuration;

  const DropDownMenu({
    super.key,
    required this.controller,
    required this.headerItems,
    required this.viewBuilders,
    required this.viewOffsetY,
    this.disposeController,
    this.headerWidth,
    this.headerHeight = 50,
    this.headerBackgroundColor = Colors.transparent,
    this.headerBorder,
    this.headerDecoration,
    this.headerMargin = EdgeInsets.zero,
    this.headerPadding = EdgeInsets.zero,
    this.headerExpand = true,
    this.headerTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.headerActiveTextStyle =
        const TextStyle(fontSize: 14, color: Colors.black),
    this.headerIconSize = 20,
    this.headerActiveIconSize = 20,
    this.headerIconColor = Colors.black,
    this.headerActiveIconColor = Colors.black,
    this.headerItemDecoration,
    this.headerActiveItemDecoration,
    this.headerItemMargin = EdgeInsets.zero,
    this.headerItemPadding = EdgeInsets.zero,
    this.headerItemAlignment = Alignment.center,
    this.headerItemBuilder,
    this.headerDividerBuilder,
    this.onHeaderItemTap,
    this.viewColor = Colors.white,
    this.maskColor,
    this.animationDuration = const Duration(milliseconds: 150),
  }) : assert(headerItems.length > 0);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu>
    with SingleTickerProviderStateMixin {
  double _width = 0;
  Animation<double>? animation;
  AnimationController? animationController;
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;
  double viewHeight = 0;
  double animationViewHeight = 0;
  double maskOpacity = 0;
  int currentIndex = 0;
  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    widget.disposeController?.bind(this);
    overlayState = Overlay.of(context);
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    widget.controller.headerText =
        widget.headerItems.map((e) => e.text ?? "").toList();
    widget.controller.addListener(dropDownListener);
  }

  @override
  void didUpdateWidget(covariant DropDownMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.disposeController?.bind(this);
  }

  void dropDownListener() async {
    currentIndex = widget.controller.headerIndex;
    if (currentIndex >= widget.viewBuilders.length) {
      throw ArgumentError("DropDownView index out of range, "
          "currentIndex >= builders.length");
    }
    if (isExpand && widget.controller.isExpand) {
      animationViewHeight = widget.viewBuilders[currentIndex].height;
      if (mounted) {
        setState(() {});
        if (overlayState != null && overlayState!.mounted) {
          overlayState?.setState(() {});
        }
      }
      return;
    }

    isExpand = widget.controller.isExpand;
    if (mounted) setState(() {});
    if (isExpand) {
      viewHeight = widget.viewBuilders[currentIndex].height;
      animation?.removeListener(animationListener);
      animation = Tween<double>(begin: 0, end: viewHeight)
          .animate(animationController!)
        ..addListener(animationListener);
      if (overlayEntry == null) {
        overlayEntry = OverlayEntry(
          builder: (context) {
            return Positioned(
              top: widget.viewOffsetY,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  view(),
                  mask(),
                ],
              ),
            );
          },
        );
        overlayState!.insert(overlayEntry!);
      }
      animationController?.forward();
    } else {
      animationController?.reverse();
    }
  }

  void animationListener() {
    animationViewHeight = animation!.value;
    maskOpacity =
        (animation!.value / viewHeight) * (widget.maskColor?.opacity ?? 0.3);
    if (overlayState != null && overlayState!.mounted) {
      overlayState?.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _width = (widget.headerWidth ?? MediaQuery.of(context).size.width) -
        widget.headerMargin.horizontal;
    return Container(
      width: _width,
      height: widget.headerHeight,
      margin: widget.headerMargin,
      padding: widget.headerPadding,
      decoration: widget.headerDecoration ??
          BoxDecoration(
            color: widget.headerBackgroundColor,
            border: widget.headerBorder,
          ),
      child: ListView.separated(
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
    var item = widget.headerItems[index];
    List<Widget> children = [];
    if (item.text != null) {
      var text = widget.controller.headerText.elementAt(index);
      children.add(ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (_width - widget.headerPadding.horizontal) /
                  widget.headerItems.length -
              widget.headerIconSize,
        ),
        child: Text(
          text.isEmpty ? item.text! : text,
          style: active ? widget.headerActiveTextStyle : widget.headerTextStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ));
    }
    if (item.icon != null) {
      children.add(IconTheme(
        data: IconThemeData(
          color: active ? widget.headerActiveIconColor : widget.headerIconColor,
          size: active ? widget.headerActiveIconSize : widget.headerIconSize,
        ),
        child: active ? item.activeIcon! : item.icon!,
      ));
    }

    Widget child = const SizedBox();
    if (children.isNotEmpty) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
    if (widget.headerExpand) {
      child = Container(
        width: (_width - widget.headerPadding.horizontal) /
                widget.headerItems.length -
            widget.headerMargin.horizontal,
        margin: widget.headerItemMargin,
        padding: widget.headerItemPadding,
        alignment: widget.headerItemAlignment,
        decoration: active
            ? widget.headerActiveItemDecoration
            : widget.headerItemDecoration,
        child: child,
      );
    } else if (widget.headerActiveItemDecoration != null &&
        widget.headerItemDecoration != null) {
      child = Container(
        margin: widget.headerItemMargin,
        padding: widget.headerItemPadding,
        decoration: active
            ? widget.headerActiveItemDecoration
            : widget.headerItemDecoration,
        child: child,
      );
    }
    return GestureDetector(
      onTap: () async {
        if (widget.onHeaderItemTap != null) {
          widget.onHeaderItemTap!(index, item);
          return;
        }
        widget.controller.toggle(index);
      },
      child: child,
    );
  }

  Widget headerDivider(BuildContext context, int index) {
    return const SizedBox();
  }

  Widget view() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: animationViewHeight,
      color: widget.viewColor,
      child: IndexedStack(
        index: currentIndex,
        children: widget.viewBuilders.map((e) => e.widget).toList(),
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
        color: widget.maskColor != null
            ? widget.maskColor!.withOpacity(maskOpacity)
            : Colors.black.withOpacity(maskOpacity),
      ),
    );
  }

  @override
  void dispose() async {
    widget.controller.removeListener(dropDownListener);
    animation?.removeListener(animationListener);
    animationController?.dispose();
    widget.controller.dispose();
    overlayEntry?.remove();
    overlayEntry?.dispose();
    widget.disposeController?.dispose();
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
}
