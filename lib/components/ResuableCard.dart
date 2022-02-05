import 'package:flutter/material.dart';

class ReusableWidget extends StatelessWidget {
//  const ReusableWidget({
//    Key key,
//  }) : super(key: key);

  final Color colorCustom;
  final Widget cardChild;
  final double cardHeight;

  ReusableWidget(
      {@required this.colorCustom, @required this.cardChild, this.cardHeight});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      margin: EdgeInsets.all(15.0),
      child: cardChild,
      decoration: BoxDecoration(
        color: colorCustom,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
