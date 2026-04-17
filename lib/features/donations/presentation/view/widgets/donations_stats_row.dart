import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donation_stats_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:intl/intl.dart';

class DonationsStatsRow extends StatelessWidget {
  const DonationsStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );

    return BlocBuilder<DonationStatsCubit, DonationStatsState>(
      builder: (context, state) {
        if (state is DonationStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DonationStatsError) {
          return Center(child: Text(state.message));
        }
        if (state is DonationStatsLoaded) {
          final kpis = state.kpis;
          return Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Monthly Total',
                  value: currencyFormat.format(kpis.monthlyTotal),
                  percentageChange: 0,
                  icon: Icons.account_balance_wallet_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: StatCard(
                  title: 'Transactions',
                  value: kpis.transactionCount.toString(),
                  percentageChange: 0,
                  icon: Icons.receipt_long_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: StatCard(
                  title: 'Top Category',
                  value: kpis.topCategory,
                  percentageChange: 0,
                  icon: Icons.star_border_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: StatCard(
                  title: 'Pending Amount',
                  value: currencyFormat.format(kpis.pendingAmount),
                  percentageChange: 0,
                  icon: Icons.hourglass_empty_outlined,
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
