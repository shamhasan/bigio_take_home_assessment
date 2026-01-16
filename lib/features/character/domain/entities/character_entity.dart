import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String species;
  final String gender;
  final String origin;
  final String location;
  final String image;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  @override 
  List<Object?> get props => [id, name, species, origin, location, image];
}
