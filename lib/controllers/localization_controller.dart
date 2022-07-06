import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chat_app/utils/constants.dart';

class LocalizationController extends GetxController {
  final _box = GetStorage();
  final _key = Keys.LOCALIZATION_KEY;

  RxString _selectedLanguage = "ar".obs;

  String get lang => _loadLangFromBox();

  String _loadLangFromBox() => _box.read(_key) ?? 'ar';

  _saveLangToBox(String lang) => _box.write(_key, lang);

  LocalizationController() {
    var b = _loadLangFromBox();
    changeLanguage(b);
  }

  Future<void> changeLanguage(String lang) async {
    _saveLangToBox(lang);
    Get.updateLocale(lang == "ar" ? Locale('ar', 'eg') : Locale('en', 'Us'));
    _selectedLanguage.value = lang;
  }


}
