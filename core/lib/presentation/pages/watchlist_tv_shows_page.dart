import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:core/presentation/pages/tv_show_detail_page.dart';
import 'package:core/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: Consumer<WatchlistTvNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.loaded) {
            if (data.watchlistTv.isEmpty) {
              return Center(
                child: Text('No watchlist tv show yet!', style: kBodyText),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = data.watchlistTv[index];

                return ContentCardList(
                  activeDrawerItem: DrawerItem.tvShow,
                  routeName: TVShowDetailPage.ROUTE_NAME,
                  tvShow: tvShow,
                );
              },
              itemCount: data.watchlistTv.length,
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
