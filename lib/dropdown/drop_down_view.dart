import 'package:flutter/material.dart';

import 'drop_down_controller.dart';
import 'drop_down_typedef.dart';

/// DropDownMenu body component
class DropDownView extends StatefulWidget {
  /// Controller of the drop-down menu
  final DropDownController controller;

  /// Data for the body component of the drop-down menu
  final List<DropDownViewProperty> builders;

  /// Background color of the drop-down menu body component
  final Color? viewColor;

  /// Color of the mask layer of the drop-down menu
  final Color? maskColor;

  /// Animation duration of the drop-down menu body component
  final Duration animationDuration;

  /// Y-axis offset of the drop-down menu body component
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

  void dropDownListener() async {
    currentIndex = widget.controller.headerIndex;
    if (currentIndex >= widget.builders.length) {
      throw ArgumentError("DropDownView index out of range, "
          "currentIndex >= builders.length");
    }

    if (isExpand && widget.controller.isExpand) {
      // // no animation
      // animationViewHeight = widget.builders[currentIndex].actualHeight;
      // if (mounted) setState(() {});
      // return;
      await animationController?.reverse();
      maskHeight = 0;
    }

    isExpand = widget.controller.isExpand;
    viewHeight = widget.builders[currentIndex].actualHeight;
    animation?.removeListener(animationListener);
    animation = Tween<double>(begin: 0, end: viewHeight).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeInOut))
      ..addListener(animationListener);
    if (!mounted) return;
    if (isExpand) {
      maskHeight = MediaQuery.of(context).size.height;
      await animationController?.forward();
    } else {
      await animationController?.reverse();
      maskHeight = 0;
    }
    setState(() {});
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
        children: widget.builders,
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
