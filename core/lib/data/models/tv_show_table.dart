import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  factory TvTable.fromEntity(TvShowDetail tvShow) => TvTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map["id"],
        name: map["name"],
        posterPath: map["posterPath"],
        overview: map["overview"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvShow toEntity() => TvShow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
