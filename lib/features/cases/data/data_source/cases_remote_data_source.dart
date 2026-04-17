import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/cases/data/model/cases_response_model.dart';
import 'package:donation_management_system/features/cases/data/model/case_kpis_model.dart';

abstract class CasesRemoteDataSource {
  Future<CasesResponseModel> getCases();
  Future<CaseKpisModel> getCaseKpis();
}

class CasesRemoteDataSourceImpl implements CasesRemoteDataSource {
  final ApiConsumer api;

  CasesRemoteDataSourceImpl({required this.api});

  @override
  Future<CasesResponseModel> getCases() async {
    final response = await api.get(ServerStrings.cases);
    return CasesResponseModel.fromJson(response);
  }

  @override
  Future<CaseKpisModel> getCaseKpis() async {
    final response = await api.get(ServerStrings.caseKPIs);
    return CaseKpisModel.fromJson(response);
  }
}
