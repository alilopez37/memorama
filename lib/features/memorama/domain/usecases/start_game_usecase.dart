
import 'dart:math';

import 'package:flutter/material.dart';

import '../entities/card_entity.dart';
import '../repositories/memorama_repository.dart';

class StartGameUseCase {
  final MemoramaRepository repository;

  StartGameUseCase(this.repository);

  List<CardEntity> call() {
    final iconList = [
      Icons.star,
      Icons.favorite,
      Icons.cake,
      Icons.directions_car,
      Icons.pets,
      Icons.beach_access,
      //Icons.lightbulb,
      //Icons.flight,
    ];

    final random = Random();
    final icons = [...iconList, ...iconList]..shuffle(random);

    final board = List.generate(
      icons.length,
          (index) => CardEntity(id: index, icon: icons[index]),
    );

    repository.setBoard(board);
    return board;
  }
}