import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/add_employee_dialog.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employees_kpis_cards.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employees_view_body.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employee_stats_cubit/employee_stats_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AddEmployeeCubit>()),
        BlocProvider(create: (context) => sl<EmployeesCubit>()),
        BlocProvider(create: (context) => sl<EmployeeStatsCubit>()..getEmployeeKpis()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: ListView(
          padding: EdgeInsets.all(24.r),
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Builder(builder: (context) {
                return PageHeader(
                  title: 'Employee Directory',
                  subtitle: 'Manage user roles, access permissions, and team status.',
                  filledButtonText: 'New Employee',
                  onFilledPressed: () {
                    final addCubit = context.read<AddEmployeeCubit>();
                    final empsCubit = context.read<EmployeesCubit>();
                    showDialog(
                      context: context,
                      builder: (dialogContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: addCubit),
                          BlocProvider.value(value: empsCubit),
                        ],
                        child: const AddEmployeeDialog(),
                      ),
                    );
                  },
                );
              }),
            ),
            Gap(24.h),
            const EmployeesKPIsCards(),
            Gap(24.h),
            const EmployeesViewBody(),
          ],
        ),
      ),
    );
  }
}
