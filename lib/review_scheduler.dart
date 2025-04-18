import 'package:memly/models/flashcard.dart';

Set<String> seenCardIds = {}; // ID карточек, показанных в этой сессии

List<Flashcard> getCardsForSession(List<Flashcard> allCards) {
  final now = DateTime.now();

  return allCards.where((card) {
    final isDue = card.nextReview.isBefore(now);
    final notSeenThisSession = !seenCardIds.contains(card.id);
    return isDue && notSeenThisSession;
  }).toList();
}

void markCardAsSeen(Flashcard card) {
  seenCardIds.add(card.id);
}

void resetSession() {
  seenCardIds.clear();
}
