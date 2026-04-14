import 'package:dartz/dartz.dart';
import '../../../../core/network/errors/failure.dart';
import '../entity/dashboard_kpis_entity.dart';

abstract class DashboardRepo {
  Future<Either<Failure, DashboardKpis>> getDashboardKpis();
}
