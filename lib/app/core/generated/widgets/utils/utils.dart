import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:votify_2/app/core/constants/asset_data.dart';
import 'package:votify_2/app/core/constants/color.dart';
import 'package:votify_2/app/core/generated/widgets/app_input_end_text_widget/app_text.dart';

import '../../../constants/strings.dart';

class UtilsFonction {
  static formatDate(DateTime? datetime) {
    return '${datetime!.year}-${datetime.month}-${datetime.day}';
  }

  static String profile = '';
  //Import excel file
  static Future<void> importExcelFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      if (result != null) {
        ///File file = File(result.files.single.path);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: AppText(
            StringData.succesFileUpload,
            color: AppColors.backgroundColor,
          ),
          backgroundColor: AppColors.blueBgColor,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: AppText(
          e.toString(),
          color: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.redColor,
      ));
    }
  }

// for picking up image from gallery
  static Future<String> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      return await image.path;
    }
    print('No Image Selected');
    return '';
  }

  showSnackBar(BuildContext context, {required String text}) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: AppText(text)));
  }
}

String default_user_pic =AssetData.profilVotify;

class AppImageNetwork extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final bool isProgress;

  AppImageNetwork(
      {Key? key,
      required this.url,
      this.fit = BoxFit.contain,
      this.isProgress = false})
      : super(key: key);
  String urrl = "";

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      urrl = default_user_pic;
    } else {
      urrl = url;
    }
    return isProgress
        ? const CupertinoActivityIndicator()
        : urrl.startsWith('http')
            ? Image.network(
                urrl,
                //fit: fit,
                loadingBuilder: (context, child, loadingProgress) {
                  return  Image.asset( AssetData.profilVotify);
                },
                //imageUrl: urrl,
              )
            : Image.file(File(urrl), fit: fit);
  }
}
