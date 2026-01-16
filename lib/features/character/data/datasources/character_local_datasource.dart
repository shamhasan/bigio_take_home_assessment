import 'dart:developer';

import 'package:bigio_test_app/core/constant/constant.dart';
import 'package:bigio_test_app/core/error/exceptions.dart';
import 'package:bigio_test_app/features/character/data/models/character_models.dart';
import 'package:sqflite/sqflite.dart' hide DatabaseException;
import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';

abstract class CharacterLocalDatasource {
  Future<List<CharacterEntity>> getFavorites();
  Future<void> addFavorite(CharacterModels char);
  Future<void> removeFavorite(int id);
  Future<bool> isFavorite(int id);
}

class CharacterLocalDatasourceImpl extends CharacterLocalDatasource {
  final Database database;

  CharacterLocalDatasourceImpl({required this.database});

  @override
  Future<void> addFavorite(CharacterModels char) async {
    try {
      await database.insert(
        Constants.tableName,
        char.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log("error insert: $e", name: 'CharacterLocalDatasource', error: e);
      throw DatabaseException();
    }
  }

  @override
  Future<List<CharacterEntity>> getFavorites() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        Constants.tableName,
      );
      return maps.map((e) => CharacterModels.fromMap(e)).toList();
    } on Exception catch (e) {
      log("error read: $e", name: 'CharacterLocalDatasource', error: e);
      throw DatabaseException();
    }
  }

  @override
  Future<bool> isFavorite(int id) async {
    try {
      final result = await database.query(
        Constants.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      return result.isNotEmpty;
    } on Exception catch (e) {
      log("error check status: $e", name: 'CharacterLocalDatasource', error: e);
      throw DatabaseException();
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    try {
      await database.delete(
        Constants.tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log("error delete: $e", name: 'CharacterLocalDatasource', error: e);
      throw DatabaseException();
    }
  }
}
