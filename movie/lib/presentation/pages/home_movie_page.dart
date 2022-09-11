import 'package:core/common/drawer_item_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/widgets/card_image_full.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(const OnFetchNowPlaying());
      context.read<PopularMovieBloc>().add(const OnFetchPopular());
      context.read<TopRatedMovieBloc>().add(const OnFetchTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing Movies',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
              builder: (context, state) {
                if (state is NowPlayingMovieEmpty) {
                  return Container();
                } else if (state is NowPlayingMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMovieLoaded) {
                  return MovieList(state.result);
                } else if (state is NowPlayingMovieError) {
                  return Text(state.message);
                }
                return Container();
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Popular Movies',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.routeName),
            ),
            BlocBuilder<PopularMovieBloc, PopularMovieState>(
              builder: (context, state) {
                if (state is PopularMovieEmpty) {
                  return Container();
                } else if (state is PopularMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMovieLoaded) {
                  return MovieList(state.result);
                } else if (state is PopularMovieError) {
                  return Text(state.message);
                }
                return Container();
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Top Rated Movies',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
            ),
            BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
              builder: (context, state) {
                if (state is TopRatedMovieEmpty) {
                  return Container();
                } else if (state is TopRatedMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMovieLoaded) {
                  return MovieList(state.result);
                } else if (state is TopRatedMovieError) {
                  return Text(state.message);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return CardImageFull(
            activeDrawerItem: DrawerItem.movie,
            routeNameDestination: MovieDetailPage.routeName,
            movie: movie,
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
