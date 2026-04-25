import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/add_donor_dialog.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_state.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorActionsButtons extends StatelessWidget {
  final DonorEntity donor;
  const DonorActionsButtons({super.key, required this.donor});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider(
        create: (context) => sl<AddDonorCubit>(),
        child: BlocConsumer<AddDonorCubit, AddDonorState>(
          listener: (context, state) {
            if (state is DeleteDonorSuccess) {
              context.showSuccessSnackBar("Donor deleted successfully!");
              context.read<DonorsCubit>().onDonorDeleted(donor.id);
              context.read<DonorStatsCubit>().getDonorKpis();
              Navigator.pop(context);
            } else if (state is AddDonorError) {
              context.showErrorSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: const Text("Confirm Delete"),
              content: Text("Are you sure you want to delete ${donor.name}?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: state is AddDonorLoading
                      ? null
                      : () => context.read<AddDonorCubit>().deleteDonor(donor.id),
                  child: state is AddDonorLoading
                      ? SizedBox(width: 20.sp, height: 20.sp, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text("Delete", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.textSecondary),
        onSelected: (value) {
          switch (value) {
            case 'edit':
              showDialog(
                context: context,
                builder: (dialogContext) => AddDonorDialog(donor: donor),
              );
              break;
            case 'delete':
              _showDeleteDialog(context);
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit_outlined, size: 18),
                Gap(8),
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_outline, size: 18, color: Colors.red),
                Gap(8),
                Text('Delete', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
