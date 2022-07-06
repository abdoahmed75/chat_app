import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';

class DropDown extends StatelessWidget {
  final _controllerT = Get.find<ThemeController>();
 final Widget? icon;

   DropDown({Key? key, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: _controllerT.darkTheme
                ? Color(0xFF959595)
                : AppConstants.TEXT_FIeLD_BORDER,
            width: 2.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: DropDownBtn(
              icon: icon,
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownBtn extends StatelessWidget {
  final Widget? icon;

  const DropDownBtn({Key? key, this.icon}) : super(key: key);

  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: icon,
        onChanged: (v) {},
        items: [],
      ),
    );
  }
}
