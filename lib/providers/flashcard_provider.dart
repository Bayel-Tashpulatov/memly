import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memly/data/hive_adapters/flashcard_repository.dart';

final flashcardRepositoryProvider = Provider((ref) => FlashcardRepository());
