



import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:votify/app/core/constants/color.dart';
import 'package:votify/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';

import '../../../constants/strings.dart';

class UtilsFonction{

  static formatDate(DateTime? datetime){
    return '${datetime!.year}-${datetime.month}-${datetime.day}';
  }



  //Import excel file 
  static Future<void> importExcelFile(context) async {
  try {
    FilePickerResult? result= await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],   
    );
    if (result != null) {
      ///File file = File(result.files.single.path);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AppText(StringData.succesFileUpload,color: AppColors.backgroundColor,),backgroundColor: AppColors.blueBgColor,));
      
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AppText(e.toString(),color: AppColors.backgroundColor,),backgroundColor: AppColors.redColor,));

  }
}

// for picking up image from gallery
static Future pickImage(ImageSource source) async {
  final image=await ImagePicker().pickImage(source: source);
  if (image != null) {
    return await image.readAsBytes();
  }
  print('No Image Selected');
}

showSnackBar(BuildContext context,{required String text}){
return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AppText(text)));
}
}

