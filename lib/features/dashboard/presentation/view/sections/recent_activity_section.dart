import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/recent_activity_table.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentActivityCubit, RecentActivityState>(
      builder: (context, state) {
        if (state is RecentActivityLoaded) {
          return RecentActivityTable(donations: state.donations);
        } else if (state is RecentActivityLoading) {
          return _buildShimmer();
        } else if (state is RecentActivityError) {
          return DashboardErrorWidget(
            message: state.message,
            onRetry: () => context.read<RecentActivityCubit>().getLastDonations(),
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
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}
