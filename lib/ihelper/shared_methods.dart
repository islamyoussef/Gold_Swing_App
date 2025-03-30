import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SharedMethods {

  static  String convertTimesTampToDateTime(int timesTamp) {
    // 1743239762
    // Convert timestamp to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timesTamp * 1000);

    // Format date
    String formattedDate = DateFormat('MMM d, y – h:mm a').format(dateTime);

    return formattedDate;
  }

  static int getCurrentTimesTamp()
  {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static void msgOperationResult(BuildContext ctx,String msg, Color color){
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg,style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
    ),),backgroundColor: color,),);
  }

}