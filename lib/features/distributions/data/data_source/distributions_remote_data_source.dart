import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_entity.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_kpis_entity.dart';

abstract class DistributionsRemoteDataSource {
  Future<DistributionKpisEntity> getDistributionKpis();
  Future<List<DistributionEntity>> getDistributions();
}

class DistributionsRemoteDataSourceImpl implements DistributionsRemoteDataSource {
  final ApiConsumer api;

  DistributionsRemoteDataSourceImpl({required this.api});

  @override
  Future<DistributionKpisEntity> getDistributionKpis() async {
    final response = await api.get(ServerStrings.distributionKPIs);
    return DistributionKpisEntity.fromJson(response);
  }

  @override
  Future<List<DistributionEntity>> getDistributions() async {
    final response = await api.get(ServerStrings.distributions);
    return (response as List)
        .map((e) => DistributionEntity.fromJson(e))
        .toList();
  }
}
