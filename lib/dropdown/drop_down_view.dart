import 'package:flutter/material.dart';

import 'drop_down_controller.dart';
import 'drop_down_typedef.dart';

class DropDownView extends StatefulWidget {
  final DropDownController controller;
  final List<DropDownViewBuilder> builders;
  final Color? viewColor;
  final Color? maskColor;
  final Duration animationDuration;
  final double offsetY;

  const DropDownView({
    super.key,
    required this.controller,
    required this.builders,
    this.viewColor = Colors.white,
    this.maskColor,
    this.animationDuration = const Duration(milliseconds: 150),
    this.offsetY = 0,
  });

  @override
  State<DropDownView> createState() => _DropDownViewState();
}

class _DropDownViewState extends State<DropDownView>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;
  double viewHeight = 0;
  double animationViewHeight = 0;
  double maskOpacity = 0;
  double maskHeight = 0;
  int currentIndex = 0;
  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(dropDownListener);
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
  }

  void dropDownListener() {
    currentIndex = widget.controller.headerIndex;
    if (currentIndex >= widget.builders.length) {
      throw ArgumentError("DropDownView index out of range, "
          "currentIndex >= builders.length");
    }

    if (isExpand && widget.controller.isExpand) {
      animationViewHeight = widget.builders[currentIndex].height;
      if (mounted) setState(() {});
      return;
    }

    isExpand = widget.controller.isExpand;
    viewHeight = widget.builders[currentIndex].height;
    animation?.removeListener(animationListener);
    animation = Tween<double>(begin: 0, end: viewHeight)
        .animate(animationController!)
      ..addListener(animationListener);
    if (isExpand) {
      maskHeight = MediaQuery.of(context).size.height;
      animationController?.forward();
    } else {
      animationController?.reverse();
      maskHeight = 0;
    }
    if (mounted) setState(() {});
  }

  void animationListener() {
    animationViewHeight = animation!.value;
    maskOpacity =
        (animation!.value / viewHeight) * (widget.maskColor?.opacity ?? 0.3);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.controller.viewOffsetY > 0
          ? widget.controller.viewOffsetY
          : widget.offsetY,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          view(),
          mask(),
        ],
      ),
    );
  }

  Widget view() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: animationViewHeight,
      color: widget.viewColor,
      child: IndexedStack(
        index: currentIndex,
        children: widget.builders.map((e) => e.widget).toList(),
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
        height: maskHeight,
        color: widget.maskColor != null
            ? widget.maskColor!.withOpacity(maskOpacity)
            : Colors.black.withOpacity(maskOpacity),
      ),
    );
  }

  @override
  void dispose() {
    animation?.removeListener(animationListener);
    widget.controller.removeListener(dropDownListener);
    animationController?.dispose();
    super.dispose();
  }
}
