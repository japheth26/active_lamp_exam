import 'package:active_lamp_exam/core/network/network_info.dart';
import 'package:active_lamp_exam/features/data/datasource/url_converter_remote_data_source.dart';
import 'package:active_lamp_exam/features/data/repository/url_converter_repository_impl.dart';
import 'package:active_lamp_exam/features/domain/repository/url_converter_repository.dart';
import 'package:active_lamp_exam/features/domain/usecases/get_original_url.dart';
import 'package:active_lamp_exam/features/domain/usecases/get_short_url.dart';
import 'package:active_lamp_exam/features/presentation/bloc/convert_url_bloc/convert_url_bloc.dart';
import 'package:active_lamp_exam/features/presentation/bloc/inflate_url_bloc/inflate_url_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  //
  //
  //
  sl.registerFactory(() => ConvertUrlBloc(shortUrl: sl()));
  sl.registerFactory(() => InflateUrlBloc(inflateUrl: sl()));

  // Usecases
  //
  //
  //
  sl.registerLazySingleton(() => GetShortUrl(sl()));
  sl.registerLazySingleton(() => GetOriginalUrl(sl()));

  // Repository
  //
  //
  //
  sl.registerLazySingleton<UrlConverterRepository>(() =>
      UrlConverterRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  //! Datasources
  // Remote data sources
  //
  //
  //
  sl.registerLazySingleton<UrlConvertRemoteDataSource>(
      () => UrlConvertRemoteDataSourceImpl(client: sl()));

  //! Core
  //
  //
  //
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  //
  //
  //
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client);
}
