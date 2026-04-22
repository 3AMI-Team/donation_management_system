import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/domain/use_case/get_employees_use_case.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final GetEmployeesUseCase getEmployeesUseCase;
  static const int _pageSize = 10;
  
  List<EmployeeEntity> _allEmployees = [];

  EmployeesCubit({required this.getEmployeesUseCase}) : super(EmployeesInitial());

  Future<void> getEmployees() async {
    emit(EmployeesLoading());
    final result = await getEmployeesUseCase();
    result.fold(
      (failure) => emit(EmployeesError(message: failure.message)),
      (employees) {
        _allEmployees = employees;
        _emitFilteredState(role: 'All', query: '', page: 1);
      },
    );
  }

  void filterEmployees({String? role, String? query}) {
    if (state is EmployeesLoaded) {
      final currentState = state as EmployeesLoaded;
      _emitFilteredState(
        role: role ?? currentState.selectedRole,
        query: query ?? currentState.searchQuery,
        page: 1, // Reset to page 1 on filter/search change
      );
    }
  }

  void changePage(int page) {
    if (state is EmployeesLoaded) {
      final currentState = state as EmployeesLoaded;
      if (page < 1 || page > currentState.totalPages) return;

      emit(EmployeesLoaded(
        masterEmployees: currentState.masterEmployees,
        filteredEmployees: currentState.filteredEmployees,
        currentPageEmployees: _getSlicedEmployees(currentState.filteredEmployees, page),
        currentPage: page,
        totalPages: currentState.totalPages,
        totalCount: currentState.totalCount,
        selectedRole: currentState.selectedRole,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _emitFilteredState({required String role, required String query, required int page}) {
    List<EmployeeEntity> filtered = _allEmployees;

    // 1. Apply role filter
    if (role != 'All') {
      filtered = filtered.where((emp) => emp.role == role).toList();
    }

    // 2. Apply search query
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((emp) {
        return emp.name.toLowerCase().contains(q) ||
               emp.email.toLowerCase().contains(q) ||
               emp.username.toLowerCase().contains(q);
      }).toList();
    }

    // 3. Pagination math
    final totalCount = filtered.length;
    final totalPages = (totalCount / _pageSize).ceil().clamp(1, 9999);

    emit(EmployeesLoaded(
      masterEmployees: _allEmployees,
      filteredEmployees: filtered,
      currentPageEmployees: _getSlicedEmployees(filtered, page),
      currentPage: page,
      totalPages: totalPages,
      totalCount: totalCount,
      selectedRole: role,
      searchQuery: query,
    ));
  }

  List<EmployeeEntity> _getSlicedEmployees(List<EmployeeEntity> source, int page) {
    final start = (page - 1) * _pageSize;
    final end = (start + _pageSize).clamp(0, source.length);
    if (start >= source.length) return [];
    return source.sublist(start, end);
  }
}
