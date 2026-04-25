import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_actions_buttons.dart';
import 'package:flutter/material.dart';

class DonorDataRow extends StatelessWidget {
  final DonorEntity donorEntity;

  const DonorDataRow({super.key, required this.donorEntity});

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
          DonorActionsButtons(donor: donorEntity),
        ],
      ),
    );
  }
}
