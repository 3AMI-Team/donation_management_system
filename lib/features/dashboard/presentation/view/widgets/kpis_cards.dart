import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entity/dashboard_kpis_entity.dart';

class KPIsCards extends StatelessWidget {
  final DashboardKpis kpis;
  const KPIsCards({super.key, required this.kpis});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final countFormatter = NumberFormat.decimalPattern();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KPICard(
          title: 'Total Donations',
          value: currencyFormatter.format(kpis.totalDonations.amount),
          vsLastMonth: kpis.totalDonations.vsLastMonth,
          logo: 'assets/icons/mony.png',
          icon: Icons.attach_money_outlined,
        ),
        KPICard(
          title: 'Active Cases',
          value: countFormatter.format(kpis.activeCases.amount),
          vsLastMonth: kpis.activeCases.vsLastMonth,
          logo: 'assets/icons/active cases.png',
          icon: Icons.people_alt_outlined,
        ),
        KPICard(
          title: 'Total Donors',
          value: countFormatter.format(kpis.totalDonors.amount),
          vsLastMonth: kpis.totalDonors.vsLastMonth,
          logo: 'assets/icons/Donors.png',
          icon: Icons.people_outline_outlined,
        ),
        KPICard(
          title: 'Funds Distributed',
          value: currencyFormatter.format(kpis.fundsDistributed.amount),
          vsLastMonth: kpis.fundsDistributed.vsLastMonth,
          logo: 'assets/icons/funds distributed.png',
          icon: Icons.attach_money_outlined,
        ),
      ],
    );
  }
}
