import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tvshow/presentation/pages/watchlist_tv_page.dart';

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Watchlist'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorColor: kMikadoYellow,
                tabs: [
                  _buildTabBarItem('Movies', Icons.movie_creation_outlined),
                  _buildTabBarItem('TV Show', Icons.live_tv_rounded),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            WatchlistMoviesPage(),
            WatchlistTvPage(),
          ],
        ),
      )),
    );
  }

  Widget _buildTabBarItem(String title, IconData iconData) => Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            const SizedBox(
              width: 12.0,
            ),
            Text(title),
          ],
        ),
      );
}
