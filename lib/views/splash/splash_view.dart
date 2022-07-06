import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/utils/image_urls.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Future.delayed(
              const Duration(seconds: 2),
                  () => Get.offNamed(
                Routes.start,
              )
          ),
          builder: (context, snapshot) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                ImageUrls.SPLASH,
                fit: BoxFit.fill,
              ),
            );
          }),
    );
  }
}
