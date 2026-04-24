import 'package:donation_management_system/core/network/api/api_consumer.dart';
import 'package:donation_management_system/core/network/api/api_endpoints.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_kpis_entity.dart';

abstract class EmployeesRemoteDataSource {
  Future<void> addEmployee(AddEmployeeParams params);
  Future<void> updateEmployee(int id, AddEmployeeParams params);
  Future<void> deleteEmployee(int id);
  Future<List<EmployeeEntity>> getEmployees();
  Future<EmployeeKpisEntity> getEmployeeKpis();
}

class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  final ApiConsumer api;

  EmployeesRemoteDataSourceImpl({required this.api});

  @override
  Future<void> addEmployee(AddEmployeeParams params) async {
    await api.post(ServerStrings.employees, body: params.toJson());
  }

  @override
  Future<void> updateEmployee(int id, AddEmployeeParams params) async {
    await api.put("${ServerStrings.employees}/$id", body: params.toJson());
  }

  @override
  Future<void> deleteEmployee(int id) async {
    await api.delete("${ServerStrings.employees}/$id");
  }

  @override
  Future<List<EmployeeEntity>> getEmployees() async {
    final response = await api.get(ServerStrings.employees);
    // Assuming response is a List of Maps
    final List<dynamic> data = response;
    return data.map((json) => EmployeeEntity.fromJson(json)).toList();
  }

  @override
  Future<EmployeeKpisEntity> getEmployeeKpis() async {
    final response = await api.get(ServerStrings.employeesKPIs);
    return EmployeeKpisEntity.fromJson(response);
  }
}
