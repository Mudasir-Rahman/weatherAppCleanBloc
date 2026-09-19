import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app_bloc/injection_container.dart' as di;
import 'package:weather_app_bloc/main.dart';

void main() {
  testWidgets('Weather app shows a polished dashboard title', (tester) async {
    await di.init();
    await tester.pumpWidget(const MyApp());

    expect(find.text('SkyCast'), findsOneWidget);
  });
}
