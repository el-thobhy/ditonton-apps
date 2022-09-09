import 'package:core/common/drawer_item_enum.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:tvshow/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/tvshow/search_tv_bloc.dart';

class SearchTvPage extends StatefulWidget {
  static const routeName = '/search-tv';

  const SearchTvPage({
    Key? key,
    required this.activeDrawerItem,
  }) : super(key: key);

  final DrawerItem activeDrawerItem;

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
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
                context.read<SearchTvBloc>().add(OnQueryTvChanged(query));
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
            BlocBuilder<SearchTvBloc, SearchTvState>(
              builder: (context, state) {
                if (state is SearchTvEmpty) {
                  return _buildErrorMessage();
                } else if (state is SearchTvError) {
                  return _buildErrorMessage();
                } else if (state is SearchTvLoaded) {
                  final result = state.result;
                  return _buildTVShowCardList(result);
                } else if (state is SearchTvLoading) {
                  return Container(
                    margin: const EdgeInsets.only(top: 32),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return _buildErrorMessage();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTVShowCardList(List<TvShow> tvShows) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return ContentCardList(
            tvShow: tvShow,
            activeDrawerItem: widget.activeDrawerItem,
            routeName: TVShowDetailPage.routeName,
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
            '$_title not found!',
            style: kBodyText,
          ),
        ),
      );
}
