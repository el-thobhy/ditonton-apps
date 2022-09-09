import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshow/presentation/bloc/tv_detail_bloc.dart';
import 'package:tvshow/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'TV detail should be display circular progress when application is loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(
        TvDetailState.initial().copyWith(detailState: RequestState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const TVShowDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Recommendation should display loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailState.initial().copyWith(
      detailState: RequestState.loaded,
      detail: testTVShowDetail,
      recommendationState: RequestState.loading,
      tvRecommendation: <TvShow>[],
      isAddedToWatchlist: false,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const TVShowDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Button on the watchlist should add icon when the data not added to watchlist page',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailState.initial().copyWith(
      detailState: RequestState.loaded,
      detail: testTVShowDetail,
      recommendationState: RequestState.loaded,
      tvRecommendation: [testTVShow],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const TVShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Button on the watchlist should add icon when the data added to watchlist page',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailState.initial().copyWith(
      detailState: RequestState.loaded,
      detail: testTVShowDetail,
      recommendationState: RequestState.loaded,
      tvRecommendation: [testTVShow],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const TVShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Button on the watchlist shoild add message when the data add to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockTvDetailBloc,
        Stream.fromIterable([
          TvDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testTVShowDetail,
            recommendationState: RequestState.loaded,
            tvRecommendation: [testTVShow],
            isAddedToWatchlist: false,
          ),
          TvDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testTVShowDetail,
            recommendationState: RequestState.loaded,
            tvRecommendation: [testTVShow],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: TvDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const TVShowDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Button on the watchlist shoild add message when the data remove from watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockTvDetailBloc,
        Stream.fromIterable([
          TvDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testTVShowDetail,
            recommendationState: RequestState.loaded,
            tvRecommendation: [testTVShow],
            isAddedToWatchlist: false,
          ),
          TvDetailState.initial().copyWith(
            detailState: RequestState.loaded,
            detail: testTVShowDetail,
            recommendationState: RequestState.loaded,
            tvRecommendation: [testTVShow],
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed from Watchlist',
          ),
        ]),
        initialState: TvDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const TVShowDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets('Tv Detail should add message error when data error',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(TvDetailState.initial()
        .copyWith(
            detailState: RequestState.error, message: 'Failed to connect '));

    final textErrorBarFinder = find.text('Failed to connect ');

    await tester.pumpWidget(makeTestableWidget(const TVShowDetailPage(id: 1)));
    await tester.pump();

    expect(textErrorBarFinder, findsOneWidget);
  });
}
