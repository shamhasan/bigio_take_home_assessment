import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:bigio_test_app/features/character/domain/repositories_interfaces/character_repository_interface.dart';

class GetCharacters {
  final CharacterRepositoryInterface repository;
  GetCharacters({required this.repository});

  Future<List<CharacterEntity>> execute() {
    return repository.getCharacters();
  }
}
