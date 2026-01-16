import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';

abstract class CharacterRepositoryInterface {
  Future<List<CharacterEntity>> getCharacters();
  Future<List<CharacterEntity>> searchCharacters(String query);
  Future<List<CharacterEntity>> getFavorites();
  Future<void> toggleFavorites(CharacterEntity char);
  Future<bool> isFavorite(int id);
}
