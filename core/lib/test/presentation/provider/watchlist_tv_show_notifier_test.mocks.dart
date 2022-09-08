// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton_apps/test/presentation/provider/watchlist_tv_show_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as i4;

import 'package:dartz/dartz.dart' as i2;
import 'package:core/common/failure.dart' as i5;
import 'package:core/domain/entities/tv_show.dart' as i6;
import 'package:core/domain/usecases/tv_show/get_watchlist_tv_shows.dart'
    as i3;
import 'package:mockito/mockito.dart' as i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends i1.Fake implements i2.Either<L, R> {}

/// A class which mocks [GetWatchlistTVShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTVShows extends i1.Mock
    implements i3.GetWatchlistTv {
  MockGetWatchlistTVShows() {
    i1.throwOnMissingStub(this);
  }

  @override
  i4.Future<i2.Either<i5.Failure, List<i6.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<i2.Either<i5.Failure, List<i6.TvShow>>>.value(
              _FakeEither_0<i5.Failure, List<i6.TvShow>>())) as i4
          .Future<i2.Either<i5.Failure, List<i6.TvShow>>>);
}
