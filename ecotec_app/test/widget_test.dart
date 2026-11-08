import 'package:flutter_test/flutter_test.dart';
import 'package:nexo_portfolio/main.dart';

void main() {
  testWidgets('La aplicación construye la raíz de Nexo Portfolio', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.byType(PortfolioApp), findsOneWidget);
    expect(find.text('Nexo Portfolio'), findsWidgets);
  });
}
