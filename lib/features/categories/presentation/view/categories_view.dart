import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/categories_kpis_cards.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/categories_view_body.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: ListView(
          children: [
            Text('Categories Management Center', style: AppTypography.h1),
            Gap(5.h),
            Text(
              'Organize, monitor, and define impact categories for global distribution.',
              style: AppTypography.bodyMedium,
            ),
            Gap(20.h),
            const CategoriesKPIsCards(),
            Gap(20.h),
            const CategoriesViewBody(),
          ],
        ),
      ),
    );
  }
}
