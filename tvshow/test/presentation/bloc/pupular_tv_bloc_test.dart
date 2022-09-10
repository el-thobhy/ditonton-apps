import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvshow/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'pupular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTvBloc popularBloc;
  late MockGetPopularTv mockPopularTvs;

  setUp(() {
    mockPopularTvs = MockGetPopularTv();
    popularBloc = PopularTvBloc(mockPopularTvs);
  });

  test('Initial state should be empty', () {
    expect(popularBloc.state, PopularTvEmpty());
  });

  group('Popular tv', () {
    blocTest<PopularTvBloc, PopularTvState>(
      'Should Return Loading and Loaded when fetch data success',
      build: () {
        when(mockPopularTvs.execute())
            .thenAnswer((_) async => Right(testTVShowList));
        return popularBloc;
      },
      act: (bloc) => bloc.add(const OnFetchPopular()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularTvLoading(),
        PopularTvLoaded(testTVShowList),
      ],
      verify: (bloc) {
        verify(mockPopularTvs.execute());
        return const OnFetchPopular().props;
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should Return Loading and error state when fetch data fail',
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
      'Should Return loading and Empty state when data is empty',
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
