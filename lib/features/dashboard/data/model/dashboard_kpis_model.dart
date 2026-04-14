import '../../domain/entity/dashboard_kpis_entity.dart';

class KpiValueModel extends KpiValue {
  const KpiValueModel({
    required super.amount,
    required super.vsLastMonth,
  });

  factory KpiValueModel.fromJson(Map<String, dynamic> json) {
    return KpiValueModel(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      vsLastMonth: (json['vsLastMonth'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'vsLastMonth': vsLastMonth,
    };
  }
}

class DashboardKpisModel extends DashboardKpis {
  const DashboardKpisModel({
    required super.totalDonations,
    required super.activeCases,
    required super.totalDonors,
    required super.fundsDistributed,
  });

  factory DashboardKpisModel.fromJson(Map<String, dynamic> json) {
    const defaultKpi = KpiValueModel(amount: 0.0, vsLastMonth: 0.0);
    return DashboardKpisModel(
      totalDonations: json['totalDonations'] != null
          ? KpiValueModel.fromJson(json['totalDonations'])
          : defaultKpi,
      activeCases: json['activeCases'] != null
          ? KpiValueModel.fromJson(json['activeCases'])
          : defaultKpi,
      totalDonors: json['totalDonors'] != null
          ? KpiValueModel.fromJson(json['totalDonors'])
          : defaultKpi,
      fundsDistributed: json['fundsDistributed'] != null
          ? KpiValueModel.fromJson(json['fundsDistributed'])
          : defaultKpi,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalDonations': (totalDonations as KpiValueModel).toJson(),
      'activeCases': (activeCases as KpiValueModel).toJson(),
      'totalDonors': (totalDonors as KpiValueModel).toJson(),
      'fundsDistributed': (fundsDistributed as KpiValueModel).toJson(),
    };
  }
}
