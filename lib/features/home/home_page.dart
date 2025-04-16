import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:memly/appcolors.dart';
import 'package:memly/models/deck.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Deck> _folders = [];

  @override
  void initState() {
    super.initState();
    _loadDecks();
  }

  Future<void> _loadDecks() async {
    final deckBox = await Hive.openBox<Deck>('decks');
    setState(() {
      _folders = deckBox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).brightness == Brightness.dark
            ? DarkAppColor()
            : LightAppColor();

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Memly',
          style: TextStyle(
            color: theme.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        foregroundColor: theme.textColor,
        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu, size: 28),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: theme.btnColor),
              child: Center(
                child: Text(
                  'Memly',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: theme.textColor),
              title: Text(
                'Настройки',
                style: TextStyle(color: theme.textColor),
              ),
              onTap: () => context.push('/settings'),
            ),

            ListTile(
              leading: Icon(Icons.share, color: theme.textColor),
              title: Text(
                'Поделиться',
                style: TextStyle(color: theme.textColor),
              ),
              onTap: () {
                Share.share(
                  'Попробуй Memly — приложение для изучения карточек! 📱💡\nСкоро в Google Play. 🚀\nhttps://play.google.com/store/apps/details?id=com.example.memly',
                  subject: 'Memly - приложение для изучения языков',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.star_border, color: theme.textColor),
              title: Text(
                'Оценить нас',
                style: TextStyle(color: theme.textColor),
              ),
              onTap: () {
                // Потом можно открыть ссылку на Google Play
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Функция в разработке')),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Icon(Icons.menu_book_sharp, size: 100, color: theme.textColor),
              const SizedBox(height: 20),
              Text(
                'Добро пожаловать в Memly!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: theme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Папки:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child:
                        _folders.isEmpty
                            ? Center(
                              child: Text(
                                "Нет папок",
                                style: TextStyle(color: theme.textColor),
                              ),
                            )
                            : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _folders.length,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              separatorBuilder:
                                  (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final deck = _folders[index];
                                return GestureDetector(
                                  onTap:
                                      () => context.push('/learn/${deck.key}'),
                                  child: Container(
                                    width: 160,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: theme.cardColor,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        deck.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: theme.textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                  const SizedBox(height: 40),
                  BtnWidget(text: 'Карточки', route: '/flashcards'),
                  const SizedBox(height: 18),
                  BtnWidget(text: 'Прогресс', route: '/progress'),
                  const SizedBox(height: 18),
                  BtnWidget(text: 'ИИ Чат', route: '/ai-chat'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BtnWidget extends StatelessWidget {
  const BtnWidget({super.key, required this.text, required this.route});
  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).brightness == Brightness.dark
            ? DarkAppColor()
            : LightAppColor();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.push(route),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.btnColor,
          foregroundColor: theme.btnTextColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        child: Text(text),
      ),
    );
  }
}
