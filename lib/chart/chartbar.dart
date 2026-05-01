import 'package:flutter/material.dart';
class chartbar extends StatelessWidget {
  const chartbar({super.key,required this.fill});
final double fill;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
            ),
        ),
        ),
    );
  }
}