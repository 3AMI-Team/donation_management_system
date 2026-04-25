import 'package:animate_do/animate_do.dart';
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
          final kpis = [
            (
              title: 'Total Distributed',
              value: '${state.kpis.totalDistributed.toStringAsFixed(0)} EGP',
              icon: Icons.attach_money_rounded,
              logo: 'assets/icons/funds distributed.png',
              color: const Color(0xFF10B981)
            ),
            (
              title: 'Cases Served',
              value: '${state.kpis.casesServed}',
              icon: Icons.people_outline,
              logo: 'assets/icons/active cases.png',
              color: const Color(0xFFF59E0B)
            ),
            (
              title: 'Avg Distribution',
              value: '${state.kpis.avgDistribution.toStringAsFixed(0)} EGP',
              icon: Icons.analytics_outlined,
              logo: null,
              color: const Color(0xFF3B82F6)
            ),
            (
              title: 'Remaining Balance',
              value: '${state.kpis.remainingBalance.toStringAsFixed(0)} EGP',
              icon: Icons.account_balance_wallet_outlined,
              logo: null,
              color: const Color(0xFF8B5CF6)
            ),
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
                      iconColor: kpi.color,
                      logo: kpi.logo,
                      percentageChange: 0,
                    ),
                  ),
                ),
              );
            }),
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
