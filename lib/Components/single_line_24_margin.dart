import 'package:flutter/material.dart';

class SingleLine24 extends StatelessWidget {
  final double height;

  const SingleLine24({
    Key? key,
    this.height = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.fromLTRB(12, 24, 12, 24),
      color: Colors.white.withOpacity(0.2),
    );
  }
}
