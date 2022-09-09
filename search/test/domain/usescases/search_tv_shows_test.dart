import 'package:core/test/helpers/test_helper.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


void main() {
  late SearchTv usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = SearchTv(mockTVShowRepository);
  });

  final testTVShows = <TvShow>[];
  const tQuery = 'Spiderman';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTVShowRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(testTVShows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testTVShows));
  });
}
