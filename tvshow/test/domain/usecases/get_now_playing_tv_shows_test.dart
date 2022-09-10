import 'package:core/helpers/test_helper.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:tvshow/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late GetNowPlayingTv usecase;
  late MockTvRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvRepository();
    usecase = GetNowPlayingTv(mockTVShowRepository);
  });

  final testTVShow = <TvShow>[];

  group("GetNowPlayingTVShows Tests", () {
    test('should get list of tv shows from the repository', () async {
      // arrange
      when(mockTVShowRepository.getNowPlayingTv())
          .thenAnswer((_) async => Right(testTVShow));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTVShow));
    });
  });
}
