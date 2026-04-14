import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/last_distributions_list.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DistributionsSection extends StatelessWidget {
  const DistributionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastDistributionsCubit, LastDistributionsState>(
      builder: (context, state) {
        if (state is LastDistributionsLoaded) {
          return LastDistributionsList(distributions: state.distributions);
        } else if (state is LastDistributionsLoading) {
          return _buildShimmer();
        } else if (state is LastDistributionsError) {
          return DashboardErrorWidget(
            message: state.message,
            onRetry: () => context.read<LastDistributionsCubit>().getLastDistributions(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 385.w,
        height: 620.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
