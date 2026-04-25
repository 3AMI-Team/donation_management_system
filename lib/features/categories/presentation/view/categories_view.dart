import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/categories_kpis_cards.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/categories_view_body.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:donation_management_system/features/categories/presentation/view/widgets/add_new_category.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoriesBloc>()..add(GetCategoriesEvent()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: ListView(
            children: [
              Builder(builder: (context) {
                return PageHeader(
                  title: 'Categories Management Center',
                  subtitle:
                      'Organize, monitor, and define impact categories for global distribution.',
                  filledButtonText: 'Add New Category',
                  onFilledPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<CategoriesBloc>(),
                        child: const AddCategoryDialog(),
                      ),
                    );
                  },
                );
              }),
              Gap(20.h),
              const CategoriesKPIsCards(),
              Gap(20.h),
              const CategoriesViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}
