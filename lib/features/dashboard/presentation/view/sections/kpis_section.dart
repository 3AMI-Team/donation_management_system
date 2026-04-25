import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/dashboard_error_widget.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/kpis_cards.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KpisSection extends StatelessWidget {
  const KpisSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KpisCubit, KpisState>(
      builder: (context, state) {
        if (state is KpisLoaded) {
          return KPIsCards(kpis: state.kpis);
        } else if (state is KpisLoading) {
          return const ShimmerStatsRow(count: 4, cardHeight: 110);
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
}
