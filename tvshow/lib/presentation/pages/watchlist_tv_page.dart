import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tvshow/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  WatchlistTvPageState createState() => WatchlistTvPageState();
}

class WatchlistTvPageState extends State<WatchlistTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvBloc>().add(OnFetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = state.result[index];

                return ContentCardList(
                  activeDrawerItem: DrawerItem.tvShow,
                  routeName: TVShowDetailPage.routeName,
                  tvShow: tvShow,
                );
              },
              itemCount: state.result.length,
            );
          } else if (state is WatchlistTvError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else if(state is WatchlistTvEmpty){
            return Container();
          }
          return Center(
            child: Text('No watchlist tv show yet!', style: kBodyText),
          );
        },
      ),
    );
  }
}
