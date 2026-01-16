import 'dart:developer';

import 'package:bigio_test_app/core/constant/constant.dart';
import 'package:bigio_test_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';

import 'package:bigio_test_app/features/character/data/models/character_models.dart';
import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';

abstract class CharacterRemoteDatasource {
  Future<List<CharacterEntity>> getCharacters();
  Future<List<CharacterEntity>> searchCharacters(String query);
}

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final Dio dio;

  CharacterRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<CharacterEntity>> getCharacters() async {
    try {
      final response = await dio.get(Constants.characterEndpoint);
      final List data = response.data['results'];
      return data.map((json) => CharacterModels.fromJson(json)).toList();
    } on DioException catch (e) {
      log("Dio Error Get: ${e.message}", name: 'RemoteDataSource');
      throw ServerException();
    } catch (e) {
      log("Unknown error: $e", name: 'RemoteDataSource');
      throw ServerException();
    }
  }

  @override
  Future<List<CharacterEntity>> searchCharacters(String query) async {
    try {
      final response = await dio.get(
        Constants.characterEndpoint,
        queryParameters: {"name": query},
      );
      final List data = response.data['results'];
      return data.map((json) => CharacterModels.fromJson(json)).toList();
    } on DioException catch (e) {
      log("Dio Error search: ${e.message}", name: 'RemoteDataSource');
      throw ServerException();
    } catch (e) {
      log("Unknown Error: $e", name: "RemoteDatasource");
      throw ServerException();
    }
  }
}
