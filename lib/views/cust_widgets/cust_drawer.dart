import 'package:all_in_one/ihelper/shared_variables.dart';
import 'package:all_in_one/views/frm_metal_archive.dart';
import 'package:all_in_one/views/frm_metal_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/cubit/archive_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
backgroundColor: Colors.black54,
      child: ListView(
        children: [
          // Avatar
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            color: myGoldenColor,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/islam.jpg'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                  width: 75.0,
                  height: 75.0,
                ),

                userInfo('Islam A,Youssef', 14),

                userInfo('islamyoussef83@gmail.com',12),
              ],
            ),
          ),

          item('Home', Icons.home, () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => FrmMetalRate()),
              (route) => true,
            );
          }),

          item('Archive', Icons.history, ()
          {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FrmMetalArchive()),);
          }),

          item('Gold\'s price archive', Icons.shopping_basket_outlined, ()
          {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FrmMetalArchive(metalCatShortcut: 'XAU',)),);
          }),

          item('Silver\'s price archive', Icons.shopping_basket_outlined, ()
          {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FrmMetalArchive(metalCatShortcut: 'XAG',)),);
          }),

          item('Platinum\'s price archive', Icons.shopping_basket_outlined, ()
          {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FrmMetalArchive(metalCatShortcut: 'XPT',)),);
          }),

          item('Palladium\'s price archive', Icons.shopping_basket_outlined, ()
          {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FrmMetalArchive(metalCatShortcut: 'XPD',)),);
          }),

        ],
      ),
    );
  }

  Widget item(String title, IconData icon, VoidCallback onClick) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ListTile(
        leading: Icon(icon),
        //Item name
        title: Text(
          title,
          style: TextStyle(
            color: myGoldenColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        //trailing: the icon on the right side
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade300),

        //Event
        onTap: onClick,
      ),
    );
  }

  Widget userInfo(String title, double fontSize){
    return Text(title,style: TextStyle(
    color: Colors.black87,
        fontSize: fontSize,
        fontWeight: FontWeight.w700
    ));
  }

}