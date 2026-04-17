import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorsKPIsCards extends StatelessWidget {
  const DonorsKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorStatsCubit, DonorStatsState>(
      builder: (context, state) {
        if (state is DonorStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DonorStatsError) {
          return Center(child: Text(state.message));
        }
        if (state is DonorStatsLoaded) {
          final kpis = state.kpis;
          return Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 16,
            children: [
              KPICard(
                title: 'Total Donors',
                value: kpis.totalDonors.toString(),
                logo: 'assets/icons/Donors.png',
                icon: Icons.people_outline_outlined,
              ),
              KPICard(
                title: 'Active Donors',
                value: kpis.activeDonors.toString(),
                logo: 'assets/icons/active cases.png',
                icon: Icons.check_circle_outline,
              ),
              KPICard(
                title: 'Total Donated',
                value: '\$${kpis.totalDonatedAmount.toStringAsFixed(0)}',
                logo: 'assets/icons/funds distributed.png',
                icon: Icons.attach_money,
              ),
              KPICard(
                title: 'Avg. Donation',
                value: '\$${kpis.avgDonation.toStringAsFixed(0)}',
                logo: 'assets/icons/funds distributed.png',
                icon: Icons.trending_up,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
