import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'flashcard.g.dart';

@HiveType(typeId: 32)
class Flashcard extends HiveObject {
  @HiveField(0)
  late final String front;

  @HiveField(1)
  late final String back;

  @HiveField(2)
  int timesReviewed;

  @HiveField(3)
  int score;

  @HiveField(4)
  int deckId;

  @HiveField(5)
  double? retentionRate;

  @HiveField(6)
  int interval;

  @HiveField(7)
  int easeFactor;

  @HiveField(8)
  DateTime? lastReviewed;

  @HiveField(9)
  DateTime nextReview;

  @HiveField(10)
  String? lastDifficulty;

  @HiveField(11)
  late final String id;

  // Constructor with default value for lastDifficulty
  Flashcard({
    required this.front,
    required this.back,
    this.timesReviewed = 0,
    required this.deckId,
    this.score = 1,
    this.retentionRate,
    this.interval = 1,
    this.easeFactor = 2,
    this.lastReviewed,
    this.lastDifficulty,
    DateTime? nextReview,
  }) : nextReview = nextReview ?? DateTime.now(),
       id = UniqueKey().toString();
}
