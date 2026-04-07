import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:flutter/material.dart';

class CategoriesKPIsCards extends StatelessWidget {
  const CategoriesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
        Expanded(
          child: KPICard(
            title: 'Total Active Categories',
            value: '24',
            logo: 'assets/icons/active cases.png',
            icon: Icons.category_outlined,
          ),
        ),

        const SizedBox(width: 12), 

        Expanded(
          child: KPICard(
            title: 'Avg. Cases per Category',
            value: '152',
            logo: 'assets/icons/Donors.png',
            icon: Icons.bar_chart_rounded,
          ),
        ),

        const SizedBox(width: 12), 

        Expanded(
          child: KPICard(
            title: 'Highest Impact',
            value: 'Medical Aid',
            logo: 'assets/icons/funds distributed.png',
            icon: Icons.volunteer_activism_outlined,
          ),
        ),
      ],
    );
  }
}