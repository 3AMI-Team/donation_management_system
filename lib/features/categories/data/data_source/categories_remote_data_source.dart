import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/categories/data/model/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(Map<String, dynamic> categoryData);
  Future<void> updateCategory(int id, Map<String, dynamic> categoryData);
  Future<void> deleteCategory(int id);
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiConsumer api;

  CategoriesRemoteDataSourceImpl({required this.api});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await api.get(ServerStrings.categories);
    return (response as List)
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  @override
  Future<void> addCategory(Map<String, dynamic> categoryData) async {
    await api.post(ServerStrings.categories, body: categoryData);
  }

  @override
  Future<void> updateCategory(int id, Map<String, dynamic> categoryData) async {
    await api.put('${ServerStrings.categories}/$id', body: categoryData);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await api.delete('${ServerStrings.categories}/$id');
  }
}
