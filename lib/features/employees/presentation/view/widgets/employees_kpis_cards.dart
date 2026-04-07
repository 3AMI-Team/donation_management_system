import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EmployeesKPIsCards extends StatelessWidget {
  const EmployeesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: KPICard(
            title: 'Total Employees',
            value: '48',
            logo: 'assets/icons/Donors.png',
            icon: Icons.groups_outlined,
          ),
        ),

        const SizedBox(width: 16), 

        Expanded(
          child: KPICard(
            title: 'Active Now',
            value: '32',
            logo: 'assets/icons/active cases.png',
            icon: Icons.check_circle_outline_rounded,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: KPICard(
            title: 'Admins',
            value: '5',
            logo: 'assets/icons/funds distributed.png',
            icon: Icons.admin_panel_settings_outlined,
          ),
        ),
      ],
    );
  }
}