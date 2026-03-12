import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/features/donors/data/models/donor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DonorDataRow extends StatelessWidget {
  const DonorDataRow({super.key, required this.donor});

  final DonorModel donor;

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
          //Donor name with avatar
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),

                  child: Text(
                    donor.name.substring(0, 1).toUpperCase(),
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
                    donor.name,
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
         //Donor ID
          Expanded(
            //Donor phone number
            flex: 1,
            child: Text(
              donor.phoneNumber,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          //Donor email 
          Expanded(
            //Donor email
            flex: 2,
            child: Text(
              donor.email,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ),
         //Donor registration date
          Expanded(
            //Donor registration date
            flex: 1,
            child: Text(
              '${donor.registDate.day}/${donor.registDate.month}/${donor.registDate.year}',
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
          ),
         //Donor type
          Expanded(
            //Donor type
            flex: 1,
            child: Row(
              children: [
                Text(
                  //Donor type
                  donor.type == DonorType.individual
                      ? 'Individual'
                      : 'Organization',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
         //Donor address  
          Expanded(
            //Donor address
            flex: 1,
            child: Text(
              donor.address,
              style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
         //Actions buttons
          ActionsButtons(),
        ],
      ),
    );
  }
}



class ActionsButtons extends StatelessWidget {
  const ActionsButtons({super.key});

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
        onSelected: (value) {},
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'view', child: Text('View Details')),
          const PopupMenuItem(value: 'edit', child: Text('Edit')),
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
