import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employee_data_row.dart';

class EmployeesTable extends StatelessWidget {
  final List<EmployeeEntity> employees;

  const EmployeesTable({super.key, required this.employees});

  static const List<TableHeader> _headers = [
    TableHeader(text: 'Employee', flex: 2),
    TableHeader(text: 'Email', flex: 2),
    TableHeader(text: 'Username', flex: 1),
    TableHeader(text: 'Role', flex: 1),
    TableHeader(text: 'Phone', flex: 1),
    TableHeader(text: 'Address', flex: 1),
    TableHeader(text: 'Actions', flex: 1, textAlign: TextAlign.right),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable<EmployeeEntity>(
      headerCells: _headers,
      dataRow: employees,
      sortKeyExtractors: {
        0: (emp) => emp.name,
        2: (emp) => emp.username,
        3: (emp) => emp.role,
      },
      itemBuilder: (item) {
        final index = employees.indexOf(item);
        return FadeInUp(
          delay: Duration(milliseconds: index * 50),
          duration: const Duration(milliseconds: 500),
          child: EmployeeDataRow(employee: item),
        );
      },
    );
  }
}
