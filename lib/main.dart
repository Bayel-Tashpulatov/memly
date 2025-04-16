import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memly/app.dart';
import 'package:memly/models/deck.dart';
import 'package:memly/models/flashcard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DeckAdapter());
  Hive.registerAdapter(FlashcardAdapter());

  // // Очистка для теста
  // await Hive.deleteBoxFromDisk('flashcards');

  await Hive.openBox<Flashcard>('flashcards');

  await dotenv.load(fileName: ".env");
  

  runApp(const ProviderScope(child: MemlyApp()));
}
