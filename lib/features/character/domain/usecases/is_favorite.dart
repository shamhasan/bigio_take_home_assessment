import 'package:bigio_test_app/features/character/domain/repositories_interfaces/character_repository_interface.dart';

class IsFavorite {
  final CharacterRepositoryInterface repository;

  IsFavorite({required this.repository});

  Future<bool> execute(int id) {
    return repository.isFavorite(id);
  }
}
