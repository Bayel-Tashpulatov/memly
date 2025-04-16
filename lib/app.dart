import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memly/appcolors.dart';
import 'package:memly/core/theme/theme_provider.dart';
import 'package:memly/routing/app_router.dart';

class MemlyApp extends ConsumerWidget {
  const MemlyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final router = AppRouter.router;

    return MaterialApp.router(
      title: 'Memly',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: LightAppColor().backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: LightAppColor().backgroundColor,
          foregroundColor: LightAppColor().textColor,
        ),
        iconTheme: IconThemeData(color: LightAppColor().textColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: DarkAppColor().backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: DarkAppColor().backgroundColor,
          foregroundColor: DarkAppColor().textColor,
        ),
        iconTheme: IconThemeData(color: DarkAppColor().textColor),
      ),
      routerConfig: router,
    );
  }
}
