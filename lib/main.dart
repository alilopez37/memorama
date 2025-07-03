import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/memorama/data/repositories_impl/memorama_repository_impl.dart';
import 'features/memorama/domain/usecases/select_card_usecase.dart';
import 'features/memorama/domain/usecases/start_game_usecase.dart';
import 'features/memorama/presentation/cubit/memorama_cubit.dart';
import 'features/memorama/presentation/pages/memorama_page.dart';

void main() {
  final repo = MemoramaRepositoryImpl();
  final startGame = StartGameUseCase(repo);
  final selectCard = SelectCardUseCase(repo);

  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (_) => MemoramaCubit(startGameUseCase: startGame, selectCardUseCase: selectCard)..initGame(),
        child: MemoramaPage(),
      ),
    ),
  );
}

