import 'package:core/helpers/test_helper.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:tvshow/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTVShowRepository);
  });

  const tId = 1;
  final testTVShows = <TvShow>[];

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockTVShowRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(testTVShows));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVShows));
  });
}
