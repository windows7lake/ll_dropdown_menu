import 'package:flutter/widgets.dart';

class SliverPersistentHeaderBuilder extends SliverPersistentHeaderDelegate {
  final double max;
  final double min;
  final double? height;
  final Widget Function(BuildContext context, double offset) builder;

  SliverPersistentHeaderBuilder({
    this.max = 0,
    this.min = 0,
    this.height,
    required this.builder,
  }) : assert(max >= min);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return builder(context, shrinkOffset);
  }

  @override
  double get maxExtent => height ?? max;

  @override
  double get minExtent => height ?? min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderBuilder oldDelegate) =>
      (height ?? max) != oldDelegate.max ||
      (height ?? min) != oldDelegate.min ||
      builder != oldDelegate.builder;
}
