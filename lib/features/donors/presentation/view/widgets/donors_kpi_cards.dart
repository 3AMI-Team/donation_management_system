import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
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
          return const ShimmerStatsRow(count: 4, cardHeight: 110);
        }
        if (state is DonorStatsError) {
          return Center(child: Text(state.message));
        }
        if (state is DonorStatsLoaded) {
          final kpis = [
            (title: 'Total Donors', value: state.kpis.totalDonors.toString(), icon: Icons.people_outline_outlined),
            (title: 'New Donors (Month)', value: state.kpis.newDonorsThisMonth.toString(), icon: Icons.person_add_outlined),
            (title: 'Total Donated', value: state.kpis.totalDonatedAmount.toCompactCurrency(), icon: Icons.attach_money),
            (title: 'Avg. Donation', value: state.kpis.avgDonation.toCompactCurrency(), icon: Icons.trending_up),
          ];

          return Row(
            children: List.generate(kpis.length, (index) {
              final kpi = kpis[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < kpis.length - 1 ? 16.w : 0),
                  child: FadeInUp(
                    delay: Duration(milliseconds: index * 100),
                    duration: const Duration(milliseconds: 500),
                    child: StatCard(
                      title: kpi.title,
                      value: kpi.value,
                      icon: kpi.icon,
                      percentageChange: 0,
                    ),
                  ),
                ),
              );
            }),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
