import 'package:all_in_one/ihelper/shared_methods.dart';
import 'package:all_in_one/ihelper/shared_variables.dart';
import 'package:flutter/material.dart';

import '../../models/metal_rate_model.dart';

class CustomPriceShapeArchive extends StatelessWidget {
  const CustomPriceShapeArchive({super.key, required this.metalRateModel,required this.onTap});

  final MetalRateModel metalRateModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 24, right: 24),
      padding: EdgeInsets.only(left: 8, right: 4, top: 8, bottom: 8),
      //height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            // color: Colors.orangeAccent,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
            color: myGoldenColor, //Color(0xffFFF3E0)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTap,
                child: Text(
                  currentMetalType(metalRateModel.metal.toLowerCase()),
                  style: titleTextStyle(),
                ),
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '21K ${metalRateModel.priceGram21K.toString()}',
                    style: subTitleTextStyle(),
                  ),

                  SizedBox(width: 15),

                  Text(
                    SharedMethods.convertTimesTampToDateTime(
                      metalRateModel.timestamp,
                    ),
                    style: dateTextStyle(),
                  ),
                ],
              ),
            ],
          ),

          IconButton(
            onPressed: null,
            icon: currentChangePriceIcon(metalRateModel.ch),
          ),
        ],
      ),
    );
  }

  TextStyle titleTextStyle() {
    return TextStyle(
      color: myGoldenColor,
      fontSize: 18,
      fontWeight: FontWeight.w800,
    );
  }

  TextStyle subTitleTextStyle() {
    return TextStyle(
      color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle dateTextStyle() {
    return TextStyle(
      color: Colors.black26,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
  }

  String currentMetalType(String metalShortCut) {
    switch (metalShortCut) {
      case 'xag':
        return 'Silver';
      case 'xpd':
        return 'Palladium';
      case 'xpt':
        return 'Platinum';
      default:
        return 'Gold';
        break;
    }
  }

  Icon currentChangePriceIcon(double ch) {
    return Icon(
      ch > 0 ? Icons.arrow_upward : Icons.arrow_downward,
      weight: 20,
      color: ch > 0 ? Colors.green : Colors.red,
    );
  }
}
