import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMovieBloc])
void main() {
  late MockPopularMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display circular progress indicator bar when loading',
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

  testWidgets('Page should display ListView when loaded state',
      (WidgetTester tester) async {
    final movieList = <Movie>[];
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMovieLoaded(movieList)));
    when(mockBloc.state).thenReturn(PopularMovieLoaded(movieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display notification message when data Error',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer(
        (_) => Stream.value(const PopularMovieError('Error message')));
    when(mockBloc.state).thenReturn(const PopularMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display empty Continer when data Empty',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(PopularMovieEmpty()));
    when(mockBloc.state).thenReturn(PopularMovieEmpty());

    final finder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(finder, findsOneWidget);
  });
}
