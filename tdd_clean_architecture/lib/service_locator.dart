import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'features/number_trivia/data/data.dart';
import 'features/number_trivia/domain/domain.dart';
import 'features/number_trivia/presentation/presentation.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  locator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: locator(),
      getRandomNumberTrivia: locator(),
      inputConverter: locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(() => GetConcreteNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  // Repository
  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: locator(),
      networkInfo: locator(),
      remoteDataSource: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(locator()),
  );

  //! Core
  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
