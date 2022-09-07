import 'package:ditonton_apps/domain/repositories/tv_show_repository.dart';

class GetWatchListStatusTv {
  final TvRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
