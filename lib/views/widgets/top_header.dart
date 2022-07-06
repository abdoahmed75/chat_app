import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/utils/constants.dart';

import 'app_bar_button_back.dart';

class TopHeader extends StatelessWidget {
  TopHeader({
    Key? key,
    required this.w,
    required this.h,
    required this.lang,
    required this.isDark,
  }) : super(key: key);

  final double w;
  final double h;
  final String lang;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
            padding: lang == 'en'
                ? EdgeInsets.only(right: 40)
                : EdgeInsets.only(left: 40),
            child: AppBarBackButton(
              lang: lang,
              isDark: isDark,
            ),
          )),
          Expanded(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              fit: BoxFit.fill,
              height: h * 0.08,
              color: !isDark ? AppDarkConstant.APP_DARK_COLOR : Colors.white,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.lerp(
                lang == 'en' ? Alignment.topRight : Alignment.topLeft,
                Alignment.center, 0.5,
              )!,
              children: [
                Container(
                  width: w,
                  height: h,
                  child: SvgPicture.asset(
                    'assets/images/curve.svg',
                    fit: BoxFit.fill,
                    matchTextDirection: true,
                    color: AppConstants.K_DARK_COLOR,
                  ),
                ),
                Icon(Icons.notifications,color: Colors.white,size:h*.05)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TopHeaderWithCart extends StatelessWidget {
  TopHeaderWithCart({
    Key? key,
    required this.w,
    required this.h,
    required this.lang,
    required this.isDark,
    required this.onClick
  }) : super(key: key);

  final double w;
  final double h;
  final String lang;
  final bool isDark;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
            padding: lang == 'en'
                ? EdgeInsets.only(right: 40)
                : EdgeInsets.only(left: 40),
            child:  GestureDetector(
              onTap: onClick,
              child: SvgPicture.asset(
                'assets/icons/menu.svg',
                color: isDark ? Colors.white : TextColors.CONDITION,
                height: h*.04,
                width: w,
              ),
            ),
          )),
          Expanded(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              fit: BoxFit.fill,
              height: h * 0.08,
              color: !isDark ? AppDarkConstant.APP_DARK_COLOR : Colors.white,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){},
              child: Stack(
                alignment: Alignment.lerp(
                  lang == 'en' ? Alignment.topRight : Alignment.topLeft,
                  Alignment.center,
                  0.5,
                )!,
                children: [
                  Container(
                    width: w,
                    height: h,
                    child: SvgPicture.asset(
                      'assets/images/curve.svg',
                      fit: BoxFit.fill,
                      matchTextDirection: true,
                      color: AppConstants.K_DARK_COLOR,
                    ),
                  ),
                  Icon(Icons.notifications,color: Colors.white,size:h*.05 ,)

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
