import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:tvshow/presentation/bloc/now_playing_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_palying_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late NowPlayingTvBloc nowPlayingBloc;
  late MockGetNowPlayingTv mockNowPlayingTvs;

  setUp(() {
    mockNowPlayingTvs = MockGetNowPlayingTv();
    nowPlayingBloc = NowPlayingTvBloc(mockNowPlayingTvs);
  });

  test('Initial state should be empty', () {
    expect(nowPlayingBloc.state, NowPlayingTvEmpty());
  });

  group('NowPlaying Tv', () {
    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should Return Loading and Loaded when fetch data success',
      build: () {
        when(mockNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(testTVShowList));
        return nowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnFetchNowPlaying()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NowPlayingTvLoading(),
        NowPlayingTvLoaded(testTVShowList),
      ],
      verify: (bloc) {
        verify(mockNowPlayingTvs.execute());
        return const OnFetchNowPlaying().props;
      },
    );

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Should Return Loading and error state when fail fetch data',
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
      'Should Return loading and Empty state when fetch data  is empty',
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
