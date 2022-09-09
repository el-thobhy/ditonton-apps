import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/tv_show_model.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';

import '../../helper/top_rated_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([TvModel])
void main() {
  late TopRatedTvBloc topRatedBloc;
  late MockGetTopRatedTVShows mockTopRatedTvs;

  setUp(() {
    mockTopRatedTvs = MockGetTopRatedTVShows();
    topRatedBloc = TopRatedTvBloc(mockTopRatedTvs);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, TopRatedTvEmpty());
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
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    originCountry: ['us'],
    originalLanguage: 'en',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const tvList = [tvModel];

  group('TopRated Tv', () {
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit Loading and Loaded when TopRated is successfully',
      build: () {
        when(mockTopRatedTvs.execute())
            .thenAnswer((_) async => const Right(tvList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedTvLoading(),
        const TopRatedTvLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockTopRatedTvs.execute());
        return const OnFetchTopRated().props;
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should Emit Loading and error state when fail TopRated',
      build: () {
        when(mockTopRatedTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedTvLoading(),
        const TopRatedTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockTopRatedTvs.execute());
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should Emit loading and Empty state when data TopRated is empty',
      build: () {
        when(mockTopRatedTvs.execute())
            .thenAnswer((_) async => const Right([]));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockTopRatedTvs.execute());
      },
    );
  });
}
