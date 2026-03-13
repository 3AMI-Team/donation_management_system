import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/data/models/case_model.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/case_data_row.dart';

class CasesTable extends StatelessWidget {
  const CasesTable({super.key});

  final List<TableHeader> headerCells = const [
    TableHeader(text: 'Case', flex: 2),
    TableHeader(text: 'Category', flex: 1),
    TableHeader(text: 'Contact Info', flex: 2),
    TableHeader(text: 'Date Joined', flex: 1),
    TableHeader(text: 'Status', flex: 1),
    TableHeader(text: 'Address', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: headerCells,
      dataRow: List.generate(
        5,
        (index) => CaseModel(
          id: index + 1,
          name: 'Person ${index + 1}',
          phone: '010${index + 1000000}',
          email: 'person${index + 1}@example.com',
          registDate: DateTime.now().subtract(Duration(days: index * 2)),
          description: 'Description for case ${index + 1}',
          address: 'Address ${index + 1}',
          category: 'Category ${index % 3 + 1}',
          status: index % 2 == 0 ? 'Open' : 'Closed',
        ),
      ),
      itemBuilder: (item) => CaseDataRow(caseModel: item),
    );
  }
}
