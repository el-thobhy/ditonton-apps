import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:ditonton_apps/injection.dart' as di;
import 'package:core/presentation/pages/home_drawer_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_tv_shows_page.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:core/presentation/pages/tv_show_detail_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/provider/home_notifier.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/popular_movies_notifier.dart';
import 'package:core/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:core/presentation/provider/search_notifier.dart';
import 'package:core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:core/presentation/provider/tv_show_detail_notifier.dart';
import 'package:core/presentation/provider/tv_show_list_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<HomeDrawerNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomeDrawerPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeDrawerPage.routeName:
              return MaterialPageRoute(builder: (_) => HomeDrawerPage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
            case PopularTVShowsPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularTVShowsPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
            case TopRatedTVShowsPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TopRatedTVShowsPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TVShowDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              final activeDrawerItem = settings.arguments as DrawerItem;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  activeDrawerItem: activeDrawerItem,
                ),
              );
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
