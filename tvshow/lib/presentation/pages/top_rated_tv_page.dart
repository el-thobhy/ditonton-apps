import 'package:core/common/drawer_item_enum.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tvshow/presentation/pages/tv_detail_page.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const routeName = '/top-rated-Tv';

  const TopRatedTvsPage({Key? key}) : super(key: key);

  @override
  TopRatedTvsPageState createState() => TopRatedTvsPageState();
}

class TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedTvBloc>().add(const OnFetchTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];

                  return ContentCardList(
                    activeDrawerItem: DrawerItem.tvShow,
                    routeName: TVShowDetailPage.routeName,
                    tvShow: tv,
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedTvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
