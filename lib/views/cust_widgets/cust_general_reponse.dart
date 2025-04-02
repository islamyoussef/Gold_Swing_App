import 'package:flutter/material.dart';
import '../../ihelper/shared_variables.dart';

class CustomGeneralResponse extends StatelessWidget {
  const CustomGeneralResponse({super.key,required this.title,required this.value, this.compare = false});

  final String title;
  final double value;
  final bool compare;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:8, right: 8, bottom: 8),
      //width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
                text: title,
                style: customTitleStyle(),
                children: [
                  TextSpan(
                  text: value.toStringAsFixed(2),
                  style: customValueStyle()
                )]
            ),
          ),
        ],
      ),
    );
  }

  TextStyle customTitleStyle(){
    return TextStyle(
      color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle customValueStyle(){
    return TextStyle(
      color: compare ? (value > 0 ? Colors.green : Colors.red) : myGoldenColor,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
  }

}
