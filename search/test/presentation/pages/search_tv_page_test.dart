import 'package:core/common/drawer_item_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/search_page_test_mock.dart';

void main() {
  late FakeSearchTVShowsBloc fakeSearchTVShowsBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchMoviesEvent());
    registerFallbackValue(FakeSearchMoviesState());
    registerFallbackValue(FakeSearchTVShowsEvent());
    registerFallbackValue(FakeSearchTVShowsState());
    fakeSearchTVShowsBloc = FakeSearchTVShowsBloc();
  });

  tearDown(() {
    fakeSearchTVShowsBloc.close();
  });

  Widget createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchTvBloc>(
          create: (context) => fakeSearchTVShowsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('search tv shows test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state).thenReturn(SearchTvLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(createTestableWidget(
          const SearchTvPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when data is gotten successful",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state)
            .thenReturn(SearchTvLoaded(testTVShowList));

        final listViewFinder = find.byType(Expanded);

        await tester.pumpWidget(createTestableWidget(
          const SearchTvPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state)
            .thenReturn(const SearchTvError('error'));

        final errorTypeFinder = find.byType(Container);

        await tester.pumpWidget(createTestableWidget(
          const SearchTvPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));
        await tester.pump(const Duration(seconds: 1));

        expect(errorTypeFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display empty message when the searched data is empty",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state).thenReturn(SearchTvEmpty());

        final emptyTypeFinder = find.byType(Container);

        await tester.pumpWidget(createTestableWidget(
          const SearchTvPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));
        await tester.pump(const Duration(seconds: 1));
        expect(emptyTypeFinder, findsOneWidget);
      },
    );
  });
}
