import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/features/auth/domain/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    // Wait for a bit to show logo/animation
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if user is logged in
    final bool loggedIn = await sl<AuthRepo>().isLoggedIn();
    
    if (mounted) {
      if (loggedIn) {
        context.go(Routes.dashboard);
      } else {
        context.go(Routes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using placeholder for logo as I don't see exact path for main logo
             Image.asset(
              'assets/images/Donation Logo.png',
              width: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
