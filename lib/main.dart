import 'package:about/about.dart';
import 'package:ditonton_apps/common/constants.dart';
import 'package:ditonton_apps/common/drawer_item_enum.dart';
import 'package:ditonton_apps/injection.dart' as di;
import 'package:ditonton_apps/presentation/pages/home_drawer_page.dart';
import 'package:ditonton_apps/presentation/pages/movie_detail_page.dart';
import 'package:ditonton_apps/presentation/pages/popular_movies_page.dart';
import 'package:ditonton_apps/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton_apps/presentation/pages/search_page.dart';
import 'package:ditonton_apps/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton_apps/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton_apps/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton_apps/presentation/pages/watchlist_page.dart';
import 'package:ditonton_apps/presentation/provider/home_notifier.dart';
import 'package:ditonton_apps/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton_apps/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton_apps/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton_apps/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:ditonton_apps/presentation/provider/search_notifier.dart';
import 'package:ditonton_apps/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton_apps/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:ditonton_apps/presentation/provider/tv_show_detail_notifier.dart';
import 'package:ditonton_apps/presentation/provider/tv_show_list_notifier.dart';
import 'package:ditonton_apps/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton_apps/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
            case HomeDrawerPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeDrawerPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
            case PopularTVShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularTVShowsPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
            case TopRatedTVShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const TopRatedTVShowsPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TVShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final activeDrawerItem = settings.arguments as DrawerItem;
              return CupertinoPageRoute(
                builder: (_) => SearchPage(
                  activeDrawerItem: activeDrawerItem,
                ),
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.ROUTE_NAME:
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
