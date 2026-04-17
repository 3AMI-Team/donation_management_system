import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String type;
  final String description;

  const CategoryEntity({
    required this.id,
    required this.type,
    required this.description,
  });

  @override
  List<Object?> get props => [id, type, description];
}
