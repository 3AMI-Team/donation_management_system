import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/dashboard/data/model/dashboard_kpis_model.dart';
import 'package:donation_management_system/features/dashboard/data/model/donation_trends_model.dart';
import 'package:donation_management_system/features/dashboard/data/model/last_donation_model.dart';
import 'package:donation_management_system/features/dashboard/data/model/last_distribution_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardKpisModel> getDashboardKpis();
  Future<DonationTrendsModel> getDonationTrends();
  Future<List<LastDonationModel>> getLastDonations();
  Future<List<LastDistributionModel>> getLastDistributions();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiConsumer api;

  DashboardRemoteDataSourceImpl(this.api);

  @override
  Future<DashboardKpisModel> getDashboardKpis() async {
    final response = await api.get(ServerStrings.dashboardKPIs);
    return DashboardKpisModel.fromJson(response);
  }

  @override
  Future<DonationTrendsModel> getDonationTrends() async {
    final response = await api.get(ServerStrings.donationTrends);
    return DonationTrendsModel.fromJson(response);
  }

  @override
  Future<List<LastDonationModel>> getLastDonations() async {
    final response = await api.get(ServerStrings.lastDonations);
    return (response as List)
        .map((json) => LastDonationModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<LastDistributionModel>> getLastDistributions() async {
    final response = await api.get(ServerStrings.lastDistributions);
    return (response as List)
        .map((json) => LastDistributionModel.fromJson(json))
        .toList();
  }
}
