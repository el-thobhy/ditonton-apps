import 'package:core/helpers/test_helper.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:tvshow/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTVShowRepository);
  });

  final testTVShow = <TvShow>[];

  test('should get list of tv shows from repository', () async {
    // arrange
    when(mockTVShowRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(testTVShow));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVShow));
  });
}
