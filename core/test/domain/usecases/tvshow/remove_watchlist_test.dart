import 'package:core/helpers/test_helper.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockTvRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvRepository();
    usecase = RemoveWatchlist(mockTVShowRepository);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTVShowRepository.removeWatchlist(testTVShowDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVShowDetail);
    // assert
    verify(mockTVShowRepository.removeWatchlist(testTVShowDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
