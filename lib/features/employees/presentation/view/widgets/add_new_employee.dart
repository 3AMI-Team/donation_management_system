import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/add_employee_dialog.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewEmployee extends StatelessWidget {
  const AddNewEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add New Employee",
      onTap: () {
        final addEmployeeCubit = context.read<AddEmployeeCubit>();
        final employeesCubit = context.read<EmployeesCubit>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: addEmployeeCubit),
                BlocProvider.value(value: employeesCubit),
              ],
              child: const AddEmployeeDialog(),
            );
          },
        );
      },
    );
  }
}
