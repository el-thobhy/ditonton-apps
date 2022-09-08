import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = GetWatchlistTv(mockTVShowRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTVShowRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVShowList));
  });
}
