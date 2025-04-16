import 'package:hive/hive.dart';

part 'deck.g.dart';

@HiveType(typeId: 33)
class Deck extends HiveObject {
  @HiveField(0)
  final String title;

  Deck({required this.title});
}
