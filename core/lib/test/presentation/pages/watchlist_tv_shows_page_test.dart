import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/presentation/pages/watchlist_tv_shows_page.dart';
import 'package:core/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_shows_page_test.mocks.dart';

@GenerateMocks([WatchlistTvNotifier])
void main() {
  late MockWatchlistTVShowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistTVShowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('watchlist tv shows', () {
    testWidgets('watchlist tv shows should display',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistTv).thenReturn(testTVShowList);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      expect(find.byType(ContentCardList), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistTv).thenReturn(<TvShow>[]);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      expect(find.text('No watchlist tv show yet!'), findsOneWidget);
    });

    testWidgets('loading indicator should display when getting data',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loading);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
