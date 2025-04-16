import 'package:memly/models/flashcard.dart';

void updateCardDifficulty(Flashcard card, String difficulty) {
  final now = DateTime.now();

  switch (difficulty) {
    case 'hard':
      card.interval = 1;
      card.nextReview = now.add(Duration(minutes: 1));
      break;
    case 'normal':
      card.interval = 15;
      card.nextReview = now.add(Duration(minutes: 15));
      break;
    case 'easy':
      card.interval = 120;
      card.nextReview = now.add(Duration(hours: 2));
      break;
  }

  card.timesReviewed += 1;
  card.lastReviewed = now;
  card.easeFactor += 1;
}
