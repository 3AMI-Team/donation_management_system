import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/core/widgets/shimmer_loading.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
          final kpis = state.kpis;
          return Row(
            children: [
              Expanded(
                child: KPICard(
                  title: 'Total Donors',
                  value: kpis.totalDonors.toString(),
                  logo: 'assets/icons/Donors.png',
                  icon: Icons.people_outline_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'New Donors (Month)',
                  value: kpis.newDonorsThisMonth.toString(),
                  logo: 'assets/icons/active cases.png',
                  icon: Icons.person_add_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Total Donated',
                  value: kpis.totalDonatedAmount.toCompactCurrency(),
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.attach_money,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Avg. Donation',
                  value: kpis.avgDonation.toCompactCurrency(),
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.trending_up,
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
