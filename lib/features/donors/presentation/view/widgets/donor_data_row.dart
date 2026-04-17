import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/add_new_donor.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_state.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DonorDataRow extends StatelessWidget {
  const DonorDataRow({super.key, required this.donorEntity});

  final DonorEntity donorEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          // Donor name with avatar
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    donorEntity.name.isNotEmpty
                        ? donorEntity.name.substring(0, 1).toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    donorEntity.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Phone
          Expanded(
            flex: 1,
            child: Text(
              donorEntity.phone,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Email
          Expanded(
            flex: 2,
            child: Text(
              donorEntity.email,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Registration date
          Expanded(
            flex: 1,
            child: Text(
              '${donorEntity.registerDate.day}/${donorEntity.registerDate.month}/${donorEntity.registerDate.year}',
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
          ),

          // Actions buttons
          ActionsButtons(donor: donorEntity),
        ],
      ),
    );
  }
}

class ActionsButtons extends StatelessWidget {
  final DonorEntity? donor;
  const ActionsButtons({super.key, this.donor});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider(
        create: (context) => sl<AddDonorCubit>(),
        child: BlocConsumer<AddDonorCubit, AddDonorState>(
          listener: (context, state) {
            if (state is DeleteDonorSuccess) {
              context.showSuccessSnackBar("Donor deleted successfully!");
              // Local update for better UX
              if (donor != null) {
                BlocProvider.of<DonorsCubit>(context).onDonorDeleted(donor!.id);
              }
              BlocProvider.of<DonorStatsCubit>(context).getDonorKpis();
              Navigator.pop(context);
            } else if (state is AddDonorError) {
              context.showErrorSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: const Text("Confirm Delete"),
              content: Text("Are you sure you want to delete ${donor?.name}?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: state is AddDonorLoading
                      ? null
                      : () {
                          if (donor != null) {
                            context.read<AddDonorCubit>().deleteDonor(donor!.id);
                          }
                        },
                  child: state is AddDonorLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
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
        icon: Icon(
          Icons.more_vert,
          size: 20.sp,
          color: AppColors.textSecondary,
        ),
        onSelected: (value) {
          if (donor == null) return;
          switch (value) {
            case 'view':
              // Potential View details logic here if needed
              break;
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
            value: 'view',
            child: Row(
              children: [
                Icon(Icons.visibility_outlined, size: 18),
                Gap(8),
                Text('View Details'),
              ],
            ),
          ),
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
