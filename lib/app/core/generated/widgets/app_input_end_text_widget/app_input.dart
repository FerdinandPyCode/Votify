import 'package:flutter/material.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';

class AppInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double height;
  final TextInputType inputType;
  final TextAlign textAlign;
  final bool isObscure;
  final IconButton suffixIcon;
  final String hint;
  final bool hasSuffix;
  final double radius;
  final int maxLine;
  final int minLine;
  final double width;
  final double textfieldHeight;
  //final InputDecoration decoration;

  const AppInput({
    Key? key,
    this.label = "",
    required this.hasSuffix,
    required this.controller,
    required this.validator,
    this.height = 50,
    this.inputType = TextInputType.text,
    this.isObscure = false,
    this.suffixIcon = const IconButton(
      icon: Icon(Icons.edit),
      onPressed: null,
    ),
    this.textAlign = TextAlign.start,
    this.hint = "",
    this.radius = 10,
    this.maxLine = 1,
    this.minLine = 1,
    this.width = 400,
    this.textfieldHeight = 50,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          color: AppColors.blueBgColor,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                    color: AppColors.greyBlackColor,
                    offset: const Offset(0, 1),
                    spreadRadius: 1.0,
                    blurRadius: 10.0)
              ]),
          child: TextFormField(
            decoration: InputDecoration(

                //contentPadding: const EdgeInsets.only(left: 2.0, bottom: 10.0),
                hintStyle: TextStyle(color: AppColors.greyColor),
                suffixIcon: hasSuffix ? suffixIcon : null,
                hintText: hint,
                focusColor: AppColors.whiteOpac,
                iconColor: AppColors.blackColor,
                errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                border: OutlineInputBorder(
                  gapPadding: 10.0,
                  borderSide: BorderSide(
                    color: AppColors.backgroundColor,
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(radius),
                )),
            obscureText: isObscure,
            keyboardType: inputType,
            controller: controller,
            maxLines: maxLine,
            validator: validator,
            textAlign: textAlign,
            style: TextStyle(fontSize: 15, color: AppColors.blackColor),
            minLines: 1,
          ),
        ),
      ],
    );
  }
}
