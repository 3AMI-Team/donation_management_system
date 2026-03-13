import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_new_case.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/case_view_body.dart';

class CasesView extends StatelessWidget {
  const CasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: ListView(
        children: [
          Text('Cases Management', style: AppTypography.h1),
          Gap(5.h),
          Row(
            children: [
              Text(
                'Manage your donor database, track contributions, and maintain relationships with\nindividuals and corporate partners.',
                style: AppTypography.bodyMedium,
              ),
              const Spacer(),
              const AddNewCase(),
            ],
          ),
          Gap(20.h),
          CasesKPIsCards(),
          Gap(20.h),
          const CasesViewBody(),
        ],
      ),
    );
  }
}

class CasesKPIsCards extends StatelessWidget {
  const CasesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,

      children: [
        KPICard(
          title: 'Total Active Cases',
          value: '1240',
          logo: 'assets/icons/active cases.png',
          icon: Icons.people_alt_outlined,
        ),

        KPICard(
          title: 'Total Pending Cases',
          value: '7',
          logo: 'assets/icons/funds distributed.png',
          icon: Icons.people_alt_outlined,
        ),

        KPICard(
          title: 'Total Donors',
          value: '1,200',
          logo: 'assets/icons/Donors.png',
          icon: Icons.people_outline_outlined,
        ),
        KPICard(
          title: 'Avg. Respons Time',
          value: '4.2h',
          logo: 'assets/icons/funds distributed.png',
          icon: Icons.av_timer,
        ),
      ],
    );
  }
}
