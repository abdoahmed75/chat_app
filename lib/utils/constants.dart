import 'package:flutter/material.dart';

class AppConstants {

  static const Color K_DARK_COLOR = Color(0xFF006400);
  static const Color K_ACCENT_COLOR = Color(0xFF2ECC71);
  static const Color K_Border_COlor=Color(0xff6B8E23);

  // GRADIENT COLOR
  static const LinearGradient K_GRADIENT_COLOR = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      K_DARK_COLOR,
      K_ACCENT_COLOR,
    ],
  );

  // userRegister view
  static const LinearGradient k_Image_Container_Decoration = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8795B5),
      Colors.white,
    ],
  );

  static const Color TEXT_FIeLD_BORDER = Color(0xFFE7E8E8);
  static const Color TEXT_FIeLD_VERIFICATION_BORDER = Color(0xFF176BA7);

  // drawer
  static const LinearGradient K_DRAWER_GRADIENT_COLOR = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      K_ACCENT_COLOR,
      K_DARK_COLOR,
    ],
  );

  // Home
  static const Color DIALOG = Color(0xFFFCFCFC);

  // Search product
  static const Color Searching_Sort_Filter = Color(0xFF00587A);
}

class TextColors {
  // Sign In
  static const Color NEW_ACCOUNT_TEXT = Color(0xFF13245A);
  static const Color FORGET_ACCOUNT = Color(0xFF3A3A3A);

  //Sign Up
  static const Color TEXT_OVER_TEXT_FIeLD = Color(0xFF959595);
  static const Color CONDITION = Color(0xFF006494);

  // sort
  static const Color SORT = Color(0xFF000006);

  // Add Product
  static const Color ADD_Product = Color(0xFF666666);
}

class Keys {
  // LocalizationKey
  static const String LOCALIZATION_KEY = "LOCALIZATION_KEY";

  // ThemeKey
  static const String THEMING_KEY = "THEMING_KEY";
}

class AppDarkConstant {
  static const Color APP_DARK_COLOR = Colors.black;

  static const LinearGradient K_GRADIENT_DARK_COLOR = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF04867C),
      APP_DARK_COLOR,
    ],
  );
}
class AppLightConstant {
  static const Color APP_LIGHT_COLOR = Colors.white;

  static const LinearGradient K_GRADIENT_LIGHT_COLOR = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF04867C),
      APP_LIGHT_COLOR,
    ],
  );
}

enum USER_TYPE { Guest, User, Trader, Factory, Services }
enum USER_GENDER { Male, Female, other }
