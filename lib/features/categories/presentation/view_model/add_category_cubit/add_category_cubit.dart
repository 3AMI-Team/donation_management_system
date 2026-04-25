import 'package:donation_management_system/features/categories/domain/use_case/add_category_use_case.dart';
import 'package:donation_management_system/features/categories/domain/use_case/update_category_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;

  AddCategoryCubit({
    required this.addCategoryUseCase,
    required this.updateCategoryUseCase,
  }) : super(AddCategoryInitial());

  Future<void> addCategory({
    required String type,
    required String description,
  }) async {
    emit(AddCategoryLoading());

    final categoryData = {
      "type": type,
      "description": description,
    };

    final result = await addCategoryUseCase(categoryData);

    result.fold(
      (failure) => emit(AddCategoryError(message: failure.message)),
      (_) => emit(AddCategorySuccess()),
    );
  }

  Future<void> updateCategory({
    required int id,
    required String type,
    required String description,
  }) async {
    emit(AddCategoryLoading());

    final categoryData = {
      "type": type,
      "description": description,
    };

    final result = await updateCategoryUseCase(UpdateCategoryParams(
      id: id,
      categoryData: categoryData,
    ));

    result.fold(
      (failure) => emit(AddCategoryError(message: failure.message)),
      (_) => emit(UpdateCategorySuccess()),
    );
  }
}
