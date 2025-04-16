import 'package:flutter/material.dart';
import 'package:memly/appcolors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).brightness == Brightness.dark
            ? DarkAppColor()
            : LightAppColor();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Политика конфиденциальности',
          style: TextStyle(color: theme.headingColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Политика конфиденциальности Memly\n\n'
              'Дата вступления в силу: 20/04/2025\n\n'
              '1. Сбор информации'
              'Мы собираем информацию, которую вы предоставляете при использовании Memly, включая личные данные, данные устройства и информацию об использовании приложения.\n\n'
              '2. Использование информации'
              'Мы используем собранные данные для улучшения функциональности приложения, обеспечения поддержки, а также для улучшения вашего опыта использования.\n\n'
              '3. Хранение данных'
              'Мы храним вашу информацию, пока она необходима для выполнения этих целей. Мы принимаем меры для защиты данных, но не можем гарантировать полную безопасность.\n\n'
              '4. Передача данных'
              'Мы не передаем ваши данные третьим сторонам, за исключением случаев, когда это требуется по закону или в случае слияния/поглощения.\n\n'
              '5. Ваши права'
              'Вы можете запросить доступ к своим данным, их исправление или удаление, связавшись с нами через memly@email.com.\n\n'
              '6. Изменения'
              'Политика может быть обновлена. Изменения будут опубликованы на этой странице.\n\n'
              '7. Контакты'
              'Если у вас есть вопросы, свяжитесь с нами по memly@email.com.\n\n',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: theme.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
