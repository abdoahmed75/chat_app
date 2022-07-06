import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final Alignment? align;
  final int? maxLine;
  final double height;
  final double textScaleFactor;
  final EdgeInsetsGeometry? margin;
  final FontWeight? w;
  final _controllerL = Get.find<LocalizationController>();
  final _controllerT = Get.find<ThemeController>();

  CustomText({
    this.text = '',
    this.color,
    this.fontSize = 16,
    this.align,
    this.maxLine,
    this.height = 1,
    this.textScaleFactor = 1,
    this.margin,
    this.w = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: align,
      child: Text(
        text,
        maxLines: maxLine,
        style: TextStyle(
            color: this.color == null
                ? _controllerT.darkTheme
                    ? Colors.white
                    : TextColors.TEXT_OVER_TEXT_FIeLD
                : this.color,
            fontSize: this.fontSize,
            height: height,
            fontWeight: w),
        textScaleFactor: textScaleFactor,
      ),
    );
  }
}
