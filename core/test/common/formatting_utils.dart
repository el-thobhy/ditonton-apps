import 'package:core/common/formatting_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getFormattedDuration tests', () {
    test('should matches with expected duration 1', () {
      const expected = '23m';
      final result = getFormattedDuration(23);

      expect(result, expected);
    });

    test('should matches with expected duration 1', () {
      const expected = '1h 12m';
      final result = getFormattedDuration(72);

      expect(result, expected);
    });
  });

  group('getFormattedDurationFromList tests', () {
    test('should matches with expected duration 1', () {
      const expected = '20m';
      final result = getFormattedDurationFromList([20]);

      expect(result, expected);
    });

    test('should matches with expected duration 1', () {
      const expected = '20m, 1h 12m';
      final result = getFormattedDurationFromList([20, 72]);

      expect(result, expected);
    });
  });
}
