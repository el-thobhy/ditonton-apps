import 'package:core/common/drawer_item_enum.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tvshow/presentation/pages/popular_tv_page.dart';
import 'package:core/presentation/widgets/card_image_full.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:tvshow/presentation/pages/top_rated_tv_page.dart';
import 'package:tvshow/presentation/pages/tv_detail_page.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  HomeTvPageState createState() => HomeTvPageState();
}

class HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(const OnFetchNowPlaying());
      context.read<PopularTvBloc>().add(const OnFetchPopular());
      context.read<TopRatedTvBloc>().add(const OnFetchTopRated());
    });
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
              'Now Playing Tvs',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
              builder: (context, state) {
                if (state is NowPlayingTvEmpty) {
                  return Container();
                } else if (state is NowPlayingTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvLoaded){
                  return TvList(state.result);
                } else if(state is NowPlayingTvError){
                  return const Text('Failed to fetch data');
                }
                return Container();
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Popular Tvs',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvsPage.routeName),
            ),
            BlocBuilder<PopularTvBloc, PopularTvState>(
              builder: (context, state) {
                if (state is PopularTvEmpty) {
                  return Container();
                } else if (state is PopularTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvLoaded){
                  return TvList(state.result);
                } else if(state is PopularTvError){
                  return const Text('Failed to fetch data');
                }
                return Container();
              },
            ),
            const SizedBox(height: 8.0),
            SubHeading(
              title: 'Top Rated Tvs',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvsPage.routeName),
            ),
            BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
              builder: (context, state) {
                if (state is TopRatedTvEmpty) {
                  return Container();
                } else if (state is TopRatedTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvLoaded){
                  return TvList(state.result);
                } else if(state is TopRatedTvError){
                  return const Text('Failed to fetch data');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvShow> tvShow;

  const TvList(this.tvShow, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvShow[index];
          return CardImageFull(
            activeDrawerItem: DrawerItem.tvShow,
            routeNameDestination: TVShowDetailPage.routeName,
            tvShow: tv,
          );
        },
        itemCount: tvShow.length,
      ),
    );
  }
}
