

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/card_entity.dart';
import 'flip_card_widget.dart';

class CardWidget extends StatelessWidget {
  final CardEntity card;
  final VoidCallback onTap;

  const CardWidget({
    Key? key,
    required this.card,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCardWidget(
      isFlipped: card.isFaceUp || card.isMatched,
      onTap: () {
        if (!card.isFaceUp && !card.isMatched) {
          onTap();
        }
      },
      front: _buildBackCard(),
      back: _buildFrontCard(card),
    );
  }

  Widget _buildBackCard() {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildFrontCard(CardEntity card) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: card.isMatched ? Colors.green[400] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Center(
        child: Icon(
          card.icon,
          size: 40,
          color: Colors.black87,
        ),
      ),
    );
  }
}