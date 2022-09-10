import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/tvshow/search_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchBloc;
  late MockSearchTv mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTv();
    searchBloc = SearchTvBloc(mockSearchTvs);
  });

  test('Initial state should be empty', () {
    expect(searchBloc.state, SearchTvEmpty());
  });

  const query = 'game';

  group('Search Tv', () {
    blocTest<SearchTvBloc, SearchTvState>(
      'Should return Loading and Loaded state when Search success',
      build: () {
        when(mockSearchTvs.execute(query))
            .thenAnswer((_) async => Right(testTVShowList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryTvChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        SearchTvLoaded(testTVShowList),
      ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(query));
        return const OnQueryTvChanged(query).props;
      },
    );

    blocTest<SearchTvBloc, SearchTvState>(
      'Should return Loading and error state when fail search',
      build: () {
        when(mockSearchTvs.execute(query)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryTvChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        const SearchTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(query));
      },
    );

    blocTest<SearchTvBloc, SearchTvState>(
      'Should Return loading and Empty state when data search is empty',
      build: () {
        when(mockSearchTvs.execute(query))
            .thenAnswer((_) async => const Right([]));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryTvChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        SearchTvEmpty(),
      ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(query));
      },
    );
  });
}
