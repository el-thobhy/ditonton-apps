import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/test/presentation/provider/watchlist_movie_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';

@GenerateMocks([MovieModel])
void main() {
  late WatchlistMovieBloc watchlistBloc;
  late MockGetWatchlistMovies mockWatchlistMovies;

  setUp(() {
    mockWatchlistMovies = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMovieBloc(mockWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistMovieEmpty());
  });

  const movieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const movieList = [movieModel];

  group('Watchlist movie', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit Loading and Loaded when Watchlist is successfully',
      build: () {
        when(mockWatchlistMovies.execute())
            .thenAnswer((_) async => const Right(movieList));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieLoaded(movieList),
      ],
      verify: (bloc) {
        verify(mockWatchlistMovies.execute());
        return OnFetchWatchlistMovie().props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should Emit Loading and error state when fail Watchlist',
      build: () {
        when(mockWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should Emit loading and Empty state when data Watchlist is empty',
      build: () {
        when(mockWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockWatchlistMovies.execute());
      },
    );
  });
}
