import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memly/appcolors.dart';
import 'package:memly/models/flashcard.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late Future<Map<String, dynamic>> _progressFuture;

  @override
  void initState() {
    super.initState();
    _progressFuture = _getProgress();
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
        title: Text("Прогресс", style: TextStyle(color: theme.headingColor)),
        backgroundColor: theme.backgroundColor,
        foregroundColor: theme.textColor,
      ),
      body: FutureBuilder(
        future: _progressFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          final progress = snapshot.data as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: theme.progressBgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Прогресс за сегодня',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const Divider(thickness: 1, height: 24),
                        Text(
                          'Изучено карточек: ${progress['studiedToday']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: theme.textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Легко: ${progress['easy']}',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                        Text(
                          'Нормально: ${progress['normal']}',
                          style: TextStyle(fontSize: 16, color: Colors.orange),
                        ),
                        Text(
                          'Трудно: ${progress['hard']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: _resetProgress,
                  icon: Icon(Icons.refresh, color: theme.btnTextColor),
                  label: Text(
                    'Сбросить прогресс',
                    style: TextStyle(color: theme.btnTextColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _getProgress() async {
    final box = await Hive.openBox<Flashcard>('flashcards');
    final flashcards = box.values.toList();

    final today = DateTime.now();
    int studiedToday = 0;
    int easy = 0;
    int normal = 0;
    int hard = 0;

    for (var card in flashcards) {
      final reviewed = card.lastReviewed;

      // Пропустить карточки, которые ещё не были изучены
      if (reviewed == null) continue;

      if (reviewed.year == today.year &&
          reviewed.month == today.month &&
          reviewed.day == today.day) {
        studiedToday++;

        switch (card.lastDifficulty) {
          case 'easy':
            easy++;
            break;
          case 'normal':
            normal++;
            break;
          case 'hard':
            hard++;
            break;
        }
      }
    }

    return {
      'studiedToday': studiedToday,
      'easy': easy,
      'normal': normal,
      'hard': hard,
    };
  }

  Future<void> _resetProgress() async {
    final box = await Hive.openBox<Flashcard>('flashcards');
    for (var i = 0; i < box.length; i++) {
      final card = box.getAt(i);
      if (card != null) {
        card.timesReviewed = 0;
        card.retentionRate = null;
        card.interval = 1;
        card.easeFactor = 2;
        card.lastReviewed = DateTime.now();
        card.lastDifficulty = null;
        await box.putAt(i, card);
      }
    }

    setState(() {
      _progressFuture = _getProgress();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Прогресс сброшен")));
  }
}
