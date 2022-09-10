import 'package:core/common/ssl_pinning/ssl_pinning.dart';
import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:ditonton_apps/presentation/pages/about_page.dart';
import 'package:ditonton_apps/injection.dart' as di;
import 'package:ditonton_apps/presentation/pages/home_drawer_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';
import 'package:search/presentation/bloc/tvshow/search_tv_bloc.dart';
import 'package:search/presentation/pages/search_movie_page.dart';
import 'package:ditonton_apps/presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/pages/search_tv_page.dart';
import 'package:tvshow/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/tv_detail_bloc.dart';
import 'package:tvshow/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tvshow/presentation/pages/popular_tv_page.dart';
import 'package:tvshow/presentation/pages/top_rated_tv_page.dart';
import 'package:tvshow/presentation/pages/tv_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SSLpinning.init();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
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
        home: const HomeDrawerPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeDrawerPage.routeName:
              return MaterialPageRoute(builder: (_) => const HomeDrawerPage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case PopularTvsPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularTvsPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case TopRatedTvsPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedTvsPage());
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
            case SearchTvPage.routeName:
              final activeDrawerItem = settings.arguments as DrawerItem;
              return CupertinoPageRoute(
                builder: (_) => SearchTvPage(
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
