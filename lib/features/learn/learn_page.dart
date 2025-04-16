import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:memly/features/learn/flashcard_view.dart';
import 'package:memly/models/flashcard.dart';
import 'package:memly/providers/flashcard_list_provider.dart';
import 'package:memly/review_scheduler.dart';
import 'package:memly/utils/flashcard_utils.dart';
import 'package:memly/appcolors.dart';

class LearnPage extends ConsumerStatefulWidget {
  final String deckId;

  const LearnPage({super.key, required this.deckId});

  @override
  ConsumerState<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends ConsumerState<LearnPage> {
  int index = 0;
  bool isFinished = false;
  late final List<Flashcard> flashcards;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final allCards = ref.read(flashcardListProvider);
    final filteredCards =
        allCards
            .where((card) => card.deckId.toString() == widget.deckId)
            .toList();
    flashcards = getDueFlashcards(filteredCards);

    final dueCount = getDueFlashcards(flashcards).length;
    log("Нужно повторить $dueCount карточек");
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).brightness == Brightness.dark
            ? DarkAppColor()
            : LightAppColor();

    if (flashcards.isEmpty) {
      return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Изучение карточек',
            style: TextStyle(color: theme.textColor),
          ),
          iconTheme: IconThemeData(color: theme.textColor),
          backgroundColor: theme.backgroundColor,
        ),
        body: Center(
          child: Text(
            'Нет карточек для изучения',
            style: TextStyle(color: theme.textColor),
          ),
        ),
      );
    }

    if (isFinished) {
      return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text('Готово!', style: TextStyle(color: theme.textColor)),
          iconTheme: IconThemeData(color: theme.textColor),
          backgroundColor: theme.backgroundColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🎉 Все карточки изучены!',
                style: TextStyle(fontSize: 24, color: theme.textColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    index = 0;
                    isFinished = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.btnColor,
                  foregroundColor: theme.textColor,
                ),
                child: Text(
                  'Начать заново',
                  style: TextStyle(color: theme.btnTextColor),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/'),
                child: Text(
                  'На главную',
                  style: TextStyle(color: theme.textColor),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final card = flashcards[index];

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        title: Text(
          'Изучение карточки ${index + 1} из ${flashcards.length}',
          style: TextStyle(color: theme.textColor),
        ),
        iconTheme: IconThemeData(color: theme.textColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlashcardView(card: card),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _feedbackButton('Трудно', theme.redBtnColor, 'hard'),
                _feedbackButton('Нормально', theme.orangeBtnColor, 'normal'),
                _feedbackButton('Легко', theme.greenBtnColor, 'easy'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _next(String difficulty) async {
    final card = flashcards[index];
    updateCardDifficulty(card, difficulty);

    card.lastDifficulty = difficulty;

    await card.save();

    if (index + 1 >= flashcards.length) {
      setState(() => isFinished = true);
    } else {
      setState(() => index++);
    }
  }

  Widget _feedbackButton(String label, Color color, String difficulty) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () => _next(difficulty),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
