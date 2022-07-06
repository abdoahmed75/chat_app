import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils/constants.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final bool disabled;
  final double size;
  final ValueChanged<bool>? onChanged;

  const AppCheckbox({
    this.size = 24,
    this.value = false,
    this.disabled = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final checkColor = disabled ? Colors.black : Colors.white;
    return Theme(
      data: Theme.of(context).copyWith(
        disabledColor: Colors.transparent,
        unselectedWidgetColor: Colors.transparent,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
              gradient: AppConstants.K_GRADIENT_COLOR,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 5,
                color: Colors.white,
              )),
          clipBehavior: Clip.hardEdge,
          child: Transform.scale(
            scale: size / Checkbox.width,
            child: Checkbox(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              activeColor: Colors.transparent,
              checkColor: Colors.white,
              value: value,
              onChanged: (value) => onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
