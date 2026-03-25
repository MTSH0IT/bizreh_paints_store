import 'package:flutter/material.dart';

class AppRefreshWrapper extends StatelessWidget {
  const AppRefreshWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
    this.displacement,
    this.color,
    this.backgroundColor,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final double? displacement;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      displacement: displacement ?? 40,
      color: color,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
