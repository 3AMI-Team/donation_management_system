import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../domain/entity/dashboard_kpis_entity.dart';

class KPIsCards extends StatelessWidget {
  final DashboardKpis kpis;
  const KPIsCards({super.key, required this.kpis});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KPICard(
            title: 'Total Donations',
            value: kpis.totalDonations.amount.toCompactCurrency(),
            vsLastMonth: kpis.totalDonations.vsLastMonth,
            logo: 'assets/icons/mony.png',
            icon: Icons.attach_money_outlined,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: KPICard(
            title: 'Active Cases',
            value: kpis.activeCases.amount.toString(),
            vsLastMonth: kpis.activeCases.vsLastMonth,
            logo: 'assets/icons/active cases.png',
            icon: Icons.people_alt_outlined,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: KPICard(
            title: 'Total Donors',
            value: kpis.totalDonors.amount.toString(),
            vsLastMonth: kpis.totalDonors.vsLastMonth,
            logo: 'assets/icons/Donors.png',
            icon: Icons.people_outline_outlined,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: KPICard(
            title: 'Funds Distributed',
            value: kpis.fundsDistributed.amount.toCompactCurrency(),
            vsLastMonth: kpis.fundsDistributed.vsLastMonth,
            logo: 'assets/icons/funds distributed.png',
            icon: Icons.attach_money_outlined,
          ),
        ),
      ],
    );
  }
}
