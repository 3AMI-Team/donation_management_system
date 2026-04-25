import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/case_data_row.dart';

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
    return CustomTable<CaseEntity>(
      headerCells: headerCells,
      dataRow: cases,
      sortKeyExtractors: {
        0: (c) => c.id,
        1: (c) => c.name,
        2: (c) => c.categoryName,
        3: (c) => c.registDate,
      },
      itemBuilder: (item) {
        final index = cases.indexOf(item);
        return FadeInUp(
          delay: Duration(milliseconds: index * 50),
          duration: const Duration(milliseconds: 500),
          child: CaseDataRow(caseEntity: item),
        );
      },
    );
  }
}
