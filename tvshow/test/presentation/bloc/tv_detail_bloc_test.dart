import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:tvshow/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:tvshow/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:tvshow/domain/usecases/tv_show/save_watchlist.dart';
import 'package:tvshow/presentation/bloc/tv_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  MockGetWatchListStatusTVShow,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvDetailBloc bloc;
  late MockGetTVShowDetail mockGetTvDetail;
  late MockGetTVShowRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTVShow mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTVShowDetail();

    mockGetTvRecommendations = MockGetTVShowRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTVShow();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = TvDetailBloc(
      mockGetTvDetail,
      mockGetTvRecommendations,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchlistStatus,
    );
  });

  const id = 1;
  final tvDetailStateInit = TvDetailState.initial();
  const tTv = TvShow(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    originCountry: ['us'],
    originalLanguage: 'en',
    voteAverage: 1,
    voteCount: 1,
  );
  const tvs = <TvShow>[tTv];


  group(
    'Get Tv Detail',
    () {
      blocTest<TvDetailBloc, TvDetailState>(
        'Should show Tv detail when data is succesfully',
        build: () {
          when(mockGetTvDetail.execute(id))
              .thenAnswer((_) async => Right(testTVShowDetail));
          when(mockGetTvRecommendations.execute(id))
              .thenAnswer((_) async => const Right(tvs));
          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(id)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(detailState: RequestState.loading),
          tvDetailStateInit.copyWith(
            recommendationState: RequestState.loading,
            detail: testTVShowDetail,
            detailState: RequestState.loaded,
            message: '',
          ),
          tvDetailStateInit.copyWith(
            detailState: RequestState.loaded,
            detail: testTVShowDetail,
            recommendationState: RequestState.loaded,
            tvRecommendation: tvs,
            message: '',
          ),
        ],
        verify: (bloc) {
          mockGetTvDetail.execute(id);
          mockGetTvRecommendations.execute(id);
        },
      );
      blocTest<TvDetailBloc, TvDetailState>(
        'Should return Error when fetch data is failed',
        build: () {
          when(mockGetTvDetail.execute(id)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          when(mockGetTvRecommendations.execute(id)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(const OnFetchTvDetail(id)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailStateInit.copyWith(detailState: RequestState.loading),
          tvDetailStateInit.copyWith(
            recommendationState: RequestState.empty,
            detailState: RequestState.error,
          ),
          tvDetailStateInit.copyWith(
            recommendationState: RequestState.error,
            detailState: RequestState.error,
          ),
        ],
        verify: (bloc) {
          mockGetTvDetail.execute(id);
        },
      );
    },
  );
}
