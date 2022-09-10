import 'package:core/common/drawer_item_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_page_test.mocks.dart';

@GenerateMocks([SearchMovieBloc])
void main() {
  late MockSearchMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockSearchMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display circular progress indicator bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(SearchMovieLoading()));
    when(mockBloc.state).thenReturn(SearchMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(
      const SearchPage(
        activeDrawerItem: DrawerItem.movie,
      ),
    ));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when loaded state',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(SearchMovieLoaded(testMovieList)));
    when(mockBloc.state).thenReturn(SearchMovieLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(
      const SearchPage(
        activeDrawerItem: DrawerItem.movie,
      ),
    ));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display notification message when data Error',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer(
        (_) => Stream.value(const SearchMovieError('Error message')));
    when(mockBloc.state).thenReturn(const SearchMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(
      const SearchPage(
        activeDrawerItem: DrawerItem.movie,
      ),
    ));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display empty Continer when data Empty',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(SearchMovieEmpty()));
    when(mockBloc.state).thenReturn(SearchMovieEmpty());

    final finder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(
      const SearchPage(
        activeDrawerItem: DrawerItem.movie,
      ),
    ));

    expect(finder, findsOneWidget);
  });
}
