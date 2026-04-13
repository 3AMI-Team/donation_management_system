import 'package:donation_management_system/features/auth/presentation/views/login_view.dart';
import 'package:donation_management_system/features/auth/presentation/views/splash_view.dart';
import 'package:donation_management_system/features/cases/presentation/view/cases_view.dart';
import 'package:donation_management_system/features/categories/presentation/view/categories_view.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:donation_management_system/features/distributions/presentation/view/distribution_view.dart';
import 'package:donation_management_system/features/donations/presentation/view/donations_view.dart';
import 'package:donation_management_system/features/donors/presentation/view/donors_view.dart';
import 'package:donation_management_system/features/employees/presentation/view/employees_view.dart';
import 'package:donation_management_system/top_navbar/widgets/main_layout.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      // Splash
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashView(),
      ),

      // Login
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginView(),
      ),

      // For Top Navbar
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.dashboard,
            builder: (context, state) => const DashboardView(),
          ),
          GoRoute(
            path: Routes.donations,
            builder: (context, state) => const DonationsView(),
          ),
          GoRoute(
            path: Routes.donors,
            builder: (context, state) => const DonorsView(),
          ),
          GoRoute(
            path: Routes.cases,
            builder: (context, state) => const CasesView(),
          ),
          GoRoute(
            path: Routes.distributions,
            builder: (context, state) => const DistributionView(),
          ),
          GoRoute(
            path: Routes.categories,
            builder: (context, state) => const CategoriesView(),
          ),
          GoRoute(
            path: Routes.employees,
            builder: (context, state) => const EmployeesView(),
          ),
        ],
      ),
    ],
  );
}
