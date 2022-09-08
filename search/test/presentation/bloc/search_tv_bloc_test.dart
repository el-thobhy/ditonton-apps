import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/test/presentation/provider/search_notifier_test.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/tvshow/search_tv_bloc.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchBloc;
  late MockSearchTVShows mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTVShows();
    searchBloc = SearchTvBloc(mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTvEmpty());
  });

  const tvModel = TvShow(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
    originCountry: ["US"],
    originalLanguage: 'en',
  );

  const tvList = [tvModel];
  const query = 'game';

  group('Search Tv', () {
    blocTest<SearchTvBloc, SearchTvState>(
      'Should emit Loading and Loaded when Search is successfully',
      build: () {
        when(mockSearchTvs.execute(query))
            .thenAnswer((_) async => const Right(tvList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryTvChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        const SearchTvLoaded(tvList),
      ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(query));
        return const OnQueryTvChanged(query).props;
      },
    );

    blocTest<SearchTvBloc, SearchTvState>(
      'Should Emit Loading and error state when fail search',
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
      'Should Emit loading and Empty state when data search is empty',
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
