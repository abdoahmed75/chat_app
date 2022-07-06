import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_text.dart';

class LocalContainer extends StatelessWidget {
  final _controller = Get.find<ThemeController>();
  final String text;
  final bool isSelected;

  LocalContainer({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          gradient: isSelected
              ? AppConstants.K_GRADIENT_COLOR
              : _controller.darkTheme
              ? LinearGradient(colors: [
            Colors.transparent,
            Colors.transparent,
          ])
              : LinearGradient(colors: [
            Colors.white,
            Colors.white,
          ]),
          borderRadius: BorderRadius.circular(25)),
      child: CustomText(
        text: text,
        fontSize: 18.0,
        align: Alignment.center,
        color: isSelected
            ? Colors.white
            : _controller.darkTheme
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}
