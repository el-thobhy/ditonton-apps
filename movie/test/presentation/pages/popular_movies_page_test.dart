import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock/popular_movies_page_test_mock.dart';

@GenerateMocks([PopularMovieBloc])
void main() {
  late MockPopularMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    // when(mockPopularMoviesBloc.state).thenReturn(PopularMoviesLoading());
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoading()));
    when(mockBloc.state).thenReturn(PopularMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Home page should display circular progress indicator bar when loading',
      (WidgetTester tester) async {
    // when(mockPopularMoviesBloc.state).thenReturn(PopularMoviesLoading());
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoading()));
    when(mockBloc.state).thenReturn(PopularMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Home page should display circular progress indicator bar when loading',
      (WidgetTester tester) async {
    final movieList = <Movie>[];
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoaded(movieList)));
    when(mockBloc.state).thenReturn(PopularMovieLoaded(movieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Home page should add notification message when data Error',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer(
        (_) => Stream.value(const PopularMovieError('Error message')));
    when(mockBloc.state).thenReturn(const PopularMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
