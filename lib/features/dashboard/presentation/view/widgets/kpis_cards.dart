import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/dashboard_kpis_entity.dart';

class KPIsCards extends StatelessWidget {
  final DashboardKpis kpis;
  const KPIsCards({super.key, required this.kpis});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        title: 'Total Donations',
        value: kpis.totalDonations.amount.toCompactCurrency(),
        icon: Icons.attach_money_outlined,
        logo: 'assets/icons/mony.png',
        color: const Color(0xFF3B82F6), // Blue
        change: kpis.totalDonations.vsLastMonth
      ),
      (
        title: 'Active Cases',
        value: kpis.activeCases.amount.toString(),
        icon: Icons.people_alt_outlined,
        logo: 'assets/icons/active cases.png',
        color: const Color(0xFFF59E0B), // Orange
        change: kpis.activeCases.vsLastMonth
      ),
      (
        title: 'Total Donors',
        value: kpis.totalDonors.amount.toString(),
        icon: Icons.people_outline_outlined,
        logo: 'assets/icons/Donors.png',
        color: const Color(0xFF8B5CF6), // Purple
        change: kpis.totalDonors.vsLastMonth
      ),
      (
        title: 'Funds Distributed',
        value: kpis.fundsDistributed.amount.toCompactCurrency(),
        icon: Icons.attach_money_outlined,
        logo: 'assets/icons/funds distributed.png',
        color: const Color(0xFF10B981), // Green
        change: kpis.fundsDistributed.vsLastMonth
      ),
    ];

    return Row(
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < items.length - 1 ? 16.w : 0),
            child: FadeInUp(
              delay: Duration(milliseconds: index * 100),
              duration: const Duration(milliseconds: 500),
              child: StatCard(
                title: item.title,
                value: item.value,
                icon: item.icon,
                iconColor: item.color,
                logo: item.logo,
                percentageChange: item.change,
              ),
            ),
          ),
        );
      }),
    );
  }
}
