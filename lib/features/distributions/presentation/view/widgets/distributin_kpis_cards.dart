import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributionKPIsCards extends StatelessWidget {
  const DistributionKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DistributionStatsCubit, DistributionStatsState>(
      builder: (context, state) {
        if (state is DistributionStatsLoaded) {
          final kpis = state.kpis;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: KPICard(
                  title: 'Total Distributed',
                  value: '${kpis.totalDistributed.toStringAsFixed(2)} EGP',
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.attach_money_rounded,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Cases Served',
                  value: '${kpis.casesServed}',
                  logo: 'assets/icons/active cases.png',
                  icon: Icons.people_outline,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Avg Distribution',
                  value: '${kpis.avgDistribution.toStringAsFixed(2)} EGP',
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.analytics_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Remaining Balance',
                  value: '${kpis.remainingBalance.toStringAsFixed(2)} EGP',
                  logo: 'assets/icons/Donors.png',
                  icon: Icons.account_balance_wallet_outlined,
                ),
              ),
            ],
          );
        }

        if (state is DistributionStatsError) {
          return Center(child: Text(state.message));
        }

        return const ShimmerStatsRow(count: 4, cardHeight: 110);
      },
    );
  }
}
