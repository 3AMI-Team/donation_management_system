import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_chart.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendsSection extends StatelessWidget {
  const TrendsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendsCubit, TrendsState>(
      builder: (context, state) {
        if (state is TrendsLoaded) {
          return FadeInLeft(
            duration: const Duration(milliseconds: 600),
            child: DashboardChart(trends: state.trends),
          );
        } else if (state is TrendsLoading) {
          return const AppShimmer(child: ShimmerBox(height: 500, width: double.infinity));
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
}
