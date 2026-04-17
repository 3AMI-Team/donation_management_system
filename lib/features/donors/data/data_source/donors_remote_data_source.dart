import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/donors/data/model/donors_response_model.dart';
import 'package:donation_management_system/features/donors/data/model/donor_kpis_model.dart';

abstract class DonorsRemoteDataSource {
  Future<DonorsResponseModel> getDonors({
    required int page,
    required int pageSize,
  });

  Future<DonorKpisModel> getDonorKpis();

  Future<void> registerDonor({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  });

  Future<void> updateDonor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  });

  Future<void> deleteDonor(int id);
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

  @override
  Future<DonorKpisModel> getDonorKpis() async {
    final response = await api.get(ServerStrings.donorKPIs);
    return DonorKpisModel.fromJson(response);
  }

  @override
  Future<void> registerDonor({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  }) async {
    await api.post(
      ServerStrings.donors,
      body: {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'type': type,
      },
    );
  }

  @override
  Future<void> updateDonor({
    required int id,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String type,
  }) async {
    await api.put(
      "${ServerStrings.donors}/$id",
      body: {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'type': type,
      },
    );
  }

  @override
  Future<void> deleteDonor(int id) async {
    await api.delete("${ServerStrings.donors}/$id");
  }
}
