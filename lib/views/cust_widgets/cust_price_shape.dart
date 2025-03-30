import 'package:flutter/material.dart';

class CustomPriceShape extends StatelessWidget {
  const CustomPriceShape({super.key,required this.weight, required this.price});

  final String weight;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 10, left: 24, right: 24),
      padding: EdgeInsets.only(left: 8, right: 8),
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            // color: Colors.orangeAccent,
            spreadRadius: 5,
            blurRadius: 24,
            offset: Offset(0, 5),
            color: Color(0xffFFF3E0)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(weight,
            style: myTextStyle(),
          ),
          Text(price,
            style: myTextStyle(),
          )
        ],
      ),
    )
    ;
  }

  TextStyle myTextStyle(){
    return TextStyle(
      color: Colors.black54,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

}
