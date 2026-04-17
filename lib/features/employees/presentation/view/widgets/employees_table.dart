import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_data_row.dart';
import 'package:donation_management_system/features/employees/data/models/employee_table_model.dart';

class EmployeesTable extends StatelessWidget {
  const EmployeesTable({super.key});

  static const List<TableHeader> _headers = [
    TableHeader(text: 'Employee Name', flex: 2),
    TableHeader(text: 'Username', flex: 1),
    TableHeader(text: 'Role', flex: 1),
    TableHeader(text: 'Phone', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: _headers,
      dataRow: const [
        EmployeeTableModel(
          name: 'Sarah Jenkins',
          email: 'sarah.jenkins@donationmgr.com',
          username: '@s.jenkins',
          role: EmployeeRole.admin,
          phone: '(555) 123-4567',
        ),
        EmployeeTableModel(
          name: 'Michael Chen',
          email: 'michael.chen@donationmgr.com',
          username: '@m.chen',
          role: EmployeeRole.staff,
          phone: '(555) 987-6543',
        ),
        EmployeeTableModel(
          name: 'David Miller',
          email: 'david.miller@donationmgr.com',
          username: '@d.miller',
          role: EmployeeRole.fieldWorker,
          phone: '(555) 456-7890',
        ),
        EmployeeTableModel(
          name: 'Jessica Wu',
          email: 'jessica.wu@donationmgr.com',
          username: '@j.wu',
          role: EmployeeRole.staff,
          phone: '(555) 789-0123',
        ),
        EmployeeTableModel(
          name: 'Robert Smith',
          email: 'robert.smith@donationmgr.com',
          username: '@r.smith',
          role: EmployeeRole.fieldWorker,
          phone: '(555) 321-6547',
        ),
      ],
      itemBuilder: (item) => EmployeeDataRow(employee: item),
    );
  }
}

class EmployeeDataRow extends StatelessWidget {
  final EmployeeTableModel employee;

  const EmployeeDataRow({super.key, required this.employee});

  String get _initials {
    final parts = employee.name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return employee.name.isNotEmpty
        ? employee.name.substring(0, 1).toUpperCase()
        : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: AppColors.primary.withOpacity(0.12),
                  child: Text(
                    _initials,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        employee.email,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              employee.username,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _RoleBadge(role: employee.role),
          ),
          Expanded(
            flex: 1,
            child: Text(
              employee.phone,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const ActionsButtons(donor: null,),
        ],
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final EmployeeRole role;

  const _RoleBadge({required this.role});

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color bg;
    late final Color fg;

    switch (role) {
      case EmployeeRole.admin:
        label = 'Admin';
        bg = const Color(0xFFEDE9FE);
        fg = const Color(0xFF5B21B6);
      case EmployeeRole.staff:
        label = 'Staff';
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
      case EmployeeRole.fieldWorker:
        label = 'Field Worker';
        bg = const Color(0xFFFFF4E6);
        fg = const Color(0xFFC2410C);
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      ),
    );
  }
}
