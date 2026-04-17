import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'donation_table_row.dart';

class DonationsTable extends StatelessWidget {
  final List<Donation> donations;
  const DonationsTable({super.key, required this.donations});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const _DonationsTableHeader(),
          if (donations.isEmpty)
            _buildEmptyState()
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: donations.length,
              itemBuilder: (context, index) {
                return DonationTableRow(donation: donations[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.all(32.r),
      child: const Text('No donations found matching your criteria'),
    );
  }
}

class _DonationsTableHeader extends StatelessWidget {
  const _DonationsTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      color: AppColors.divider.withOpacity(0.3),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _headerCell('Donor', width: 200.w),
            _headerCell('Amount', width: 140.w),
            _headerCell('Category', width: 140.w),
            _headerCell('Date', width: 140.w),
            _headerCell('Supervisor', width: 150.w),
            Expanded(child: _headerCell('Status', textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text, {double? width, TextAlign? textAlign}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: textAlign,
        style: AppTypography.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
