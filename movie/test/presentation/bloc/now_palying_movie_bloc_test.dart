import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/test/presentation/provider/movie_list_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';

@GenerateMocks([MovieModel])
void main() {
  late NowPlayingMovieBloc nowPlayingBloc;
  late MockGetNowPlayingMovies mockNowPlayingMovies;

  setUp(() {
    mockNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingBloc = NowPlayingMovieBloc(mockNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingBloc.state, NowPlayingMovieEmpty());
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

  group('NowPlaying movie', () {
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit Loading and Loaded when NowPlaying is successfully',
      build: () {
        when(mockNowPlayingMovies.execute())
            .thenAnswer((_) async => const Right(movieList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnFetchNowPlaying()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NowPlayingMovieLoading(),
        const NowPlayingMovieLoaded(movieList),
      ],
      verify: (bloc) {
        verify(mockNowPlayingMovies.execute());
        return const OnFetchNowPlaying().props;
      },
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should Emit Loading and error state when fail NowPlaying',
      build: () {
        when(mockNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnFetchNowPlaying()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NowPlayingMovieLoading(),
        const NowPlayingMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should Emit loading and Empty state when data NowPlaying is empty',
      build: () {
        when(mockNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Right([]));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnFetchNowPlaying()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieEmpty(),
      ],
      verify: (bloc) {
        verify(mockNowPlayingMovies.execute());
      },
    );
  });
}