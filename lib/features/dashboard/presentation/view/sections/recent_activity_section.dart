import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/recent_activity_table.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentActivityCubit, RecentActivityState>(
      builder: (context, state) {
        if (state is RecentActivityLoaded) {
          return FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: RecentActivityTable(donations: state.donations),
          );
        } else if (state is RecentActivityLoading) {
          return const ShimmerTable(rowCount: 5);
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
}
