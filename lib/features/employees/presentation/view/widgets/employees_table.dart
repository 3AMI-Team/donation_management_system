import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/add_new_employee.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return CustomTable(
      headerCells: _headers,
      dataRow: employees,
      itemBuilder: (item) => EmployeeDataRow(employee: item),
    );
  }
}

class EmployeeDataRow extends StatelessWidget {
  final EmployeeEntity employee;

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
          // Employee Name column
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.12),
                  child: Text(
                    _initials,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    employee.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Email column
          Expanded(
            flex: 2,
            child: Text(
              employee.email,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Username column
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

          Expanded(flex: 1, child: _RoleBadge(role: employee.role)),

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

          Expanded(
            flex: 1,
            child: Text(
              employee.address,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: _EmployeeActions(employee: employee),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmployeeActions extends StatelessWidget {
  final EmployeeEntity employee;

  const _EmployeeActions({required this.employee});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.textSecondary),
      onSelected: (value) {
        final employeesCubit = context.read<EmployeesCubit>();
        final addEmployeeCubit = context.read<AddEmployeeCubit>();

        switch (value) {
          case 'view':
            // TODO: Implement view details
            break;
          case 'edit':
            showDialog(
              context: context,
              builder: (dialogContext) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: addEmployeeCubit),
                    BlocProvider.value(value: employeesCubit),
                  ],
                  child: AddEmployeeDialog(employee: employee),
                );
              },
            );
            break;
          case 'delete':
            showDialog(
              context: context,
              builder: (dialogContext) => DeleteConfirmationDialog(
                title: 'Delete Employee',
                content:
                    'Are you sure you want to delete ${employee.name}? This action cannot be undone.',
                onDeletePressed: () {
                  employeesCubit.deleteEmployee(employee.id);
                },
              ),
            );
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'view',
          child: Row(
            children: [
              Icon(Icons.visibility_outlined, size: 18),
              Gap(8),
              Text('View Details'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 18),
              Gap(8),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 18, color: Colors.red),
              Gap(8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String role;

  const _RoleBadge({required this.role});

  @override
  Widget build(BuildContext context) {
    String label = role;
    Color bg;
    Color fg;

    switch (role.toLowerCase()) {
      case 'admin':
        bg = const Color(0xFFEDE9FE);
        fg = const Color(0xFF5B21B6);
        break;
      case 'supervisor':
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        break;
      case 'employee':
      case 'field worker':
      case 'staff':
      default:
        bg = const Color(0xFFFFF4E6);
        fg = const Color(0xFFC2410C);
        break;
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
