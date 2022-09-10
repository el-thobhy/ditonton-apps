import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should be display circular progress when loading state',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
        MovieDetailState.initial().copyWith(detailState: RequestState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display loading in recomendation',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailState.initial().copyWith(
      detailState: RequestState.loaded,
      detail: testMovieDetail,
      recommendationState: RequestState.loading,
      movieRecommendation: <Movie>[],
      isAddedToWatchlist: false,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should be add icon when the data not added to watchlist page yet',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailState.initial().copyWith(
      detailState: RequestState.loaded,
      detail: testMovieDetail,
      recommendationState: RequestState.loaded,
      movieRecommendation: [testMovie],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should be add icon when the data added to watchlist page',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(MovieDetailState.initial().copyWith(
      detailState: RequestState.loaded,
      detail: testMovieDetail,
      recommendationState: RequestState.loaded,
      movieRecommendation: [testMovie],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should be display message when the data add to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([
          MovieDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: [testMovie],
            isAddedToWatchlist: false,
          ),
          MovieDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: [testMovie],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: MovieDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display message when the data remove from watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([
          MovieDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: [testMovie],
            isAddedToWatchlist: false,
          ),
          MovieDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: [testMovie],
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed from Watchlist',
          ),
        ]),
        initialState: MovieDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets('Watchlist button should display dialog when error',
      (WidgetTester tester) async {
    whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([
          MovieDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: [testMovie],
            isAddedToWatchlist: false,
          ),
          MovieDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: [testMovie],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          MovieDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testMovieDetail,
            recommendationState: RequestState.loaded,
            movieRecommendation: [testMovie],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed ',
          ),
        ]),
        initialState: MovieDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Tv Detail should show message error when data error',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailState.initial()
        .copyWith(detailState: RequestState.error, message: 'Failed '));

    final textErrorBarFinder = find.text('Failed ');

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}
