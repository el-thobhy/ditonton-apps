import 'package:core/helpers/test_helper.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:tvshow/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTvRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvRepository();
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
