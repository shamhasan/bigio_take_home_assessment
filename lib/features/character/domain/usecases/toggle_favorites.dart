import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:bigio_test_app/features/character/domain/repositories_interfaces/character_repository_interface.dart';

class ToggleFavorites {
  final CharacterRepositoryInterface repository;

  ToggleFavorites({required this.repository});

  Future<void> execute(CharacterEntity char){
    return repository.toggleFavorites(char);
  }
}