import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memly/appcolors.dart';
import 'package:memly/models/deck.dart';
import 'package:go_router/go_router.dart';

class DeckListPage extends StatefulWidget {
  const DeckListPage({super.key});

  @override
  State<DeckListPage> createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  Box<Deck>? _deckBox;

  @override
  void initState() {
    super.initState();
    _initBox();
  }

  void _initBox() async {
    _deckBox = await Hive.openBox<Deck>('decks');
    setState(() {});
  }

  void _createDeck() async {
    final controller = TextEditingController();
    String? errorText;

    await showDialog(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: const Text(
                    "Новая папка",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: TextField(
                    controller: controller,
                    maxLength: 30,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: "Название папки",
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      errorText: errorText,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      counterText: '${controller.text.length}/30',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        final title = controller.text.trim();

                        if (title.isEmpty) {
                          setState(
                            () => errorText = 'Название не может быть пустым',
                          );
                        } else if (title.length > 30) {
                          setState(() => errorText = 'Максимум 30 символов');
                        } else {
                          _deckBox?.add(Deck(title: title));
                          Navigator.pop(context);
                          this.setState(() {});
                        }
                      },
                      child: const Text(
                        "Создать",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final decks = _deckBox?.values.toList() ?? [];
    final theme =
        Theme.of(context).brightness == Brightness.dark
            ? DarkAppColor()
            : LightAppColor();

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        foregroundColor: theme.textColor,
        elevation: 0, // Убираем тень
        title: Text(
          "Карточки",
          style: TextStyle(
            color: theme.headingColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
          decks.isEmpty
              ? Center(
                child: Text(
                  "Здесь пока нет папок",
                  style: TextStyle(
                    color: theme.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
              : ListView.separated(
                itemCount: decks.length,
                itemBuilder: (context, index) {
                  final deck = decks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    color: theme.cardColor,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      title: Text(
                        deck.title,
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: theme.iconColor,
                      ),
                      onTap: () => context.push('/deck/${deck.key}'),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 1),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createDeck,
        backgroundColor: theme.btnColor,
        foregroundColor: theme.btnTextColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
