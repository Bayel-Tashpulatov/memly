// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlashcardAdapter extends TypeAdapter<Flashcard> {
  @override
  final int typeId = 32;

  @override
  Flashcard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Flashcard(
      front: fields[0] as String,
      back: fields[1] as String,
      timesReviewed: fields[2] as int,
      deckId: fields[4] as int,
      score: fields[3] as int,
      retentionRate: fields[5] as double?,
      interval: fields[6] as int,
      easeFactor: fields[7] as int,
      lastReviewed: fields[8] as DateTime?,
      lastDifficulty: fields[10] as String?,
      nextReview: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Flashcard obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.front)
      ..writeByte(1)
      ..write(obj.back)
      ..writeByte(2)
      ..write(obj.timesReviewed)
      ..writeByte(3)
      ..write(obj.score)
      ..writeByte(4)
      ..write(obj.deckId)
      ..writeByte(5)
      ..write(obj.retentionRate)
      ..writeByte(6)
      ..write(obj.interval)
      ..writeByte(7)
      ..write(obj.easeFactor)
      ..writeByte(8)
      ..write(obj.lastReviewed)
      ..writeByte(9)
      ..write(obj.nextReview)
      ..writeByte(10)
      ..write(obj.lastDifficulty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlashcardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
