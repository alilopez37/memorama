
import 'package:bloc/bloc.dart';

import '../../domain/entities/card_entity.dart';
import '../../domain/usecases/select_card_usecase.dart';
import '../../domain/usecases/start_game_usecase.dart';

class MemoramaCubit extends Cubit<List<CardEntity>> {
  final StartGameUseCase startGameUseCase;
  final SelectCardUseCase selectCardUseCase;

  MemoramaCubit({
    required this.startGameUseCase,
    required this.selectCardUseCase,
  }) : super([]);

  void initGame() {
    final board = startGameUseCase();
    emit(board);
  }

  void onCardSelected(int id) async {
    // Voltear inmediatamente la carta seleccionada
    final flippedBoard = selectCardUseCase.flipCard(id);
    emit(flippedBoard);

    // Verificar si ya hay dos cartas faceUp
    if (flippedBoard.where((c) => c.isFaceUp && !c.isMatched).length == 2) {
      final processedBoard = await selectCardUseCase.processMatch();
      emit(processedBoard);
    }
  }
}