import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search-movie';

  const SearchPage({
    Key? key,
    required this.activeDrawerItem,
  }) : super(key: key);

  final DrawerItem activeDrawerItem;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String _title;

  @override
  Widget build(BuildContext context) {
    _title = widget.activeDrawerItem == DrawerItem.movie ? "Movie" : "TV Show";

    return Scaffold(
      appBar: AppBar(
        title: Text('Search $_title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchMovieBloc>().add(OnQueryMovieChanged(query));
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
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state) {
                if (state is SearchMovieEmpty) {
                  return _buildErrorMessage();
                } else if (state is SearchMovieError) {
                  return _buildErrorMessage();
                } else if (state is SearchMovieLoaded) {
                  final result = state.result;
                  return _buildMovieCardList(result);
                } else if (state is SearchMovieLoading) {
                  return Container(
                    margin: const EdgeInsets.only(top: 32.0),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return _buildErrorMessage();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMovieCardList(List<Movie> movies) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ContentCardList(
            movie: movie,
            activeDrawerItem: widget.activeDrawerItem,
            routeName: MovieDetailPage.routeName,
          );
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _buildErrorMessage() => Container(
        margin: const EdgeInsets.only(top: 32.0),
        child: Center(
          child: Text(
            '$_title not found!',
            style: kBodyText,
          ),
        ),
      );
}
