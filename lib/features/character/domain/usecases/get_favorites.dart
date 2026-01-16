import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:bigio_test_app/features/character/domain/repositories_interfaces/character_repository_interface.dart';

class GetFavorites {
  final CharacterRepositoryInterface repository;
  GetFavorites({required this.repository});

  Future<List<CharacterEntity>> execute() {
    return repository.getFavorites();
  }
}
