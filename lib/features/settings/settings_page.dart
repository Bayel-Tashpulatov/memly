import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memly/appcolors.dart';
import 'package:memly/core/theme/theme_provider.dart';
import 'package:memly/privacy_policy_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    final theme =
        themeMode == ThemeMode.dark ? DarkAppColor() : LightAppColor();

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Настройки", style: TextStyle(color: theme.textColor)),
        backgroundColor: theme.backgroundColor,
        foregroundColor: theme.textColor,
        iconTheme: IconThemeData(color: theme.textColor),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Сменить тему',
                style: TextStyle(color: theme.textColor),
              ),
              trailing: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
                color: theme.iconColor,
              ),
              onTap: () {
                final newTheme =
                    themeMode == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                ref.read(themeProvider.notifier).state = newTheme;
              },
            ),
            ListTile(
              title: Text(
                'Сменить язык',
                style: TextStyle(color: theme.textColor),
              ),
              trailing: Icon(Icons.language, color: theme.iconColor),
              onTap: () {
                // Логика смены языка
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Функция в разработке')),
                );
              },
            ),
            ListTile(
              title: Text(
                'Уведомления',
                style: TextStyle(color: theme.textColor),
              ),
              trailing: Icon(Icons.notifications, color: theme.iconColor),
              onTap: () {
                // Логика управления уведомлениями
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Функция в разработке')),
                );
              },
            ),

            ListTile(
              title: Text(
                'Политика конфиденциальности',
                style: TextStyle(color: theme.textColor),
              ),
              trailing: Icon(Icons.privacy_tip, color: theme.iconColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyPage(),
                  ),
                );
              },
            ),

            ListTile(
              title: Text(
                'О приложении',
                style: TextStyle(color: theme.textColor),
              ),
              trailing: Icon(Icons.info, color: theme.iconColor),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Memly',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2025 Memly Inc.',
                  applicationIcon: Icon(
                    Icons.flash_on,
                    size: 40,
                    color: theme.iconColor,
                  ),
                  children: [
                    Text(
                      'Memly - это приложение для изучения карточек.',
                      style: TextStyle(color: theme.textColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Создано с любовью к обучению и запоминанию.',
                      style: TextStyle(color: theme.textColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Разработчик - bayeltsh',
                      style: TextStyle(color: theme.textColor),
                    ),
                  ],
                );
              },
            ),
            ListTile(
              title: Text('Выход', style: TextStyle(color: theme.textColor)),
              trailing: Icon(Icons.logout, color: theme.iconColor),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
