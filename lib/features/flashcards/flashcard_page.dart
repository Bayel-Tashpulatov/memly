import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memly/appcolors.dart';
import 'package:memly/models/flashcard.dart';

class FlashcardPage extends StatefulWidget {
  final int deckId;

  const FlashcardPage({super.key, required this.deckId});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  Box<Flashcard>? _flashcardBox;

  @override
  void initState() {
    super.initState();
    _initBox();
  }

  void _initBox() async {
    _flashcardBox = await Hive.openBox<Flashcard>('flashcards');
    setState(() {});
  }

  void _addFlashcard() async {
    final frontController = TextEditingController();
    final backController = TextEditingController();
    const maxLength = 100;

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final frontText = frontController.text;
            final backText = backController.text;
            final isTooLong =
                frontText.length > maxLength || backText.length > maxLength;
            final isEmpty = frontText.trim().isEmpty || backText.trim().isEmpty;

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                "Новая карточка",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: frontController,
                    maxLength: maxLength,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: "Лицевая сторона",
                      counterText: '${frontText.length}/$maxLength',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorText:
                          frontText.length > maxLength
                              ? 'Слишком длинный текст'
                              : null,
                    ),
                  ),
                  TextField(
                    controller: backController,
                    maxLength: maxLength,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: "Обратная сторона",
                      counterText: '${backText.length}/$maxLength',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorText:
                          backText.length > maxLength
                              ? 'Слишком длинный текст'
                              : null,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed:
                      isEmpty || isTooLong
                          ? null
                          : () {
                            _flashcardBox?.add(
                              Flashcard(
                                front: frontText.trim(),
                                back: backText.trim(),
                                timesReviewed: 0,
                                deckId: widget.deckId,
                              ),
                            );
                            setState(() {});
                            Navigator.pop(context);
                          },
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isEmpty || isTooLong ? Colors.grey : Colors.blue,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteFlashcard(int index, Flashcard card) {
    card.delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cards =
        _flashcardBox?.values
            .where((card) => card.deckId == widget.deckId)
            .toList();
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
          cards == null || cards.isEmpty
              ? Center(
                child: Text(
                  "Здесь пока нет карточек",
                  style: TextStyle(
                    color: theme.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
              : ListView.separated(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    color: theme.cardColor,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      title: Text(
                        card.front,
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        card.back,
                        style: TextStyle(color: theme.textColor),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteFlashcard(index, card),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 1),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        backgroundColor: theme.btnColor,
        foregroundColor: theme.btnTextColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
