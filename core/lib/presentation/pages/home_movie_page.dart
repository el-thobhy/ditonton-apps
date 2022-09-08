import 'package:core/common/drawer_item_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/widgets/card_image_full.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
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
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return MovieList(data.nowPlayingMovies);
              } else {
                return const Text('Failed to fetch data');
              }
            }),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Popular Movies',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.routeName),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.popularMoviesState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return MovieList(data.popularMovies);
              } else {
                return const Text('Failed to fetch data');
              }
            }),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Top Rated Movies',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
            ),
            Consumer<MovieListNotifier>(builder: (context, data, child) {
              final state = data.topRatedMoviesState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return MovieList(data.topRatedMovies);
              } else {
                return const Text('Failed to fetch data');
              }
            }),
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
