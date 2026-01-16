import 'package:bigio_test_app/core/error/exceptions.dart';
import 'package:bigio_test_app/core/error/failures.dart';
import 'package:bigio_test_app/features/character/data/datasources/character_local_datasource.dart';
import 'package:bigio_test_app/features/character/data/datasources/character_remote_datasource.dart';
import 'package:bigio_test_app/features/character/data/models/character_models.dart';
import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:bigio_test_app/features/character/domain/repositories_interfaces/character_repository_interface.dart';
// import 'package:dio/dio.dart';

class CharacterRepositoryImplementation
    implements CharacterRepositoryInterface {
  final CharacterLocalDatasource localDatasource;
  final CharacterRemoteDatasource remoteDatasource;

  CharacterRepositoryImplementation({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<List<CharacterEntity>> getCharacters() async {
    try {
      final characterModel = await remoteDatasource.getCharacters();
      return List<CharacterEntity>.from(characterModel);
    } on ServerException {
      throw ServerFailure('fail to get data from server');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<CharacterEntity>> getFavorites() async {
    try {
      final characterModel = await localDatasource.getFavorites();
      return characterModel;
    } on DatabaseException {
      throw DatabaseFailure('fail to get favorites data');
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }

  @override
  Future<bool> isFavorite(int id) async {
    try {
      return await localDatasource.isFavorite(id);
    } on DatabaseException {
      throw DatabaseFailure('fail to check status');
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<CharacterEntity>> searchCharacters(String query) async {
    try {
      final characterModel = await remoteDatasource.searchCharacters(query);
      return characterModel;
    } on ServerException {
      return [];
    }catch (e){
      throw ServerFailure("Fail to find character");
    }
  }

  @override
  Future<void> toggleFavorites(CharacterEntity char) async {
    try {
      final isFav = await localDatasource.isFavorite(char.id);

      if (isFav) {
        await localDatasource.removeFavorite(char.id);
      } else {
        final characterModel = CharacterModels(
          id: char.id,
          name: char.name,
          species: char.species,
          gender: char.gender,
          origin: char.origin,
          location: char.location,
          image: char.image,
        );
        await localDatasource.addFavorite(characterModel);
      }
    } on DatabaseException {
      throw DatabaseFailure("fail to change favorite status");
    } catch (e) {
      throw DatabaseFailure(e.toString());
    }
  }
}
