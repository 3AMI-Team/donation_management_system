import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/add_distribution_dialog.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewDistribution extends StatelessWidget {
  const AddNewDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add Distribution",
      onTap: () {
        final addDistCubit = context.read<AddDistributionCubit>();
        final distsCubit = context.read<DistributionsCubit>();
        final statsCubit = context.read<DistributionStatsCubit>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: addDistCubit),
                BlocProvider.value(value: distsCubit),
                BlocProvider.value(value: statsCubit),
              ],
              child: const AddDistributionDialog(),
            );
          },
        );
      },
    );
  }
}
