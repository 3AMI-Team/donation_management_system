import 'package:donation_management_system/core/utils/use_case.dart';
import 'package:donation_management_system/features/cases/domain/use_case/get_cases_use_case.dart';
import 'package:donation_management_system/features/donations/domain/use_case/get_donations_use_case.dart';
import 'package:donation_management_system/features/employees/domain/use_case/get_employees_use_case.dart';
import 'package:donation_management_system/features/distributions/domain/use_case/add_distribution_use_case.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDistributionCubit extends Cubit<AddDistributionState> {
  final AddDistributionUseCase addDistributionUseCase;
  final GetCasesUseCase getCasesUseCase;
  final GetDonationsUseCase getDonationsUseCase;
  final GetEmployeesUseCase getEmployeesUseCase;

  AddDistributionCubit({
    required this.addDistributionUseCase,
    required this.getCasesUseCase,
    required this.getDonationsUseCase,
    required this.getEmployeesUseCase,
  }) : super(const AddDistributionInitial());

  Future<void> fetchDependencies() async {
    emit(const DependenciesLoading());

    final casesResult = await getCasesUseCase(NoParams());
    final donationsResult =
        await getDonationsUseCase(const GetDonationsParams());
    final employeesResult = await getEmployeesUseCase();

    casesResult.fold(
      (failure) => emit(DependenciesError(message: failure.message)),
      (casesResponse) {
        donationsResult.fold(
          (failure) => emit(DependenciesError(message: failure.message)),
          (donationsResponse) {
            employeesResult.fold(
              (failure) => emit(DependenciesError(message: failure.message)),
              (employees) => emit(DependenciesLoaded(
                cases: casesResponse.items,
                donations: donationsResponse.donations,
                employees: employees,
              )),
            );
          },
        );
      },
    );
  }

  Future<void> addDistribution(Map<String, dynamic> distributionData) async {
    final currentCases = state.cases;
    final currentDonations = state.donations;
    final currentEmployees = state.employees;

    emit(AddDistributionLoading(
      cases: currentCases,
      donations: currentDonations,
      employees: currentEmployees,
    ));

    final result = await addDistributionUseCase(distributionData);
    
    result.fold(
      (failure) => emit(AddDistributionError(
        message: failure.message,
        cases: currentCases,
        donations: currentDonations,
        employees: currentEmployees,
      )),
      (_) => emit(AddDistributionSuccess(
        cases: currentCases,
        donations: currentDonations,
        employees: currentEmployees,
      )),
    );
  }
}
