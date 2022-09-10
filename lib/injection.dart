import 'package:core/common/ssl_pinning/ssl_pinning.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_show_local_data_source.dart';
import 'package:core/data/datasources/tv_show_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_show_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_show_repository.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/domain/usecases/movie/get_movie_detail.dart';
import 'package:movie/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:movie/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:movie/domain/usecases/movie/remove_watchlist.dart' as movie_rm;
import 'package:movie/domain/usecases/movie/save_watchlist.dart' as movie_sv;
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:tvshow/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:tvshow/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:tvshow/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:tvshow/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:tvshow/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:tvshow/domain/usecases/tv_show/get_watchlist_status_tv_show.dart';
import 'package:tvshow/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:tvshow/domain/usecases/tv_show/remove_watchlist.dart'
    as tv_show_rm;
import 'package:tvshow/domain/usecases/tv_show/save_watchlist.dart'
    as tv_show_sv;
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:search/search.dart';
import 'package:tvshow/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/tv_detail_bloc.dart';
import 'package:tvshow/presentation/bloc/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingTvBloc(locator()));
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(locator()),
  );
  locator.registerFactory(
    () => PopularTvBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(locator()),
  );
  locator.registerFactory(
    () => HomeDrawerNotifier(),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => movie_sv.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => movie_rm.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //usecase Tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => tv_show_sv.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => tv_show_rm.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TVShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  //client
  locator.registerLazySingleton(() => SSLpinning.client);
}
