import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/top_navbar/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TopNavbar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffE5E7EB))),
      ),
      child: Row(
        children: [
          Text(
            "Donation System",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),

          Gap(40.w),

          NavItem("Dashboard", Routes.dashboard, currentRoute),
          NavItem("Donations", Routes.donations, currentRoute),
          NavItem("Donors", Routes.donors, currentRoute),
          NavItem("Cases", Routes.cases, currentRoute),
          NavItem("Distributions", Routes.distributions, currentRoute),
          NavItem("Categories", Routes.categories, currentRoute),
          NavItem("Employees", Routes.employees, currentRoute),

          const Spacer(),

          TextButton(
            onPressed: () => context.go(Routes.login),
            child: Text("Logout", style: AppTypography.button),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
