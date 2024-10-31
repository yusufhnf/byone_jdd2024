import 'package:flutter_test/flutter_test.dart';
import 'package:byone/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AddTodoViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
