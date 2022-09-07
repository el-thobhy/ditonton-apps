import 'package:dartz/dartz.dart';
import 'package:ditonton_apps/common/failure.dart';
import 'package:ditonton_apps/common/state_enum.dart';
import 'package:ditonton_apps/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:ditonton_apps/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTVShows mockGetTopRatedTVShows;
  late TopRatedTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTVShows = MockGetTopRatedTVShows();
    notifier =
        TopRatedTvNotifier(getTopRatedTv: mockGetTopRatedTVShows)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Right(testTVShowList));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvShows, testTVShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTVShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
