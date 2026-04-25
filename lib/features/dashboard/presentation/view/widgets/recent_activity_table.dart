import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/last_donations_entity.dart';
import 'package:go_router/go_router.dart';
import 'activity_table_row.dart';

class RecentActivityTable extends StatelessWidget {
  final List<LastDonation> donations;
  const RecentActivityTable({super.key, required this.donations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        CustomTable<LastDonation>(
          headerCells: [
            TableHeader(text: 'Donor', width: 190.w),
            TableHeader(text: 'Amount', width: 150.w),
            TableHeader(text: 'Category', width: 150.w),
            TableHeader(text: 'Date', width: 150.w),
            const TableHeader(text: 'Status', textAlign: TextAlign.right),
          ],
          dataRow: donations,
          sortKeyExtractors: {
            0: (d) => d.donorName,
            1: (d) => d.amount,
            2: (d) => d.category,
            3: (d) => d.date,
          },
          itemBuilder: (item) => ActivityTableRow(donation: item),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Text('Recent Activity', style: AppTypography.h2),
          const Spacer(),
          TextButton(
            onPressed: () => context.go(Routes.donations),
            child: Text(
              'View All',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
