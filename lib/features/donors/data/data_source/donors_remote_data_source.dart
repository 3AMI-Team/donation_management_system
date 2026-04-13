import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/donors/data/model/donors_response_model.dart';

abstract class DonorsRemoteDataSource {
  Future<DonorsResponseModel> getDonors({
    required int page,
    required int pageSize,
  });
}

class DonorsRemoteDataSourceImpl implements DonorsRemoteDataSource {
  final ApiConsumer api;

  DonorsRemoteDataSourceImpl({required this.api});

  @override
  Future<DonorsResponseModel> getDonors({
    required int page,
    required int pageSize,
  }) async {
    final response = await api.get(
      ServerStrings.donors,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
      },
    );
    return DonorsResponseModel.fromJson(response);
  }
}
