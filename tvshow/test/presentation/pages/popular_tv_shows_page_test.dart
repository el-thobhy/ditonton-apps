import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';
import 'package:tvshow/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/bloc_helper_mocks.dart';

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (context) => mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    // when(mockPopularTvBloc.state).thenReturn(PopularTvLoading());
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Home page should display circular progress indicator bar when loading',
      (WidgetTester tester) async {
    // when(mockPopularTvBloc.state).thenReturn(PopularTvLoading());
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Home page should display circular progress indicator bar when loading',
      (WidgetTester tester) async {
    final tvList = <TvShow>[];
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoaded(tvList)));
    when(mockPopularTvBloc.state).thenReturn(PopularTvLoaded(tvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Home page should add notification message when data Error',
      (WidgetTester tester) async {
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(const PopularTvError('Error message')));
    when(mockPopularTvBloc.state)
        .thenReturn(const PopularTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
