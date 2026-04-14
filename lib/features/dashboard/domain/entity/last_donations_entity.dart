import 'package:equatable/equatable.dart';

class LastDonation extends Equatable {
  final int id;
  final String donorName;
  final double amount;
  final String category;
  final DateTime date;

  const LastDonation({
    required this.id,
    required this.donorName,
    required this.amount,
    required this.category,
    required this.date,
  });

  @override
  List<Object?> get props => [id, donorName, amount, category, date];
}
