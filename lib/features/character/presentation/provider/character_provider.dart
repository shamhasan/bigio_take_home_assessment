import 'package:bigio_test_app/core/error/failures.dart';
import 'package:bigio_test_app/core/utils/request_state.dart';
import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';

import 'package:bigio_test_app/features/character/domain/usecases/get_characters.dart';
import 'package:bigio_test_app/features/character/domain/usecases/get_favorites.dart';
import 'package:bigio_test_app/features/character/domain/usecases/is_favorite.dart';
import 'package:bigio_test_app/features/character/domain/usecases/search_characters.dart';
import 'package:bigio_test_app/features/character/domain/usecases/toggle_favorites.dart';

class CharacterProvider extends ChangeNotifier {
  final GetCharacters getCharactersUsecase;
  final SearchCharacters searchCharactersUsecase;
  final ToggleFavorites toggleFavoritesUsecase;
  final GetFavorites getFavoritesUsecase;
  final IsFavorite isFavoriteUsecase;
  CharacterProvider({
    required this.getCharactersUsecase,
    required this.searchCharactersUsecase,
    required this.toggleFavoritesUsecase,
    required this.getFavoritesUsecase,
    required this.isFavoriteUsecase,
  });

  RequestState _homeState = RequestState.empty;
  RequestState get homeState => _homeState;

  List<CharacterEntity> _homeCharacters = [];
  List<CharacterEntity> get homeCharacters => _homeCharacters;

  RequestState _searchState = RequestState.empty;
  RequestState get searchState => _searchState;

  List<CharacterEntity> _searchCharacters = [];
  List<CharacterEntity> get searchCharacters => _searchCharacters;

  String _message = '';
  String get message => _message;

  List<CharacterEntity> _favCharacters = [];
  List<CharacterEntity> get favCharacters => _favCharacters;

  RequestState _favState = RequestState.empty;
  RequestState get favState => _favState;

  bool _isFav = false;
  bool get isFav => _isFav;

  Future<void> fetchCharacters() async {
    _homeState = RequestState.loading;
    notifyListeners();

    try {
      final result = await getCharactersUsecase.execute();
      if (result.isEmpty) {
        _homeState = RequestState.empty;
        _message = "Character not found";
      } else {
        _homeState = RequestState.loaded;
        _homeCharacters = result;
      }
    } catch (e) {
      _homeState = RequestState.error;
      if (e is Failure) {
        _message = e.message;
      } else {
        _message = e.toString();
      }
    }
    notifyListeners();
  }

  Future<void> searchCharacter(String query) async {
    _searchState = RequestState.loading;
    notifyListeners();

    try {
      final result = await searchCharactersUsecase.execute(query);
      if (result.isEmpty) {
        _searchState = RequestState.empty;
        _searchCharacters = [];
        _message = "Character not found";
      } else {
        _searchState = RequestState.loaded;
        _searchCharacters = result;
      }
    } catch (e) {
      _searchState = RequestState.error;
      if (e is Failure) {
        _message = e.message;
      } else {
        _message = "Character not found";
      }
    }
    notifyListeners();
  }

  void resetSearch() {
    _searchState = RequestState.empty;
    _searchCharacters = [];
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    _favState = RequestState.loading;
    notifyListeners();

    try {
      final result = await getFavoritesUsecase.execute();
      _favCharacters = result;

      if (result.isEmpty) {
        _favState = RequestState.empty;
        _message = "Empty favorite charcter list";
      } else {
        _favState = RequestState.loaded;
      }
    } catch (e) {
      _favState = RequestState.error;
      if (e is Failure) {
        _message = e.message;
      } else {
        _message = e.toString();
      }
    }
    notifyListeners();
  }

  Future<void> checkIsFavorite(int id) async {
    final result = await isFavoriteUsecase.execute(id);
    _isFav = result;
    notifyListeners();
  }

  Future<void> toggleFavorite(CharacterEntity char) async {
    try {
      await toggleFavoritesUsecase.execute(char);

      await checkIsFavorite(char.id);
      if (_favState == RequestState.loaded) {
        loadFavorites();
      }
    } catch (e) {
      if (e is Failure) {
        _message = e.message;
      }
      notifyListeners();
    }
  }
}
