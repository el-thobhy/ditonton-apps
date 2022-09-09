import 'package:core/common/drawer_item_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshow/presentation/bloc/popular_tv_bloc.dart';
import 'package:tvshow/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';

class PopularTvsPage extends StatefulWidget {
  static const routeName = '/popular-tvshow';

  const PopularTvsPage({Key? key}) : super(key: key);

  @override
  PopularTvsPageState createState() => PopularTvsPageState();
}

class PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvBloc>().add(const OnFetchPopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvLoaded) {
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
            } else if(state is PopularTvError) {
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
