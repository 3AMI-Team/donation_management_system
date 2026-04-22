import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employee_stats_cubit/employee_stats_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employee_stats_cubit/employee_stats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesKPIsCards extends StatelessWidget {
  const EmployeesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeStatsCubit, EmployeeStatsState>(
      builder: (context, state) {
        if (state is EmployeeStatsLoading || state is EmployeeStatsInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EmployeeStatsError) {
          return Center(
            child: Text(state.message, style: TextStyle(color: Colors.red)),
          );
        }

        if (state is EmployeeStatsLoaded) {
          final kpis = state.kpis;
          return Row(
            children: [
              Expanded(
                child: KPICard(
                  title: 'Total Employees',
                  value: kpis.totalEmployees.toString(),
                  logo: 'assets/icons/Donors.png',
                  icon: Icons.groups_outlined,
                  vsLastMonth: kpis.monthlyActivityRate * 100,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: KPICard(
                  title: 'Active Supervisors',
                  value: kpis.activeSupervisors.toString(),
                  logo: 'assets/icons/active cases.png',
                  icon: Icons.check_circle_outline_rounded,
                  vsLastMonth: kpis.monthlyActivityRate * 100,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: KPICard(
                  title: 'Admins',
                  value: kpis.adminCount.toString(),
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.admin_panel_settings_outlined,
                  vsLastMonth: kpis.monthlyActivityRate * 100,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: KPICard(
                  title: 'Activity Rate',
                  value:
                      '${(kpis.monthlyActivityRate * 100).toStringAsFixed(1)}%',
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.trending_up_rounded,
                  vsLastMonth: kpis.monthlyActivityRate * 100,
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
