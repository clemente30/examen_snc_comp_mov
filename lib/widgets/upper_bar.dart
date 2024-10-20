import 'package:flutter/material.dart';

class UpperBar extends StatelessWidget {
  final String screenName;
  final Widget? child;
  final Color color;

  const UpperBar({
    Key? key,
    required this.screenName,
    this.child,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Text(
            screenName,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const Expanded(child: SizedBox.shrink()),
          if (child != null) child!,
        ],
      ),
    );
  }
}
