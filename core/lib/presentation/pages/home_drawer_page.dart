import 'package:about/about.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_show_page.dart';
import 'package:search/presentation/pages/search_movie_page.dart';
import 'package:search/presentation/pages/search_tv_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeDrawerPage extends StatelessWidget {
  static const routeName = '/home';

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  HomeDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeDrawerNotifier>(builder: (ctx, data, child) {
      final activeDrawerItem = data.selectedDrawerItem;

      return Scaffold(
        key: _drawerKey,
        drawer: _buildDrawer(ctx, (DrawerItem newSelectedItem) {
          data.setSelectedDrawerItem(newSelectedItem);
        }, activeDrawerItem),
        appBar: _buildAppBar(ctx, activeDrawerItem),
        body: _buildBody(ctx, activeDrawerItem),
      );
    });
  }

  Widget _buildBody(BuildContext context, DrawerItem seletedDrawerItem) {
    if (seletedDrawerItem == DrawerItem.movie) {
      return const HomeMoviePage();
    } else if (seletedDrawerItem == DrawerItem.tvShow) {
      return const HomeTvPage();
    }
    return Container();
  }

  AppBar _buildAppBar(
    BuildContext context,
    DrawerItem activeDrawerItem,
  ) {
    return AppBar(
      title: const Text('Ditonton'),
      actions: [
        IconButton(
          onPressed: () {
            if (activeDrawerItem == DrawerItem.movie) {
              Navigator.pushNamed(
                context,
                SearchPage.routeName,
                arguments: activeDrawerItem,
              );
            }
            if (activeDrawerItem == DrawerItem.tvShow) {
              Navigator.pushNamed(
                context,
                SearchTvPage.routeName,
                arguments: activeDrawerItem,
              );
            }
          },
          icon: const Icon(Icons.search),
        )
      ],
    );
  }

  Drawer _buildDrawer(
    BuildContext context,
    Function(DrawerItem) itemCallback,
    DrawerItem activeDrawerItem,
  ) =>
      Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              tileColor:
                  activeDrawerItem == DrawerItem.movie ? kDavysGrey : kGrey,
              leading: const Icon(Icons.movie_creation_outlined),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(DrawerItem.movie);
              },
            ),
            ListTile(
              tileColor:
                  activeDrawerItem == DrawerItem.tvShow ? kDavysGrey : kGrey,
              leading: const Icon(Icons.live_tv_rounded),
              title: const Text('TV Shows'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(DrawerItem.tvShow);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, WatchlistPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      );
}
