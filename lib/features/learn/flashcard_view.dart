import 'package:flutter/material.dart';
import 'package:memly/appcolors.dart';
import 'package:memly/models/flashcard.dart';

class FlashcardView extends StatefulWidget {
  final Flashcard card;
  const FlashcardView({super.key, required this.card});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  bool isFront = true;

  @override
  void didUpdateWidget(covariant FlashcardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.card != widget.card) {
      setState(() => isFront = true); // Сбрасываем на лицевую сторону
    }
  }

  void _flipCard() {
    setState(() => isFront = !isFront);
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).brightness == Brightness.dark
            ? DarkAppColor()
            : LightAppColor();
    return GestureDetector(
      onTap: _flipCard,
      child: _buildCard(
        isFront ? widget.card.front : widget.card.back,
        theme,
      ),
    );
  }

  Widget _buildCard(String text, dynamic theme) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 12, color: Colors.black26)],
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: theme.textColor),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
