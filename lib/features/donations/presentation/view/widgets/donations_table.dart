import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/donation_table_row.dart';

class DonationsTable extends StatelessWidget {
  final List<Donation> donations;
  const DonationsTable({super.key, required this.donations});

  static List<TableHeader> get _headers => [
        TableHeader(text: 'Donor', width: 200.w),
        TableHeader(text: 'Amount', width: 140.w),
        TableHeader(text: 'Category', width: 140.w),
        TableHeader(text: 'Date', width: 140.w),
        TableHeader(text: 'Supervisor', width: 150.w),
        const TableHeader(text: 'Status', textAlign: TextAlign.center),
      ];

  @override
  Widget build(BuildContext context) {
    if (donations.isEmpty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: const _EmptyState(),
      );
    }

    return CustomTable<Donation>(
      headerCells: _headers,
      dataRow: donations,
      sortKeyExtractors: {
        0: (d) => d.donorName,
        1: (d) => d.amount,
        2: (d) => d.categoryName,
        3: (d) => d.date,
      },
      itemBuilder: (item) {
        final i = donations.indexOf(item);
        return FadeInUp(
          delay: Duration(milliseconds: i * 50),
          duration: const Duration(milliseconds: 300),
          child: DonationTableRow(donation: item),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.r),
      child: const Center(child: Text('No donations found matching your criteria')),
    );
  }
}
