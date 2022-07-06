import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/utils/constants.dart';
import 'drawer_item.dart';
class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _controllerL = Get.find<LocalizationController>();
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
      width: w*.7,
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
                const SizedBox(
                  height: 35,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    fit: BoxFit.fill,
                    color: Colors.white,
                    height: h*.10,

                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                DrawerItem(
                  nameItem: 'profile'.tr,
                  action: () async {
                    Get.back();
                    Get.toNamed(Routes.profile);
                  },
                ),
                DrawerItem(
                  nameItem: 'Chat'.tr,
                  action: () async {
                    Get.back();
                    Get.toNamed(Routes.LandingPage);
                  },
                ),
                DrawerItem(
                  nameItem: 'm1'.tr,
                  action: () async {},
                ),
                DrawerItem(
                  nameItem: 'mafcode'.tr,
                  action: () {
                    print('ttttttttttttttttttttttttttttttttt');
                    Get.back();
                    Get.toNamed(Routes.Loast);
                  },
                ),
                DrawerItem(
                  nameItem: 'wazayfi'.tr,
                  size: 18.0,
                  action: () {
                    print('ttttttttttttttttttttttttttttttttt');
                    Get.back();
                    Get.toNamed(Routes.find_job);
                  },
                ),
                DrawerItem(
                  nameItem: 'things'.tr,

                  size: 18.0,
                  action: () {
                    print('ttttttttttttttttttttttttttttttttt');
                    Get.back();
                    Get.toNamed(Routes.deliver);
                  },
                ),
                DrawerItem(
                  nameItem: 'helpmony'.tr,

                  size: 18.0,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.NeedHelp);

                  },
                ),
                DrawerItem(
                  nameItem: 'm2'.tr,
                  size: 18.0,
                  action: () {},
                ),
                DrawerItem(
                  nameItem: 'elwazelmafcode'.tr,

                  size: 18.0,
                  action: () {
                    print('bbbbbbbbbbbbbbbbbb');
                    Get.back();
                    Get.toNamed(Routes.mafcod);

                  },
                ),
                DrawerItem(
                  nameItem: 'waza'.tr,

                  size: 18.0,

                  action: () {
                    print('bbbbbbbbbbbbbbbbbb');
                    Get.back();
                    Get.toNamed(Routes.job_offer);
                  },
                ),
                DrawerItem(
                  nameItem: 'things'.tr,

                  size: 18.0,
                  action: () {
                    print('ttttttttttttttttttttttttttttttttt');
                    Get.back();
                    Get.toNamed(Routes.deliverprovider);
                  },
                ),
                DrawerItem(
                  nameItem: 'helpmony'.tr,
                  size: 18.0,
                  needDivider: false,
                  action: () {
                    Get.back();
                    Get.toNamed(Routes.provideHelp);

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
