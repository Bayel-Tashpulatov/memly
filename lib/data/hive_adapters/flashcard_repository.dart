import 'package:hive/hive.dart';
import 'package:memly/models/flashcard.dart';

class FlashcardRepository {
  final _box = Hive.box<Flashcard>('flashcards');

  List<Flashcard> getAll() => _box.values.toList();

  Future<void> add(Flashcard flashcard) => _box.add(flashcard);

  Future<void> delete(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> update(int index, Flashcard flashcard) =>
      _box.putAt(index, flashcard);
}


