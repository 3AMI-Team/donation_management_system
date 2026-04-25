import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employees_table.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesViewBody extends StatefulWidget {
  const EmployeesViewBody({super.key});

  @override
  State<EmployeesViewBody> createState() => _EmployeesViewBodyState();
}

class _EmployeesViewBodyState extends State<EmployeesViewBody> {
  final TextEditingController _searchController = TextEditingController();
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    context.read<EmployeesCubit>().getEmployees();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesCubit, EmployeesState>(
      builder: (context, state) {
        if (state is EmployeesLoading || state is EmployeesInitial) {
          return const ShimmerTable(rowCount: 8);
        }

        if (state is EmployeesError) {
          return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
        }

        if (state is EmployeesLoaded) {
          final displayedEmployees = state.currentPageEmployees;
          final totalItems = state.totalCount;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterChips(
                filters: const ['All', 'Admin', 'Supervisor', 'Employee'],
                selectedFilter: state.selectedRole,
                onFilterSelected: (role) {
                  context.read<EmployeesCubit>().filterEmployees(role: role);
                },
                searchController: _searchController,
                onSearchChanged: (query) {
                  context.read<EmployeesCubit>().filterEmployees(query: query);
                },
                hintText: 'Search employees...',
                onSortPressed: () {},
              ),
              Gap(24.h),
              EmployeesTable(employees: displayedEmployees),
              Gap(16.h),
              if (totalItems > 0) ...[
                Pagination(
                  currentPage: state.currentPage,
                  totalItems: totalItems,
                  itemsPerPage: _itemsPerPage,
                  onPreviousPressed: () {
                    context.read<EmployeesCubit>().changePage(state.currentPage - 1);
                  },
                  onNextPressed: () {
                    context.read<EmployeesCubit>().changePage(state.currentPage + 1);
                  },
                ),
              ] else
                const Center(child: Text("No employees found.")),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
