import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/custom_table.dart';
import 'package:donation_management_system/core/widgets/table_header.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_data_row.dart';
import 'package:flutter/material.dart';

class DonorsTable extends StatelessWidget {
  final List<DonorEntity> donors;
  final VoidCallback? onMenuPressed;

  const DonorsTable({super.key, required this.donors, this.onMenuPressed});

  final List<TableHeader> headerCells = const [
    TableHeader(text: 'Donor', flex: 2),
    TableHeader(text: 'Phone', flex: 1),
    TableHeader(text: 'Email', flex: 2),
    TableHeader(text: 'Date Joined', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: headerCells,
      dataRow: donors,
      itemBuilder: (item) {
        final index = donors.indexOf(item);
        return FadeInUp(
          delay: Duration(milliseconds: index * 50),
          duration: const Duration(milliseconds: 500),
          child: DonorDataRow(donorEntity: item),
        );
      },
    );
  }
}
