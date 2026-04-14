import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_chart.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TrendsSection extends StatelessWidget {
  const TrendsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendsCubit, TrendsState>(
      builder: (context, state) {
        if (state is TrendsLoaded) {
          return DashboardChart(trends: state.trends);
        } else if (state is TrendsLoading) {
          return _buildShimmer();
        } else if (state is TrendsError) {
          return DashboardErrorWidget(
            message: state.message,
            onRetry: () => context.read<TrendsCubit>().getTrends(),
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
        width: 800.w,
        height: 500.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
