import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:chat_app/views/login/login_view.dart';

import '../login/login_view.dart';
import 'drawer_item.dart';

class ProfDrawer extends StatefulWidget {
  @override
  _ProfDrawerState createState() => _ProfDrawerState();
}

class _ProfDrawerState extends State<ProfDrawer> {
  final _controllerL = Get.find<LocalizationController>();
  final _controllerT = Get.find<ThemeController>();
  String? lang;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Container(
        color: Colors.transparent,
        width: w * .7,
        child: Drawer(
          elevation: 100,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.2,
            margin: EdgeInsets.only(top: 32, bottom: 32),
            decoration: BoxDecoration(
              gradient: AppConstants.K_DRAWER_GRADIENT_COLOR,
              borderRadius: _controllerL.lang == 'en'
                  ? BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    fit: BoxFit.fill,
                    color: Colors.white,
                    height: h * .10,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                DrawerItem(
                  nameItem: 'about'.tr,
                  action: () async {
                    Get.back();
                    Get.toNamed(Routes.about);
                  },
                ),
                DrawerItem(
                  nameItem: 'posts'.tr,
                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.Posts);
                  },
                ),
                DrawerItem(
                  nameItem: 'm3'.tr,
                  action: () async {},
                ),
                DrawerItem(
                  nameItem: 'request'.tr,
                  action: () async {
                    Get.back();
                    Get.toNamed(Routes.findjobprofile);
                  },
                ),
                DrawerItem(
                  nameItem: 'things2'.tr,
                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.deliverP);
                  },
                ),
                DrawerItem(
                  nameItem: 'help'.tr,
                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.NeedHelpPofile);
                  },
                ),
                DrawerItem(
                  nameItem: 'm4'.tr,
                  size: 18.0,
                  action: () {},
                ),
                DrawerItem(
                  nameItem: 'mafcode2'.tr,
                  size: 18.0,
                  action: () {
                    // Get.back();
                    Get.toNamed(Routes.ChangeMafcod);
                  },
                ),
                DrawerItem(
                  nameItem: 'offer'.tr,
                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.jobofferprofile);
                  },
                ),
                DrawerItem(
                  nameItem: 'things3'.tr,
                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.DeliverProviderProfile);
                  },
                ),
                DrawerItem(
                  nameItem: 'help2'.tr,
                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.provideHelpProf);
                  },
                ),
                SwitchListTile(
                  title: Text(
                    "الوضع المظلم",
                    style: TextStyle(fontSize: w * .04),
                  ),
                  value: _controllerT.darkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      _controllerT.updateTheme(value);
                    });
                  },
                ),
                DropdownButtonFormField(
                  hint: Text(
                    'تغير اللغه ',
                    style: TextStyle(fontSize: w * .04),
                  ),
                  value: _controllerL.lang,
                  onChanged: (String? i) {
                    _controllerL.changeLanguage(i!);
                    GetStorage()
                        .write(Keys.LOCALIZATION_KEY, _controllerL.lang);
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'اللغه العربيه',
                        style: TextStyle(fontSize: w * .04),
                      ),
                      value: 'ar',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'اللغه الانجليزيه',
                        style: TextStyle(fontSize: w * .04),
                      ),
                      value: 'en',
                    ),
                  ],
                ),

                DrawerItem(
                  nameItem: 'log out'.tr,
                  size: 18.0,
                  action: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('تسجيل خروج'),
                            content: Text(
                                'هل انت متاكد من تسجيل الخروج'),
                            actions: [
                              TextButton(onPressed: (){Get.offAndToNamed(Routes.LOGIN);}, child: Text("نعم")),
                              TextButton(onPressed: (){Get.back();}, child: Text("لا")),
                            ],
                          );
                        });
                  },
                ),
                DrawerItem(
                  nameItem: 'Contact'.tr,
                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.Contact);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
