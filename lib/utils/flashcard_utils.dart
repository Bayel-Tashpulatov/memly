import 'package:memly/models/flashcard.dart';

void updateCardDifficulty(Flashcard card, String difficulty) {
  final now = DateTime.now();
  double ef = (card.easeFactor is int ? (card.easeFactor).toDouble() : card.easeFactor) as double;

  // Update easeFactor based on difficulty
  switch (difficulty) {
    case 'hard':
      ef = (ef - 0.15).clamp(1.3, 2.5); // Минимум 1.3
      card.interval = 1;
      card.nextReview = now.add(Duration(minutes: 1));
      break;

    case 'normal':
      ef = (ef - 0.05).clamp(1.3, 2.5);
      card.interval = (card.interval * ef).round();
      card.nextReview = now.add(Duration(minutes: card.interval));
      break;

    case 'easy':
      ef = (ef + 0.1).clamp(1.3, 2.5);
      card.interval = (card.interval * ef * 1.2).round();
      card.nextReview = now.add(Duration(minutes: card.interval));
      break;
  }

  card.easeFactor = ef.toInt();
  card.lastReviewed = now;
  card.timesReviewed += 1;
}
