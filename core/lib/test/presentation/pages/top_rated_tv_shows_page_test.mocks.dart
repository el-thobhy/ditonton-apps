// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton_apps/test/presentation/pages/top_rated_tv_shows_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as i6;
import 'dart:ui' as i7;

import 'package:core/common/state_enum.dart' as i4;
import 'package:core/domain/entities/tv_show.dart' as i5;
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart'
    as i2;
import 'package:core/presentation/provider/top_rated_tv_shows_notifier.dart'
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

class _FakeGetTopRatedTVShows_0 extends i1.Fake
    implements i2.GetTopRatedTv {}

/// A class which mocks [TopRatedTVShowsNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedTVShowsNotifier extends i1.Mock
    implements i3.TopRatedTvNotifier {
  MockTopRatedTVShowsNotifier() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.GetTopRatedTv get getTopRatedTv =>
      (super.noSuchMethod(Invocation.getter(#getTopRatedTVShows),
          returnValue: _FakeGetTopRatedTVShows_0()) as i2.GetTopRatedTv);
  @override
  i4.RequestState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: i4.RequestState.empty) as i4.RequestState);
  @override
  List<i5.TvShow> get tvShows =>
      (super.noSuchMethod(Invocation.getter(#tvShows),
          returnValue: <i5.TvShow>[]) as List<i5.TvShow>);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  i6.Future<void> fetchTopRatedTv() =>
      (super.noSuchMethod(Invocation.method(#fetchTopRatedTVShows, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as i6.Future<void>);
  @override
  void addListener(i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}