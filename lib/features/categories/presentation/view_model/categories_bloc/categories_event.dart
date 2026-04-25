import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent extends CategoriesEvent {}

class FilterCategoriesEvent extends CategoriesEvent {
  final String? query;
  final String? filter;
  const FilterCategoriesEvent({this.query, this.filter});
  @override
  List<Object?> get props => [query, filter];
}

class ChangePageEvent extends CategoriesEvent {
  final int page;
  const ChangePageEvent(this.page);
  @override
  List<Object?> get props => [page];
}

class AddCategoryEvent extends CategoriesEvent {
  final String type;
  final String description;
  const AddCategoryEvent({required this.type, required this.description});
  @override
  List<Object?> get props => [type, description];
}

class UpdateCategoryEvent extends CategoriesEvent {
  final int id;
  final String type;
  final String description;
  const UpdateCategoryEvent({
    required this.id,
    required this.type,
    required this.description,
  });
  @override
  List<Object?> get props => [id, type, description];
}

class DeleteCategoryEvent extends CategoriesEvent {
  final int id;
  const DeleteCategoryEvent(this.id);
  @override
  List<Object?> get props => [id];
}
