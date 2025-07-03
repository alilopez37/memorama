
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/card_entity.dart';
import '../cubit/memorama_cubit.dart';
import '../widgets/instructions_dialog_widget.dart';
import '../widgets/card_widget.dart';

class MemoramaPage extends StatelessWidget {
  static bool _hasShownInstructions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Memorama')),
      body: BlocBuilder<MemoramaCubit, List<CardEntity>>(
        builder: (context, cards) {
          if (!_hasShownInstructions) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showInstructionsDialog(context);
              _hasShownInstructions = true;
            });
          }
          return GridView.count(
            crossAxisCount: 3,
            children: cards.map((card) {
              return CardWidget(
                card: card,
                onTap: () {
                  context.read<MemoramaCubit>().onCardSelected(card.id);
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.restart_alt),
        onPressed: () => context.read<MemoramaCubit>().initGame(),
      ),
    );
  }
}