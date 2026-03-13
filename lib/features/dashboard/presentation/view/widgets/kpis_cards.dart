import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:flutter/material.dart';

class KPIsCards extends StatelessWidget {
  const KPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        KPICard(
          title: 'Total Donations',
          value: '5,085,200',
          logo: 'assets/icons/mony.png',
          icon: Icons.attach_money_outlined,
        ),

        KPICard(
          title: 'Active Cases',
          value: '42',
          logo: 'assets/icons/active cases.png',
          icon: Icons.people_alt_outlined,
        ),
        KPICard(
          title: 'Total Donors',
          value: '1,200',
          logo: 'assets/icons/Donors.png',
          icon: Icons.people_outline_outlined,
        ),
        KPICard(
          title: 'Funds Distributed',
          value: '85,200',
          logo: 'assets/icons/funds distributed.png',
          icon: Icons.attach_money_outlined,
        ),
      ],
    );
  }
}
