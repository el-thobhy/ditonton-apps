import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tvshow/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_shows_page_test.mocks.dart';

@GenerateMocks([TopRatedTvBloc])
void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>(
      create: (context) => mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display circular progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoading()));
    when(mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display data when data is loaded',
      (WidgetTester tester) async {
    final tvList = <TvShow>[];
    when(mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvLoaded(tvList)));
    when(mockTopRatedTvBloc.state).thenReturn(TopRatedTvLoaded(tvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedTvBloc.stream).thenAnswer(
        (_) => Stream.value(const TopRatedTvError('Error message')));
    when(mockTopRatedTvBloc.state)
        .thenReturn(const TopRatedTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });

  
   testWidgets('Home page should display empty container when data Empty',
      (WidgetTester tester) async {
    when(mockTopRatedTvBloc.stream)
        .thenAnswer((_) => Stream.value( TopRatedTvEmpty()));
    when(mockTopRatedTvBloc.state)
        .thenReturn(TopRatedTvEmpty());

    final finder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvsPage()));

    expect(finder, findsOneWidget);
  });
}
