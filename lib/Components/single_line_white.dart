import 'package:flutter/material.dart';

class SingleLineWhite extends StatelessWidget {
  final double height;

  const SingleLineWhite({
    Key? key,
    this.height = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      
            height: 1,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
          );
  }
}
