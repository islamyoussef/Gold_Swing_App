import 'package:all_in_one/ihelper/shared_variables.dart';
import 'package:flutter/material.dart';

class CustomMetalCategory extends StatelessWidget {
  CustomMetalCategory({super.key, required this.category, required this.image,required this.shortCut,required this.selectedCategory, required this.onTap});
  
  final String category;
  final String image;
  final String shortCut;
  final String selectedCategory;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 225,
      height: 150,
      decoration: BoxDecoration(
        border: shortCut == selectedCategory ? Border.all(color: myGoldenColor) : Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: ExactAssetImage(image), fit: BoxFit.cover)
      ),
      child: Container(
        width: double.infinity,
        //height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: shortCut == selectedCategory ? Color.fromRGBO(232, 186, 71, 0.20) : Color.fromRGBO(42, 42, 42, 0.20), // Specifies the background color and the opacity [const Color.fromRGBO(90, 89, 89, 0.5)]
        ),
        child: Center(
          child: InkWell(
            onTap: onTap,
            child: Text(
              category,
              style: const TextStyle(
                  color: Colors.white,//myGoldenColor
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
