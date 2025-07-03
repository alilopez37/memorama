
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructionsDialogWidget extends StatelessWidget {
  const InstructionsDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('¿Cómo jugar el Memorama?'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/memo.png',
                fit: BoxFit.cover,
                width: 250,
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔹 Voltea dos cartas por turno.'),
                  SizedBox(height: 8),
                  Text('🔹 Si coinciden, se quedan descubiertas.'),
                  SizedBox(height: 8),
                  Text('🔹 Si no, se voltean de nuevo.'),
                  SizedBox(height: 8),
                  Text('🎯 Encuentra todas las parejas para ganar.'),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('¡Entendido!'),
        ),
      ],
    );
  }
}

// función exportada
void showInstructionsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const InstructionsDialogWidget(),
  );
}