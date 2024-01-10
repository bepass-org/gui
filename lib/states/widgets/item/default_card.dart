import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const DefaultCard({super.key, required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin ?? const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(blurRadius: 1.0, offset: const Offset(0, 0.5), color: Colors.grey.withOpacity(0.6))],
          color: Colors.white),
      child: child,
    );
  }
}
