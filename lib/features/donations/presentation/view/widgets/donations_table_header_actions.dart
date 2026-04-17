import 'package:donation_management_system/features/donations/presentation/view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DonationsTableHeaderActions extends StatelessWidget {
  const DonationsTableHeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: 'Donations Tracking',
      subtitle: 'Monitor and manage all donations in one place',
      outlinedButtonText: 'Export CSV',
      filledButtonText: 'New Donation',
      onOutlinedPressed: () {},
      onFilledPressed: () {},
    );
  }
}
