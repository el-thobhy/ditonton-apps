import 'package:core/helpers/test_helper.mocks.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvRepository();
    usecase = GetTvDetail(mockTVShowRepository);
  });

  const tId = 1;

  test('should get tv show detail from the repository', () async {
    // arrange
    when(mockTVShowRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTVShowDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVShowDetail));
  });
}
