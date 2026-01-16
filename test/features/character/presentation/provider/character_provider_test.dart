import 'package:bigio_test_app/core/error/failures.dart';
import 'package:bigio_test_app/core/utils/request_state.dart';
import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:bigio_test_app/features/character/domain/usecases/get_characters.dart';
import 'package:bigio_test_app/features/character/domain/usecases/get_favorites.dart';
import 'package:bigio_test_app/features/character/domain/usecases/is_favorite.dart';
import 'package:bigio_test_app/features/character/domain/usecases/search_characters.dart';
import 'package:bigio_test_app/features/character/domain/usecases/toggle_favorites.dart';
import 'package:bigio_test_app/features/character/presentation/provider/character_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetCharacters extends Mock implements GetCharacters {
  @override
  Future<List<CharacterEntity>> execute() {
    return super.noSuchMethod(
      Invocation.method(#execute, []),
      returnValue: Future.value(<CharacterEntity>[]),
      returnValueForMissingStub: Future.value(<CharacterEntity>[]),
    );
  }
}

class MockSearchCharacters extends Mock implements SearchCharacters {
  @override
  Future<List<CharacterEntity>> execute(String? query) {
    return super.noSuchMethod(
      Invocation.method(#execute, [query]),
      returnValue: Future.value(<CharacterEntity>[]),
      returnValueForMissingStub: Future.value(<CharacterEntity>[]),
    );
  }
}

class MockToggleFavorites extends Mock implements ToggleFavorites {
  @override
  Future<void> execute(CharacterEntity? char) {
    return super.noSuchMethod(
      Invocation.method(#execute, [char]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value(),
    );
  }
}

class MockGetFavorites extends Mock implements GetFavorites {
  @override
  Future<List<CharacterEntity>> execute() {
    return super.noSuchMethod(
      Invocation.method(#execute, []),
      returnValue: Future.value(<CharacterEntity>[]),
      returnValueForMissingStub: Future.value(<CharacterEntity>[]),
    );
  }
}

class MockIsFavorite extends Mock implements IsFavorite {
  @override
  Future<bool> execute(int? id) {
    return super.noSuchMethod(
      Invocation.method(#execute, [id]),
      returnValue: Future.value(false),
      returnValueForMissingStub: Future.value(false),
    );
  }
}

void main() {
  late CharacterProvider provider;
  late MockGetCharacters mockGetCharacters;
  late MockSearchCharacters mockSearchCharacters;
  late MockToggleFavorites mockToggleFavorites;
  late MockGetFavorites mockGetFavorites;
  late MockIsFavorite mockIsFavorite;

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    mockSearchCharacters = MockSearchCharacters();
    mockToggleFavorites = MockToggleFavorites();
    mockGetFavorites = MockGetFavorites();
    mockIsFavorite = MockIsFavorite();

    provider = CharacterProvider(
      getCharactersUsecase: mockGetCharacters,
      searchCharactersUsecase: mockSearchCharacters,
      toggleFavoritesUsecase: mockToggleFavorites,
      getFavoritesUsecase: mockGetFavorites,
      isFavoriteUsecase: mockIsFavorite,
    );
  });

  final tCharacter = CharacterEntity(
    id: 1,
    name: 'Rick Sanchez',
    species: 'Human',
    gender: 'Male',
    origin: 'Earth',
    location: 'Earth',
    image: 'rick.jpg',
  );
  final tCharacterList = [tCharacter];

  group('CharacterProvider Test', () {
    test(
      'harus mengubah state menjadi Loading lalu Loaded saat data berhasil diambil',
      () async {
        when(
          mockGetCharacters.execute(),
        ).thenAnswer((_) async => tCharacterList);

        final future = provider.fetchCharacters();
        expect(provider.homeState, RequestState.loading);
        await future;

        expect(provider.homeState, RequestState.loaded);
        expect(provider.homeCharacters, tCharacterList);
      },
    );

    test(
      'harus mengubah state menjadi Error saat terjadi ServerFailure',
      () async {
        when(
          mockGetCharacters.execute(),
        ).thenThrow(ServerFailure('Server Down'));

        await provider.fetchCharacters();

        expect(provider.homeState, RequestState.error);
        expect(provider.message, 'Server Down');
      },
    );

    test(
      'harus mengubah searchState menjadi Loaded saat pencarian berhasil',
      () async {
        const tQuery = 'Rick';
        when(
          mockSearchCharacters.execute(tQuery),
        ).thenAnswer((_) async => tCharacterList);

        await provider.searchCharacter(tQuery);

        expect(provider.searchState, RequestState.loaded);
        expect(provider.searchCharacters, tCharacterList);
      },
    );
  });
}
