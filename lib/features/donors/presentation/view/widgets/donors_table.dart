import 'package:donation_management_system/core/utils/constants.dart';
import 'package:donation_management_system/core/widgets/custom_table.dart';
import 'package:donation_management_system/core/widgets/table_header.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_data_row.dart';
import 'package:flutter/material.dart';



class DonorsTable extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  final List<TableHeader> headerCells = const [
    TableHeader(text: 'Donor', flex: 2),
    TableHeader(text: 'Phone', flex: 1),
    TableHeader(text: 'Email', flex: 2),
    TableHeader(text: 'Date Joined', flex: 1),
    TableHeader(text: 'Type', flex: 1),
    TableHeader(text: 'Address', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  const DonorsTable({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: AppConstants.donorHeader,
      dataRow: AppConstants.sampleDonors,
      itemBuilder: (item) => DonorDataRow(donor: item),
    );
  }
}
