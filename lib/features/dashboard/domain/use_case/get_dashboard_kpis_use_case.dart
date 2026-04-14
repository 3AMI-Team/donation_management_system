import 'package:dartz/dartz.dart';
import '../../../../core/network/errors/failure.dart';
import '../../../../core/utils/use_case.dart';
import '../entity/dashboard_kpis_entity.dart';
import '../repo/dashboard_repo.dart';

class GetDashboardKpisUseCase implements UseCase<DashboardKpis, NoParams> {
  final DashboardRepo repository;

  GetDashboardKpisUseCase(this.repository);

  @override
  Future<Either<Failure, DashboardKpis>> call(NoParams params) async {
    return await repository.getDashboardKpis();
  }
}
