import 'package:flutter/cupertino.dart';

class CardEntity {
  final int id;
  final IconData icon;        // <-- Cambia de String a IconData
  final bool isFaceUp;
  final bool isMatched;

  CardEntity({
    required this.id,
    required this.icon,
    this.isFaceUp = false,
    this.isMatched = false,
  });

  CardEntity copyWith({
    int? id,
    IconData? icon,
    bool? isFaceUp,
    bool? isMatched,
  }) {
    return CardEntity(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      isFaceUp: isFaceUp ?? this.isFaceUp,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}