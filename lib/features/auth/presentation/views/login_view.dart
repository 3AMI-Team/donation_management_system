import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/core/widgets/custom_button.dart';
import 'package:donation_management_system/core/widgets/custom_text_field.dart';
import 'package:donation_management_system/features/auth/presentation/view_model/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 460.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border),
              ),
              padding: EdgeInsets.all(48.w),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LogoArea(),
                  HeaderCard(),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(40.h),
        Text('Welcome Back!', style: AppTypography.h1),
        Gap(10.h),
        Text(
          'Please enter your credentials to access the',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
        ),
        Gap(5.h),
        Text(
          'donation system.',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}

class LogoArea extends StatelessWidget {
  const LogoArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Donation Logo.png',
          width: 35.w,
          height: 35.h,
        ),
        Gap(5.w),
        Text('Donation MS', style: AppTypography.h2),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go(Routes.dashboard);
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(20.h),
              CustomTextField(
                controller: _usernameController,
                label: 'Username',
                hint: 'Enter your username',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColors.textSecondary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                hint: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textSecondary),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Gap(10.h),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    textAlign: TextAlign.end,
                    'Forgot your password?',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              Gap(20.h),
              CustomButton(
                height: 70.h,
                borderRadius: 16.r,
                text: 'Sign In',
                isLoading: state is LoginLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginCubit>().login(
                          username: _usernameController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
