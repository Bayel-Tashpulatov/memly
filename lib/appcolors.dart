// 1. Создаем базовый абстрактный класс AppColor
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AppColor {
  Color get backgroundColor;
  Color get cardColor;
  Color get textColor;
  Color get btnColor;
  Color get btnTextColor;
  Color get redBtnColor;
  Color get greenBtnColor;
  Color get orangeBtnColor;
  Color get appBarColor;
  Color get headingColor;
  Color get bodyTextColor;
  Color get cardTextColor;
  Color get disabledBtnColor;
  Color get hoverBtnColor;
  Color get successColor;
  Color get errorColor;
  Color get warningColor;
  Color get infoColor;
  Color get progressBgColor;
  Color get progressValueColor;
  Color get borderColor;
  Color get dividerColor;
  Color get iconColor;
}

// 2. Темная тема
class DarkAppColor extends AppColor {
  @override
  Color get backgroundColor => const Color(0xFF020914);

  @override
  Color get cardColor => const Color(0xFF172447);

  @override
  Color get textColor => Colors.white;

  @override
  Color get btnColor => const Color(0xFF6200EE);

  @override
  Color get btnTextColor => Colors.white;

  @override
  Color get redBtnColor => const Color(0xFFB00020);

  @override
  Color get greenBtnColor => const Color(0xFF00C853);

  @override
  Color get orangeBtnColor => const Color(0xFFFF9800);

  @override
  Color get appBarColor => const Color(0xFF020914);

  @override
  Color get headingColor => Colors.white;

  @override
  Color get bodyTextColor => const Color(0xFFCCCCCC);

  @override
  Color get cardTextColor => const Color(0xFF000000);

  @override
  Color get disabledBtnColor => const Color(0xFF888888);

  @override
  Color get hoverBtnColor => const Color(0xFF3700B3);

  @override
  Color get successColor => const Color(0xFF4CAF50);

  @override
  Color get errorColor => const Color(0xFFF44336);

  @override
  Color get warningColor => const Color(0xFFFFC107);

  @override
  Color get infoColor => const Color(0xFF2196F3);

  @override
  Color get progressBgColor => const Color(0xFF555555);

  @override
  Color get progressValueColor => const Color(0xFF00E676);

  @override
  Color get borderColor => const Color(0xFFCCCCCC);

  @override
  Color get dividerColor => const Color(0xFF444444);

  @override
  Color get iconColor => const Color.fromARGB(255, 87, 94, 117);
}

// 3. Светлая тема
class LightAppColor extends AppColor {
  @override
  Color get backgroundColor => const Color(0xFFF8F9FA);

  @override
  Color get cardColor => const Color(0xFFE9ECEF);

  @override
  Color get textColor => const Color(0xFF212529);

  @override
  Color get btnColor => const Color(0xFF6C757D);

  @override
  Color get btnTextColor => Colors.white;

  @override
  Color get redBtnColor => const Color(0xFFEF5350);

  @override
  Color get greenBtnColor => const Color(0xFF66BB6A);

  @override
  Color get orangeBtnColor => const Color(0xFFFFA726);

  @override
  Color get appBarColor => const Color(0xFFFFFFFF);

  @override
  Color get headingColor => const Color(0xFF000000);

  @override
  Color get bodyTextColor => const Color(0xFF333333);

  @override
  Color get cardTextColor => const Color(0xFF000000);

  @override
  Color get disabledBtnColor => const Color(0xFFAAAAAA);

  @override
  Color get hoverBtnColor => const Color(0xFF495057);

  @override
  Color get successColor => const Color(0xFF4CAF50);

  @override
  Color get errorColor => const Color(0xFFF44336);

  @override
  Color get warningColor => const Color(0xFFFFC107);

  @override
  Color get infoColor => const Color(0xFF2196F3);

  @override
  Color get progressBgColor => const Color(0xFFEEEEEE);

  @override
  Color get progressValueColor => const Color(0xFF00C853);

  @override
  Color get borderColor => const Color(0xFFDDDDDD);

  @override
  Color get dividerColor => const Color(0xFFCCCCCC);

  @override
  Color get iconColor => const Color(0xFF495057);
}

// 4. Провайдер текущей темы
final isDarkThemeProvider = StateProvider<bool>((ref) => true);

// 5. Провайдер AppColor
final appColorProvider = Provider<AppColor>((ref) {
  final isDark = ref.watch(isDarkThemeProvider);
  return isDark ? DarkAppColor() : LightAppColor();
});
