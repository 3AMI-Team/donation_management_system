import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';

class Donor {
  final String name;
  final String? avatarUrl;

  Donor({required this.name, this.avatarUrl});
}

class DonationData {
  final Donor donor;
  final String amount;
  final String category;
  final DateTime date;
  final String status;
  final String? employeeName;
  final String? employeeAvatarUrl;

  DonationData({
    required this.donor,
    required this.amount,
    required this.category,
    required this.date,
    required this.status,
    this.employeeName,
    this.employeeAvatarUrl,
  });
}

class DonationTable extends StatelessWidget {
  final List<DonationData> donations;
  final VoidCallback? onMenuPressed;

  const DonationTable({
    super.key,
    required this.donations,
    this.onMenuPressed,
  });

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return const Color(0xFFF39C12);
      case 'health':
        return const Color(0xFF3498DB);
      case 'education':
        return const Color(0xFF9B59B6);
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border),
              ),
            ),
            child: Row(
              children: [
                _buildHeaderCell('Donor', flex: 2),
                _buildHeaderCell('Amount', flex: 1),
                _buildHeaderCell('Category', flex: 1),
                _buildHeaderCell('Date', flex: 1),
                _buildHeaderCell('Status', flex: 1),
                _buildHeaderCell('Assigned', flex: 1),
                SizedBox(width: 40.w),
              ],
            ),
          ),
          ...donations.map((donation) => _buildDataRow(donation)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildDataRow(DonationData donation) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  backgroundImage: donation.donor.avatarUrl != null
                      ? NetworkImage(donation.donor.avatarUrl!)
                      : null,
                  child: donation.donor.avatarUrl == null
                      ? Text(
                          donation.donor.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        )
                      : null,
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    donation.donor.name,
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
          Expanded(
            flex: 1,
            child: Text(
              donation.amount,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: _getCategoryColor(donation.category).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                donation.category,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: _getCategoryColor(donation.category),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${donation.date.day}/${donation.date.month}/${donation.date.year}',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: _getStatusColor(donation.status),
                    shape: BoxShape.circle,
                  ),
                ),
                Gap(6.w),
                Text(
                  donation.status,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: _getStatusColor(donation.status),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: donation.employeeName != null
                ? Row(
                    children: [
                      CircleAvatar(
                        radius: 12.r,
                        backgroundColor: AppColors.secondary.withOpacity(0.1),
                        backgroundImage: donation.employeeAvatarUrl != null
                            ? NetworkImage(donation.employeeAvatarUrl!)
                            : null,
                        child: donation.employeeAvatarUrl == null
                            ? Text(
                                donation.employeeName!.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary,
                                ),
                              )
                            : null,
                      ),
                      Gap(6.w),
                      Expanded(
                        child: Text(
                          donation.employeeName!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          SizedBox(
            width: 40.w,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.textSecondary),
              onSelected: (value) {},
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'view', child: Text('View Details')),
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
