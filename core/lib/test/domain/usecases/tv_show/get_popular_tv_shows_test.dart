import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTVShowRepository mockTVShowRpository;

  setUp(() {
    mockTVShowRpository = MockTVShowRepository();
    usecase = GetPopularTv(mockTVShowRpository);
  });

  final testTVShow = <TvShow>[];

  test(
      'should get list of tv shows from the repository when execute function is called',
      () async {
    // arrange
    when(mockTVShowRpository.getPopularTv())
        .thenAnswer((_) async => Right(testTVShow));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVShow));
  });
}
