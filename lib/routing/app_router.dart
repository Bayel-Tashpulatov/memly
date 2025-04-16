import 'package:go_router/go_router.dart';
import 'package:memly/features/chat/chat_page.dart';
import 'package:memly/decks/deck_list_page.dart';
import 'package:memly/features/flashcards/flashcard_page.dart';
import 'package:memly/features/home/home_page.dart';
import 'package:memly/features/learn/learn_page.dart';
import 'package:memly/features/progress/progress_page.dart';
import 'package:memly/features/settings/settings_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/learn/:deckId',
        builder: (context, state) {
          final deckId = state.pathParameters['deckId']!;
          return LearnPage(deckId: deckId);
        },
      ),

      GoRoute(
        path: '/progress',
        builder: (context, state) => const ProgressPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/flashcards',
        builder: (context, state) => const DeckListPage(),
      ),
      GoRoute(
        path: '/deck/:id',
        builder: (context, state) {
          final deckId = int.parse(state.pathParameters['id']!);
          return FlashcardPage(deckId: deckId);
        },
      ),
      GoRoute(path: '/ai-chat', builder: (context, state) => const ChatPage()),
    ],
  );
}
