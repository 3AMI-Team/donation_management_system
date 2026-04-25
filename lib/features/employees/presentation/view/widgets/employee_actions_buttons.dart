import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/add_employee_dialog.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeActionsButtons extends StatelessWidget {
  final EmployeeEntity employee;

  const EmployeeActionsButtons({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.textSecondary),
      onSelected: (value) {
        final employeesCubit = context.read<EmployeesCubit>();
        final addEmployeeCubit = context.read<AddEmployeeCubit>();

        switch (value) {
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
                content: 'Are you sure you want to delete ${employee.name}? This action cannot be undone.',
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
