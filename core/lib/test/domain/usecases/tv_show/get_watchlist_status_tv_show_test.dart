import 'package:core/domain/usecases/tv_show/get_watchlist_status_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = GetWatchListStatusTv(mockTVShowRepository);
  });

  test('should get watchlist status of tv show from repository', () async {
    // arrange
    when(mockTVShowRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
