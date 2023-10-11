import 'package:flutter/widgets.dart';

class SliverPersistentHeaderBuilder extends SliverPersistentHeaderDelegate {
  /// The size of the header when it is not shrinking at the top of the viewport.
  final double max;

  /// The smallest size to allow the header to reach, when it shrinks at the start of the viewport.
  final double min;

  /// The size of the header, if it was specified that [max] and [min] are the same with [height].
  final double? height;

  /// The builder for the header.
  final Widget Function(BuildContext context, double offset) builder;

  /// Creates a sliver persistent header delegate.
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
