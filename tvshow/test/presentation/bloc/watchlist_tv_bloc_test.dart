import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:tvshow/presentation/bloc/watchlist_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvBloc watchlistBloc;
  late MockGetWatchlistTv mockWatchlistTvs;

  setUp(() {
    mockWatchlistTvs = MockGetWatchlistTv();
    watchlistBloc = WatchlistTvBloc(mockWatchlistTvs);
  });

  test('Initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistTvEmpty());
  });

  group('Watchlist Tv', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should return Loading and Loaded state when fetch data success',
      build: () {
        when(mockWatchlistTvs.execute())
            .thenAnswer((_) async => Right(testTVShowList));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvLoaded(testTVShowList),
      ],
      verify: (bloc) {
        verify(mockWatchlistTvs.execute());
        return OnFetchWatchlistTv().props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should return Loading and error state when fetch data fail',
      build: () {
        when(mockWatchlistTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockWatchlistTvs.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should return loading and Empty state when data is empty',
      build: () {
        when(mockWatchlistTvs.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockWatchlistTvs.execute());
      },
    );
  });
}
