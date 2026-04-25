import 'package:donation_management_system/core/widgets/custom_table.dart';
import 'package:donation_management_system/core/widgets/table_header.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/case_data_row.dart';
import 'package:flutter/material.dart';

class CasesTable extends StatelessWidget {
  final List<CaseEntity> cases;
  
  const CasesTable({super.key, required this.cases});

  final List<TableHeader> headerCells = const [
    TableHeader(text: 'ID', flex: 1),
    TableHeader(text: 'Name', flex: 3),
    TableHeader(text: 'Category', flex: 1),
    TableHeader(text: 'Date', flex: 1),
    TableHeader(text: 'Status', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: headerCells,
      dataRow: cases,
      itemBuilder: (item) => CaseDataRow(caseEntity: item),
    );
  }
}
