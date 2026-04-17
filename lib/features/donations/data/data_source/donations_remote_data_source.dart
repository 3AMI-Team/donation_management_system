import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/donations/data/model/donations_response_model.dart';
import 'package:donation_management_system/features/donations/data/model/donation_kpis_model.dart';

abstract class DonationsRemoteDataSource {
  Future<DonationsResponseModel> getDonations({
    String? status,
    String? category,
  });

  Future<void> registerDonation({
    required double amount,
    required String description,
    required String status,
    required String date,
    required int donorId,
    required int categoryId,
    required int supervisorId,
  });

  Future<DonationKpisModel> getDonationKpis();
}

class DonationsRemoteDataSourceImpl implements DonationsRemoteDataSource {
  final ApiConsumer api;

  DonationsRemoteDataSourceImpl({required this.api});

  @override
  Future<DonationsResponseModel> getDonations({
    String? status,
    String? category,
  }) async {
    final response = await api.get(
      ServerStrings.allDonations,
      queryParameters: {
        'status': status,
        'category': category,
      },
    );
    return DonationsResponseModel.fromJson(response);
  }

  @override
  Future<void> registerDonation({
    required double amount,
    required String description,
    required String status,
    required String date,
    required int donorId,
    required int categoryId,
    required int supervisorId,
  }) async {
    await api.post(
      ServerStrings.registerDonation,
      body: {
        'amount': amount,
        'description': description,
        'status': status,
        'date': date,
        'donorId': donorId,
        'categoryId': categoryId,
        'supervisorId': supervisorId,
      },
    );
  }

  @override
  Future<DonationKpisModel> getDonationKpis() async {
    final response = await api.get(ServerStrings.donationKPIs);
    return DonationKpisModel.fromJson(response);
  }
}
