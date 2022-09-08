import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/tv_show_detail_page.dart';
import 'package:core/presentation/provider/search_notifier.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  SearchPage({
    Key? key,
    required this.activeDrawerItem,
  }) : super(key: key);

  final DrawerItem activeDrawerItem;
  late bool _isAlreadySearched = false;
  late String _title;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchNotifier>(context);
    _title = activeDrawerItem == DrawerItem.movie ? "Movie" : "TV Show";

    return Scaffold(
      appBar: AppBar(
        title: Text('Search $_title\s'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                _isAlreadySearched = true;

                if (activeDrawerItem == DrawerItem.movie) {
                  provider.fetchMovieSearch(query);
                } else {
                  provider.fetchTVShowSearch(query);
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Consumer<SearchNotifier>(
      builder: (ctx, data, child) {
        if (data.state == RequestState.loading) {
          return Container(
            margin: const EdgeInsets.only(top: 32.0),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (data.state == RequestState.loaded && _isAlreadySearched) {
          if (activeDrawerItem == DrawerItem.movie) {
            return _buildMovieCardList(data.moviesSearchResult);
          } else {
            return _buildTVShowCardList(data.tvShowsSearchResult);
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildMovieCardList(List<Movie> movies) {
    if (movies.isEmpty) return _buildErrorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ContentCardList(
            movie: movie,
            activeDrawerItem: activeDrawerItem,
            routeName: MovieDetailPage.ROUTE_NAME,
          );
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _buildTVShowCardList(List<TvShow> tvShows) {
    if (tvShows.isEmpty) return _buildErrorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return ContentCardList(
            tvShow: tvShow,
            activeDrawerItem: activeDrawerItem,
            routeName: TVShowDetailPage.ROUTE_NAME,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }

  Widget _buildErrorMessage() => Container(
        margin: const EdgeInsets.only(top: 32.0),
        child: Center(
          child: Text(
            '$_title\s not found!',
            style: kBodyText,
          ),
        ),
      );
}
