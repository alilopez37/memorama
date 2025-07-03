
import '../entities/card_entity.dart';
import '../repositories/memorama_repository.dart';

class SelectCardUseCase {
  final MemoramaRepository repository;
  CardEntity? _firstSelected;
  bool _isProcessing = false;

  SelectCardUseCase(this.repository);

  // Paso 1: voltear carta inmediatamente
  List<CardEntity> flipCard(int id) {
    final board = repository.getBoard();
    final selected = board.firstWhere((c) => c.id == id);

    if (selected.isFaceUp || selected.isMatched || _isProcessing) return board;

    final flippedBoard = board.map((c) {
      return c.id == id ? c.copyWith(isFaceUp: true) : c;
    }).toList();

    repository.setBoard(flippedBoard);

    if (_firstSelected == null) {
      _firstSelected = selected;
    }

    return flippedBoard;
  }

  // Paso 2: procesar match o no match
  Future<List<CardEntity>> processMatch() async {
    final board = repository.getBoard();
    final faceUpCards = board.where((c) => c.isFaceUp && !c.isMatched).toList();

    if (faceUpCards.length < 2 || _isProcessing) return board;

    _isProcessing = true;
    final first = _firstSelected!;
    final second = faceUpCards.firstWhere((c) => c.id != first.id);

    if (first.icon == second.icon) {
      await Future.delayed(const Duration(milliseconds: 500));

      final matchedBoard = board.map((c) {
        if (c.id == first.id || c.id == second.id) {
          return c.copyWith(isMatched: true);
        }
        return c;
      }).toList();

      repository.setBoard(matchedBoard);
    } else {
      await Future.delayed(const Duration(milliseconds: 1500));

      final revertedBoard = board.map((c) {
        if (c.id == first.id || c.id == second.id) {
          return c.copyWith(isFaceUp: false);
        }
        return c;
      }).toList();

      repository.setBoard(revertedBoard);
    }

    _firstSelected = null;
    _isProcessing = false;
    return repository.getBoard();
  }
}