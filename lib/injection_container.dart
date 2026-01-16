import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:bigio_test_app/core/constant/constant.dart';
import 'package:bigio_test_app/features/character/data/datasources/character_local_datasource.dart';
import 'package:bigio_test_app/features/character/data/datasources/character_remote_datasource.dart';
import 'package:bigio_test_app/features/character/data/repositories_implementation/character_repository_implementation.dart';
import 'package:bigio_test_app/features/character/domain/repositories_interfaces/character_repository_interface.dart';
import 'package:bigio_test_app/features/character/domain/usecases/get_characters.dart';
import 'package:bigio_test_app/features/character/domain/usecases/get_favorites.dart';
import 'package:bigio_test_app/features/character/domain/usecases/is_favorite.dart';
import 'package:bigio_test_app/features/character/domain/usecases/search_characters.dart';
import 'package:bigio_test_app/features/character/domain/usecases/toggle_favorites.dart';
import 'package:bigio_test_app/features/character/presentation/provider/character_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => CharacterProvider(
      getCharactersUsecase: sl(),
      searchCharactersUsecase: sl(),
      toggleFavoritesUsecase: sl(),
      getFavoritesUsecase: sl(),
      isFavoriteUsecase: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetCharacters(repository: sl()));
  sl.registerLazySingleton(() => SearchCharacters(repository: sl()));
  sl.registerLazySingleton(() => GetFavorites(repository: sl()));
  sl.registerLazySingleton(() => ToggleFavorites(repository: sl()));
  sl.registerLazySingleton(() => IsFavorite(repository: sl()));

  sl.registerLazySingleton<CharacterRemoteDatasource>(
    () => CharacterRemoteDatasourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<CharacterLocalDatasource>(
    () => CharacterLocalDatasourceImpl(database: sl()),
  );

  sl.registerLazySingleton<CharacterRepositoryInterface>(
    () => CharacterRepositoryImplementation(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );

  sl.registerLazySingleton(() {
    final dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));
    return dio;
  });

  final dbPath = await getDatabasesPath();
  final path = join(dbPath, Constants.databaseName);

  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
       CREATE TABLE favorites (
          id INTEGER PRIMARY KEY,
          name TEXT,
          species TEXT,
          gender TEXT,
          origin TEXT,
          location TEXT,
          image TEXT
        )
    ''');
    },
  );

  sl.registerLazySingleton(() => database);
}