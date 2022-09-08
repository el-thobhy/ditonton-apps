import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier])
void main() {
  late MockWatchlistMovieNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistMovieNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistMovieNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('watchlist movies', () {
    testWidgets('watchlist movies should display', (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistMovies).thenReturn(testMovieList);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ContentCardList), findsWidgets);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistMovies).thenReturn(<Movie>[]);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.text('No watchlist movie yet!'), findsOneWidget);
    });

    testWidgets('loading indicator should display when getting data',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loading);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
