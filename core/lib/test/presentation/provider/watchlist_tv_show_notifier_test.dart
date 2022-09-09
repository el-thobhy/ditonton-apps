import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:tvshow/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:core/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_show_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvNotifier provider;
  late MockGetWatchlistTVShows mockGetWatchlistTVShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTVShows = MockGetWatchlistTVShows();
    provider = WatchlistTvNotifier(
      getWatchlistTv: mockGetWatchlistTVShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetWatchlistTVShows.execute())
        .thenAnswer((_) async => Right(testWatchlistTVShow));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistTv, testWatchlistTVShow);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTVShows.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTv();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
