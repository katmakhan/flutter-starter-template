import 'package:flutter/material.dart';

class SingleLine extends StatelessWidget {
  final double height;

  const SingleLine({
    Key? key,
    this.height = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.fromLTRB(12, 0, 12, 4),
      color: Colors.white.withOpacity(0.2),
    );
  }
}
