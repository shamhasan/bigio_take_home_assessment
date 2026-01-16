import 'dart:convert';

import 'package:bigio_test_app/features/character/domain/entities/character_entity.dart';

class CharacterModels extends CharacterEntity {
  CharacterModels({
    required int id,
    required String name,
    required String species,
    required String gender,
    required String origin,
    required String location,
    required String image,
  }) : super(
         id: id,
         name: name,
         species: species,
         gender: gender,
         origin: origin,
         location: location,
         image: image,
       );

  factory CharacterModels.fromMap(Map<String, dynamic> map) {
    return CharacterModels(
      id: map['id'] as int,
      name: map['name'] as String,
      species: map['species'] as String,
      gender: map['gender'] as String,
      origin: map['origin'] as String,
      location: map['location'] as String,
      image: map['image'] as String,
    );
  }

  factory CharacterModels.fromJson(Map<String, dynamic> map) {
    return CharacterModels(
      id: map['id'] as int,
      name: map['name'] ?? '',
      species: map['species'] ?? '',
      gender: map['gender'] ?? '',
      origin: map['origin']['name'] ?? 'Unknown', 
      location: map['location']['name'] ?? 'Unknown',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'species': species,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
    };
  }
}
