import 'package:core/common/drawer_item_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_page_test.mocks.dart';

@GenerateMocks([SearchTvBloc])
void main() {
  late MockSearchTvBloc mockBloc;

  setUp(() {
    mockBloc = MockSearchTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Page should display circular progress indicator bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(SearchTvLoading()));
    when(mockBloc.state).thenReturn(SearchTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(
      const SearchTvPage(
        activeDrawerItem: DrawerItem.tvShow,
      ),
    ));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when loaded state',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(SearchTvLoaded(testTVShowList)));
    when(mockBloc.state).thenReturn(SearchTvLoaded(testTVShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(
      const SearchTvPage(
        activeDrawerItem: DrawerItem.tvShow,
      ),
    ));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display notification message when data Error',
      (WidgetTester tester) async {
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(const SearchTvError('Error message')));
    when(mockBloc.state).thenReturn(const SearchTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(
      const SearchTvPage(
        activeDrawerItem: DrawerItem.tvShow,
      ),
    ));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display empty Continer when data Empty',
      (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer((_) => Stream.value(SearchTvEmpty()));
    when(mockBloc.state).thenReturn(SearchTvEmpty());

    final finder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(
      const SearchTvPage(
        activeDrawerItem: DrawerItem.tvShow,
      ),
    ));

    expect(finder, findsOneWidget);
  });
}
