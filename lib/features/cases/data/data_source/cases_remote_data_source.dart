import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/cases/data/model/cases_response_model.dart';

abstract class CasesRemoteDataSource {
  Future<CasesResponseModel> getCases();
}

class CasesRemoteDataSourceImpl implements CasesRemoteDataSource {
  final ApiConsumer api;

  CasesRemoteDataSourceImpl({required this.api});

  @override
  Future<CasesResponseModel> getCases() async {
    final response = await api.get(ServerStrings.cases);
    // Wrapping the response in model
    return CasesResponseModel.fromJson(response);
  }
}
