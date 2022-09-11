import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvBloc topRatedBloc;
  late MockGetTopRatedTv mockTopRatedTvs;

  setUp(() {
    mockTopRatedTvs = MockGetTopRatedTv();
    topRatedBloc = TopRatedTvBloc(mockTopRatedTvs);
  });

  test('Initial state should be empty', () {
    expect(topRatedBloc.state, TopRatedTvEmpty());
  });

  group('TopRated Tv', () {
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should return Loading and Loaded state when fetch data success',
      build: () {
        when(mockTopRatedTvs.execute())
            .thenAnswer((_) async => Right(testTVShowList));
        return topRatedBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTopRated()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvLoaded(testTVShowList),
      ],
      verify: (bloc) {
        verify(mockTopRatedTvs.execute());
        return const OnFetchTopRated().props;
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should return Loading and error state when fetch data fail',
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
      'Should return loading and Empty state when data is empty',
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
