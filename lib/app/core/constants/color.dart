import 'package:flutter/material.dart';

class AppColors{
  static Color backgroundColor= Colors.white;
  static Color redColor= Colors.red;
  static Color whiteOpac= Colors.white.withOpacity(0.8);
  static Color greyColor =Colors.grey.withOpacity(0.5);
  static Color greySkyColor =Colors.grey.withOpacity(0.15);
  static Color blackColor=Colors.black;
  static Color blueBgColor=const Color(0xFF5C78D3).withOpacity(0.9);
  static Color blueBSkygColor=const Color.fromARGB(255, 217, 223, 243).withOpacity(0.7);
    static Color blueBSkygColor2=Color.fromARGB(255, 235, 238, 247).withOpacity(0.8);

  static Color greyBlackColor=Colors.black38;
  static Color violetColor=const Color(0xFFF41BF8);
  static LinearGradient listBackgroundColorFisr=const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF5C78D3),
      Color(0xFFE080F2)
      ]
  );

}