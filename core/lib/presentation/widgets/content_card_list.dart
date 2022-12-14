import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/common/drawer_item_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter/material.dart';

class ContentCardList extends StatelessWidget {
  final Movie? movie;
  final TvShow? tvShow;
  final DrawerItem activeDrawerItem;
  final String routeName;

  const ContentCardList({
    Key? key,
    required this.activeDrawerItem,
    this.movie,
    this.tvShow,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: kRichBlack,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeName,
              arguments: _getId(),
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Card(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16 + 80 + 16,
                    bottom: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getTitle() ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading6,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getOverview() ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: "$baseImageUrl${_getPosterPath()}",
                    width: 80,
                    placeholder: (context, url) => const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getId() => activeDrawerItem == DrawerItem.movie
      ? movie?.id as int
      : tvShow?.id as int;

  String? _getTitle() =>
      activeDrawerItem == DrawerItem.movie ? movie?.title : tvShow?.name;

  String _getPosterPath() => activeDrawerItem == DrawerItem.movie
      ? movie?.posterPath as String
      : tvShow?.posterPath as String;

  String? _getOverview() =>
      activeDrawerItem == DrawerItem.movie ? movie?.overview : tvShow?.overview;
}
