import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/tv_show_model.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/test/presentation/provider/tv_show_list_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';

@GenerateMocks([TvModel])
void main() {
  late PopularTvBloc popularBloc;
  late MockGetPopularTVShows mockPopularTvs;

  setUp(() {
    mockPopularTvs = MockGetPopularTVShows();
    popularBloc = PopularTvBloc(mockPopularTvs);
  });

  test('initial state should be empty', () {
    expect(popularBloc.state, PopularTvEmpty());
  });

  const tvModel = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    originCountry: ['us'],
    originalLanguage: 'en',
    originalName: 'Spider-Man',
  );

  const tvList = [tvModel];

  group('Popular tv', () {
    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit Loading and Loaded when Popular is successfully',
      build: () {
        when(mockPopularTvs.execute())
            .thenAnswer((_) async => const Right(tvList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularTvLoading(),
        const PopularTvLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockPopularTvs.execute());
        return const OnFetchPopular().props;
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should Emit Loading and error state when fail Popular',
      build: () {
        when(mockPopularTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularTvLoading(),
        const PopularTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockPopularTvs.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should Emit loading and Empty state when data Popular is empty',
      build: () {
        when(mockPopularTvs.execute()).thenAnswer((_) async => const Right([]));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularTvLoading(),
        PopularTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockPopularTvs.execute());
      },
    );
  });
}
