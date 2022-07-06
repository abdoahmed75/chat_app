import 'package:flutter/material.dart';
import 'package:chat_app/utils/constants.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? p;
  final void Function()? onPress;
  final Widget?icon;

  const CustomButton({this.text = '', this.onPress, this.p, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppConstants.K_GRADIENT_COLOR,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          primary: Colors.white,
          //backgroundColor: AppConstants.K_DARK_COLOR,
          padding: p ?? const EdgeInsets.all(8),
        ),
        child: Center(
          child:icon==null?Text(text,style: TextStyle(fontSize: 18),):icon,

        ),
      ),
    );
  }
}
