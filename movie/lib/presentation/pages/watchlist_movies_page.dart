import 'package:core/common/drawer_item_enum.dart';
import 'package:core/core.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  WatchlistMoviesPageState createState() => WatchlistMoviesPageState();
}

class WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(OnFetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieEmpty) {
            return Center(
              child: Text('No watchlist movie yet!', style: kBodyText),
            );
          } else if (state is WatchlistMovieLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];

                return ContentCardList(
                  activeDrawerItem: DrawerItem.movie,
                  routeName: MovieDetailPage.routeName,
                  movie: movie,
                );
              },
              itemCount: state.result.length,
            );
          } else if (state is WatchlistMovieError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          }
          return Center(
            child: Text('No watchlist movie yet!', style: kBodyText),
          );
        },
      ),
    );
  }
}
