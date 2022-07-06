import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:chat_app/utils/constants.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    required this.lang,
    required this.isDark,
    Key? key,
  }) : super(key: key);

  final String lang;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:  Alignment.center,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            gradient: isDark
                ? AppDarkConstant.K_GRADIENT_DARK_COLOR
                : AppConstants.K_GRADIENT_COLOR,
            shape: BoxShape.circle,
          ),
        ),
        IconButton(
          icon: Icon(
            lang == 'en' ? FontAwesomeIcons.angleLeft :FontAwesomeIcons.angleRight,
            color: isDark ? AppDarkConstant.APP_DARK_COLOR : Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
