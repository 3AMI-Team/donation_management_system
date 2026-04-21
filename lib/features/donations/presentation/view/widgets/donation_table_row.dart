import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:intl/intl.dart';

class DonationTableRow extends StatelessWidget {
  final Donation donation;
  const DonationTableRow({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72.h,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _cell(donation.donorName, width: 200.w),
            _cell(
              '\$${donation.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
              width: 140.w,
            ),
            _cell(donation.categoryName, width: 140.w),
            _cell(
              DateFormat('MMM dd, yyyy').format(donation.date),
              width: 140.w,
            ),
            _cell(donation.supervisorName, width: 150.w),
            Expanded(child: _statusCell(donation.status)),
          ],
        ),
      ),
    );
  }

  Widget _cell(String text, {double? width, TextStyle? style}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.bodyMedium.merge(style),
      ),
    );
  }

  Widget _statusCell(String status) {
    Color color;
    Color bgColor;

    switch (status.toLowerCase()) {
      case 'completed':
        color = AppColors.success;
        bgColor = AppColors.success.withOpacity(0.1);
        break;
      case 'pending':
        color = AppColors.warning;
        bgColor = AppColors.warning.withOpacity(0.1);
        break;
      case 'cancelled':
        color = AppColors.error;
        bgColor = AppColors.error.withOpacity(0.1);
        break;
      default:
        color = AppColors.textSecondary;
        bgColor = AppColors.divider.withOpacity(0.5);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              Gap(5.w),
              Text(
                status,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
