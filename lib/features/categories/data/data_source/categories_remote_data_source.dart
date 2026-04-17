import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/categories/data/model/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
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
}
