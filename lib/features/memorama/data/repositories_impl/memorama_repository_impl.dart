
import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/entities/card_entity.dart';
import '../../domain/repositories/memorama_repository.dart';

class MemoramaRepositoryImpl implements MemoramaRepository {
  List<CardEntity> _board = [];
  CardEntity? _firstSelected;

  @override
  List<CardEntity> getBoard() => _board;

  @override
  void setBoard(List<CardEntity> board) => _board = board;

  @override
  void reset() {
    _firstSelected = null;

    // Lista de íconos para las cartas (deben ser pares)
    final icons = [
      Icons.star,
      Icons.favorite,
      Icons.cake,
      Icons.directions_car,
      Icons.pets,
      Icons.beach_access,
    ];

    final shuffled = [...icons, ...icons]..shuffle(Random());

    _board = shuffled.asMap().entries.map((entry) {
      return CardEntity(id: entry.key, icon: entry.value);
    }).toList();
  }

  // Acceso temporal a _firstSelected para el caso de uso
  CardEntity? get firstSelected => _firstSelected;
  void setFirstSelected(CardEntity? card) => _firstSelected = card;
}