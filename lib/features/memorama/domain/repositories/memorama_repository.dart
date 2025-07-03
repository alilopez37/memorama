
import 'package:memorama/features/memorama/domain/entities/card_entity.dart';

abstract class MemoramaRepository {
  List<CardEntity> getBoard();
  void setBoard(List<CardEntity> board);
  void reset();
}
