import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieBloc])
void main() {
  late MockWatchlistMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockWatchlistMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>(
      create: (context) => mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display circular progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieLoading()));
    when(mockBloc.state).thenReturn(WatchlistMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    final movieList = <Movie>[];
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieLoaded(movieList)));
    when(mockBloc.state).thenReturn(WatchlistMovieLoaded(movieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text message when Error',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMovieError('Error message')));
    when(mockBloc.state).thenReturn(const WatchlistMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display empty text when data Empty',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieEmpty()));
    when(mockBloc.state).thenReturn(WatchlistMovieEmpty());

    final finder = find.byKey(const Key('empty'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(finder, findsOneWidget);
  });
}
