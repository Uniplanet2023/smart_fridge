import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String id;
  final String name;
  final String description;
  final String instructions;
  final DateTime timestamp;
  final String country;
  final bool shared;

  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.instructions,
    required this.timestamp,
    required this.country,
    required this.shared,
  });

  @override
  List<Object?> get props =>
      [id, name, description, instructions, timestamp, country, shared];
}
