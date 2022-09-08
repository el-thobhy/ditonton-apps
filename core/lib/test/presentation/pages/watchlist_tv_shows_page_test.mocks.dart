// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton_apps/test/presentation/pages/watchlist_tv_shows_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:core/common/state_enum.dart' as _i5;
import 'package:core/domain/entities/tv_show.dart' as _i4;
import 'package:core/domain/usecases/tv_show/get_watchlist_tv_shows.dart'
    as _i2;
import 'package:core/presentation/provider/watchlist_tv_show_notifier.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetWatchlistTVShows_0 extends _i1.Fake
    implements _i2.GetWatchlistTv {}

/// A class which mocks [WatchlistTVShowNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistTVShowNotifier extends _i1.Mock
    implements _i3.WatchlistTvNotifier {
  MockWatchlistTVShowNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistTv get getWatchlistTv => (super.noSuchMethod(
      Invocation.getter(#getWatchlistTVShows),
      returnValue: _FakeGetWatchlistTVShows_0()) as _i2.GetWatchlistTv);
  @override
  List<_i4.TvShow> get watchlistTv =>
      (super.noSuchMethod(Invocation.getter(#watchlistTVShows),
          returnValue: <_i4.TvShow>[]) as List<_i4.TvShow>);
  @override
  _i5.RequestState get watchlistState =>
      (super.noSuchMethod(Invocation.getter(#watchlistState),
          returnValue: _i5.RequestState.empty) as _i5.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchWatchlistTv() =>
      (super.noSuchMethod(Invocation.method(#fetchWatchlistTVShows, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
