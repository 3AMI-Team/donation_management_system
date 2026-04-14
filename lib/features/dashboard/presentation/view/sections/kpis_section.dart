import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/kpis_cards.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class KpisSection extends StatelessWidget {
  const KpisSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KpisCubit, KpisState>(
      builder: (context, state) {
        if (state is KpisLoaded) {
          return KPIsCards(kpis: state.kpis);
        } else if (state is KpisLoading) {
          return _buildShimmer();
        } else if (state is KpisError) {
          return DashboardErrorWidget(
            message: state.message,
            onRetry: () => context.read<KpisCubit>().getKpis(),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          4,
          (index) => Container(
            width: 290.w,
            height: 160.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }
}
