import 'package:equatable/equatable.dart';

class LastDistribution extends Equatable {
  final int id;
  final String caseName;
  final double amount;
  final DateTime date;

  const LastDistribution({
    required this.id,
    required this.caseName,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [id, caseName, amount, date];
}
