import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/last_distributions_list.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributionsSection extends StatelessWidget {
  const DistributionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastDistributionsCubit, LastDistributionsState>(
      builder: (context, state) {
        if (state is LastDistributionsLoaded) {
          return FadeInRight(
            duration: const Duration(milliseconds: 600),
            child: LastDistributionsList(distributions: state.distributions),
          );
        } else if (state is LastDistributionsLoading) {
          return const AppShimmer(child: ShimmerBox(width: 385, height: 620));
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
}
