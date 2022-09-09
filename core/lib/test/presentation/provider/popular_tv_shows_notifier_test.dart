import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tvshow/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:core/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTVShows mockGetPopularTVShows;
  late PopularTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTVShows = MockGetPopularTVShows();
    notifier = PopularTvNotifier(mockGetPopularTVShows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTVShows.execute())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetPopularTVShows.execute())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    await notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvShows, testTVShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTVShows.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
