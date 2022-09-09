import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/tv_show_model.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/test/presentation/bloc/watchlist_tv_show_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/presentation/bloc/watchlist_tv_bloc.dart';

@GenerateMocks([TvModel])
void main() {
  late WatchlistTvBloc watchlistBloc;
  late MockGetWatchlistTVShows mockWatchlistTvs;

  setUp(() {
    mockWatchlistTvs = MockGetWatchlistTVShows();
    watchlistBloc = WatchlistTvBloc(mockWatchlistTvs);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistTvEmpty());
  });

  const tvModel = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: '2002-05-01',
    originCountry: ['us'],
    originalLanguage: 'en',
  );

  const tvList = [tvModel];

  group('Watchlist Tv', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit Loading and Loaded when Watchlist is successfully',
      build: () {
        when(mockWatchlistTvs.execute())
            .thenAnswer((_) async => const Right(tvList));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockWatchlistTvs.execute());
        return OnFetchWatchlistTv().props;
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should Emit Loading and error state when fail Watchlist',
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
      'Should Emit loading and Empty state when data Watchlist is empty',
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
