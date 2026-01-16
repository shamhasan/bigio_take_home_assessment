import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:bigio_test_app/features/character/domain/repositories_interfaces/character_repository_interface.dart';

class SearchCharacters {
  final CharacterRepositoryInterface repository;
  SearchCharacters({required this.repository});

  Future<List<CharacterEntity>> execute(String query) {
    return repository.searchCharacters(query);
  }
}
