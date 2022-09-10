import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMovieBloc])
void main() {
  late MockTopRatedMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (context) => mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display circular progress bar when loading state',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoading()));
    when(mockBloc.state).thenReturn(TopRatedMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display data when data is loaded ',
      (WidgetTester tester) async {
    final movieList = <Movie>[];
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMovieLoaded(movieList)));
    when(mockBloc.state).thenReturn(TopRatedMovieLoaded(movieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text message when Error',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer(
        (_) => Stream.value(const TopRatedMovieError('Error message')));
    when(mockBloc.state).thenReturn(const TopRatedMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display empty Continer when data Empty',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TopRatedMovieEmpty()));
    when(mockBloc.state).thenReturn(TopRatedMovieEmpty());

    final finder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(finder, findsOneWidget);
  });
}
