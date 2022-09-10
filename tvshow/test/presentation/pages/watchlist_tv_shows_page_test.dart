import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:tvshow/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tvshow/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_shows_page_test.mocks.dart';

@GenerateMocks([WatchlistTvBloc])
void main() {
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUp(() {
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>(
      create: (context) => mockWatchlistTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display circular progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvLoading()));
    when(mockWatchlistTvBloc.state).thenReturn(WatchlistTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display Data when data is loaded',
      (WidgetTester tester) async {
    final tvList = <TvShow>[];
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvLoaded(tvList)));
    when(mockWatchlistTvBloc.state).thenReturn(WatchlistTvLoaded(tvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockWatchlistTvBloc.stream).thenAnswer(
        (_) => Stream.value(const WatchlistTvError('Error message')));
    when(mockWatchlistTvBloc.state)
        .thenReturn(const WatchlistTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Home page should display empty container when data Empty',
      (WidgetTester tester) async {
    when(mockWatchlistTvBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvEmpty()));
    when(mockWatchlistTvBloc.state).thenReturn(WatchlistTvEmpty());

    final finder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    expect(finder, findsOneWidget);
  });
}
