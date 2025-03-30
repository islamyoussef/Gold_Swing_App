import 'package:flutter/material.dart';
import '../../ihelper/shared_variables.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  CustomAppBar({super.key, required this.title, this.viewActionButton = true, this.onTapSync});

  final String title;
  final bool viewActionButton;
  void Function()? onTapSync;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black87,
      centerTitle: true,

      title: Text(title, style: TextStyle(color: myGoldenColor, fontSize: 20,fontWeight: FontWeight.w700),),

      actions: viewActionButton ? [
        Container(
          width: 40,
          height: kToolbarHeight - 15,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.2),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: InkWell(
            onTap: onTapSync,
            child: Icon(Icons.sync, size: 28, color: myGoldenColor,),
          ),
        ),
      ] : null,
    );
  }
}
