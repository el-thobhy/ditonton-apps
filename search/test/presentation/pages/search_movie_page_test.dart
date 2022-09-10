import 'package:core/common/drawer_item_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/search_page_test_mock.dart';

void main() {
  late FakeSearchMoviesBloc fakeSearchMoviesBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchMoviesEvent());
    registerFallbackValue(FakeSearchMoviesState());
    fakeSearchMoviesBloc = FakeSearchMoviesBloc();
  });

  tearDown(() {
    fakeSearchMoviesBloc.close();
  });

  Widget createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMovieBloc>(
          create: (context) => fakeSearchMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('search movies test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchMovieLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(createTestableWidget(
          const SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when data is gotten successful",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state)
            .thenReturn(SearchMovieLoaded(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(createTestableWidget(
          const SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state)
            .thenReturn(const SearchMovieError('error'));

        final errorTypeFinder = find.byType(Container);

        await tester.pumpWidget(createTestableWidget(
          const SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));
        await tester.pump(const Duration(seconds: 1));
        expect(errorTypeFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display empty message when the searched data is empty",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchMovieEmpty());

        final emptyTypeFinder = find.byType(Container);

        await tester.pumpWidget(createTestableWidget(
          const SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));
        await tester.pump(const Duration(seconds: 1));
        expect(emptyTypeFinder, findsOneWidget);
      },
    );
  });
}
