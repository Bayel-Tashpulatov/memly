import 'package:memly/models/flashcard.dart';

List<Flashcard> getDueFlashcards(List<Flashcard> allCards) {
  final now = DateTime.now();
  return allCards.where((card) => card.nextReview.isBefore(now)).toList();
}
