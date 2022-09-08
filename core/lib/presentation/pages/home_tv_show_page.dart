import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/presentation/pages/popular_tv_shows_page.dart';
import 'package:core/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:core/presentation/pages/tv_show_detail_page.dart';
import 'package:core/presentation/provider/tv_show_list_notifier.dart';
import 'package:core/presentation/widgets/card_image_full.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvListNotifier>(context, listen: false)
          ..fetchNowPlayingTv()
          ..fetchPopularTv()
          ..fetchTopRatedTv());
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
              'Now Playing Tv Show',
              style: kHeading6,
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvList(data.nowPlayingTVShows);
              } else {
                return const Text('Failed to fetch data');
              }
            }),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Popular Tv Show',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTVShowsPage.routeName),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.popularTVShowsState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvList(data.popularTVShows);
              } else {
                return const Text('Failed to fetch data');
              }
            }),
            SubHeading(
              title: 'Top Rated Tv Show',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTVShowsPage.ROUTE_NAME),
            ),
            const SizedBox(height: 8.0),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.topRatedTVShowsState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvList(data.topRatedTVShows);
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

class TvList extends StatelessWidget {
  final List<TvShow> tvShows;

  const TvList(this.tvShows, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final _tvShow = tvShows[index];
          return CardImageFull(
            activeDrawerItem: DrawerItem.tvShow,
            routeNameDestination: TVShowDetailPage.ROUTE_NAME,
            tvShow: _tvShow,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
