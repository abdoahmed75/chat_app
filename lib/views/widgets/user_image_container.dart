import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import '../../utils/constants.dart';
import '../../utils/image_urls.dart';

class UserImageContainer extends StatelessWidget {
  var _c = Get.find<ThemeController>();
  final bool isImage;

  UserImageContainer({Key? key, this.isImage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              gradient: _c.darkTheme
                  ? AppDarkConstant.K_GRADIENT_DARK_COLOR
                  : AppConstants.k_Image_Container_Decoration,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Color(0xFFA2ABC4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppConstants.K_GRADIENT_COLOR,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isImage
                    ? Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      )
                    : SvgPicture.asset(
                        ImageUrls.cameraIcon,
                        color: Colors.white,
                      ),
              )),
        ),
      ],
    );
  }
}

class UserImage extends StatelessWidget {
  final File userImage;

  const UserImage(this.userImage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 148,
            height: 148,
            decoration: BoxDecoration(
              gradient: AppConstants.k_Image_Container_Decoration,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Color(0xFFCCCFDB),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppConstants.K_GRADIENT_COLOR,
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      userImage,
                    )),
              )),
        ),
      ],
    );
  }
}
