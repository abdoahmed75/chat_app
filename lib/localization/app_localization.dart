import 'ar.dart';
import 'en.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_Us": en,
    "ar_eg": ar,
  };
}