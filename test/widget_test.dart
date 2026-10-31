import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cadastro_usuario/main.dart';

void main() {
  testWidgets('Exibe erros ao cadastrar com campos vazios', (tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.tap(find.text('CADASTRAR'));
    await tester.pump();

    expect(find.text('Digite seu nome completo'), findsOneWidget);
    expect(find.text('Digite seu e-mail'), findsOneWidget);
  });
}