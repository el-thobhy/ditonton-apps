import 'package:ditonton_apps/data/datasources/db/database_helper.dart';
import 'package:ditonton_apps/data/datasources/movie_local_data_source.dart';
import 'package:ditonton_apps/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton_apps/data/datasources/tv_show_local_data_source.dart';
import 'package:ditonton_apps/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton_apps/domain/repositories/movie_repository.dart';
import 'package:ditonton_apps/domain/repositories/tv_show_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  MovieLocalDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
