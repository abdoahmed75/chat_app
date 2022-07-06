import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final _controllerL = Get.find<LocalizationController>();
  final String? hint;
  //final String? initial;
  final String? Function(String? str)? callBackValidor;
  final Function(String?)? onSaved;
  final FocusNode? onFieldSubmittedFocusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? isPassword;
  final FocusNode? focusNode;
  final int? maxLine;
  final double? fontSize;
  final Color? filledColor;
  final Widget? suffixIcon;
  final bool? withDirect;

  final TextEditingController? controller;
  CustomTextField({
    this.hint = '',
    // this.initial = '',
    this.callBackValidor,
    this.keyboardType,
    this.isPassword = false,
    this.filledColor,
    this.fontSize,
    this.onFieldSubmittedFocusNode,
    this.focusNode,
    this.maxLine,
    this.textInputAction = TextInputAction.done,
    this.suffixIcon,
    this.withDirect,
    this.onSaved,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return withDirect != null
        ? Directionality(
            textDirection: TextDirection.ltr, child: buildTextField())
        : buildTextField();
  }

  Widget buildTextField() {
    //controller!.text=initial!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        // initialValue: controller==null ?initial:null,
        obscureText: isPassword! ? true : false,
        maxLines: maxLine ?? 1,
        style: TextStyle(
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.all(9),
            hintStyle: TextStyle(color: Color(0xFF959595), fontSize: fontSize),
            // fillColor: filledColor ?? Color(0xFFF3F3F3),
            // filled: true,
            border: const OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.5,
                color: AppConstants.TEXT_FIeLD_BORDER,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: AppConstants.TEXT_FIeLD_BORDER,
              ),
              borderRadius: maxLine != null && maxLine! > 1
                  ? BorderRadius.all(Radius.circular(70.0))
                  : BorderRadius.all(Radius.circular(25.0)),
            ),
            suffixIcon: suffixIcon),
        keyboardType: keyboardType,
        validator: callBackValidor,
        textInputAction: textInputAction,
        // focusNode: focusNode,
        // onFieldSubmitted: (_) {
        //   FocusScope.of(context).requestFocus(onFieldSubmittedFocusNode);
        // },
        onSaved: onSaved,
      ),
    );
  }
}
