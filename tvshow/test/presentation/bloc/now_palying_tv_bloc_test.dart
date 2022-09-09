import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/tv_show_model.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/test/presentation/bloc/tv_show_list_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/presentation/bloc/now_playing_tv_bloc.dart';

@GenerateMocks([TvModel])
void main() {
  late NowPlayingTvBloc nowPlayingBloc;
  late MockGetNowPlayingTVShows mockNowPlayingTvs;

  setUp(() {
    mockNowPlayingTvs = MockGetNowPlayingTVShows();
    nowPlayingBloc = NowPlayingTvBloc(mockNowPlayingTvs);
  });

  test('initial state should be empty', () {
    expect(nowPlayingBloc.state, NowPlayingTvEmpty());
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

  group('NowPlaying Tv', () {
    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should emit Loading and Loaded when NowPlaying is successfully',
      build: () {
        when(mockNowPlayingTvs.execute())
            .thenAnswer((_) async => const Right(tvList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnFetchNowPlaying()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NowPlayingTvLoading(),
        const NowPlayingTvLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockNowPlayingTvs.execute());
        return const OnFetchNowPlaying().props;
      },
    );

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should Emit Loading and error state when fail NowPlaying',
      build: () {
        when(mockNowPlayingTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnFetchNowPlaying()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NowPlayingTvLoading(),
        const NowPlayingTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockNowPlayingTvs.execute());
      },
    );

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should Emit loading and Empty state when data NowPlaying is empty',
      build: () {
        when(mockNowPlayingTvs.execute())
            .thenAnswer((_) async => const Right([]));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnFetchNowPlaying()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NowPlayingTvLoading(),
        NowPlayingTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockNowPlayingTvs.execute());
      },
    );
  });
}
