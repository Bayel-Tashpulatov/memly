import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memly/data/hive_adapters/flashcard_repository.dart';
import 'package:memly/models/flashcard.dart';
import 'package:memly/providers/flashcard_provider.dart';

class FlashcardNotifier extends StateNotifier<List<Flashcard>> {
  final FlashcardRepository repo;

  FlashcardNotifier(this.repo) : super(repo.getAll());

  void addCard(Flashcard card) {
    repo.add(card);
    state = repo.getAll();
  }

  void deleteCard(int index) {
    repo.delete(index);
    state = repo.getAll();
  }

  void refresh(){
    state = repo.getAll();
  }
}

final flashcardListProvider = StateNotifierProvider<FlashcardNotifier, List<Flashcard>>((ref) {
  final repo = ref.read(flashcardRepositoryProvider);
  return FlashcardNotifier(repo);
});
void updateCardReview(Flashcard card, int rating){
  // Обновляем количество попыток
  card.timesReviewed++;
}