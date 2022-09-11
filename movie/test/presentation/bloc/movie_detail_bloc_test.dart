import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatusMovie,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatusMovie mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();

    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusMovie();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchlistStatus,
    );
  });

  const id = 1;
  final movieDetailStateInit = MovieDetailState.initial();
  const tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  const movies = <Movie>[tMovie];

  group(
    'Get Movie Detail',
    () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should show movie detail when data is success',
        build: () {
          when(mockGetMovieDetail.execute(id))
              .thenAnswer((_) async => const Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(id))
              .thenAnswer((_) async => const Right(movies));
          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchMovieDetail(id)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(detailState: RequestState.loading),
          movieDetailStateInit.copyWith(
            recommendationState: RequestState.loading,
            detail: testMovieDetail,
            detailState: RequestState.loaded,
            message: '',
          ),
          movieDetailStateInit.copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: movies,
            message: '',
          ),
        ],
        verify: (bloc) {
          mockGetMovieDetail.execute(id);
          mockGetMovieRecommendations.execute(id);
        },
      );
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should return Error state when fetch data is failed',
        build: () {
          when(mockGetMovieDetail.execute(id)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockGetMovieRecommendations.execute(id)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchMovieDetail(id)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailStateInit.copyWith(detailState: RequestState.loading),
          movieDetailStateInit.copyWith(
            recommendationState: RequestState.empty,
            detailState: RequestState.error,
          ),
          movieDetailStateInit.copyWith(
            recommendationState: RequestState.error,
            detailState: RequestState.error,
          ),
        ],
        verify: (bloc) {
          mockGetMovieDetail.execute(id);
        },
      );
    },
  );
}
