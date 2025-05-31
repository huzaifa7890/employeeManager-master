import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/constant/ui_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterAccountScreen extends ConsumerStatefulWidget {
  const RegisterAccountScreen({super.key});

  @override
  ConsumerState<RegisterAccountScreen> createState() =>
      _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends ConsumerState<RegisterAccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FocusNode fname = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<AuthState>(authProvider.select((value) => value),
    //     (previous, next) {
    //   if (next.navigateToHome) {
    //     context.pushReplacement(AppRoutes.homeScreen);
    //   }
    //   if (next.navigateToProfileScreen) {
    //     final extraData = {
    //       'fromPhoneLogin': false,
    //       'isGoogleLogin': false,
    //     };
    //     context.pushReplacement(AppRoutes.registerProfileScreen,
    //         extra: extraData);
    //   }
    // });
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              RichText(
                text: TextSpan(
                  text: 'Create Account',
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 32,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).center(),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(height: 30),
              AppTextField(
                  height: 65,
                  textController: _emailController,
                  fillColor: AppColors.textFieldBackground,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Valid Emails";
                    } else if (!value.isValidEmail()) {
                      return "Please Enter Valid Emails";
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.primary,
                  ),
                  hintText: 'Email',
                  hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                  textStyle: theme.textTheme.bodyMedium, // length: 327,
                  lines: 1),
              const SizedBox(height: 30),
              AppTextField(
                  obscureText: true,
                  textController: _passwordController,
                  height: 65,
                  fillColor: AppColors.textFieldBackground,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                    color: AppColors.primary,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Valid Password";
                    }
                    return null;
                  },
                  hintText: 'Password',
                  hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                  textStyle: theme.textTheme.bodyMedium, // length: 327,
                  lines: 1),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                  obscureText: true,
                  textController: _confirmPasswordController,
                  height: 65,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  fillColor: AppColors.textFieldBackground,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                    color: AppColors.primary,
                  ),
                  hintText: 'Confirm Password',
                  hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                  textStyle: theme.textTheme.bodyMedium,
                  lines: 1),
              const SizedBox(
                height: 96,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showLoaderDialog(
                      context,
                    );

                    ref.read(authProvider.notifier).savingEmployeeUserAndImage(
                          email: _emailController.text,
                        );
                    final response = ref.read(authProvider.notifier).signupUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                    response.then((response) {
                      if (response.errorMessage.isNotEmpty) {
                        return context.showSnackBar(response.errorMessage);
                      } else {
                        context
                            .pushReplacement(AppRoutes.registerProfileScreen);
                      }
                    });
                  }
                },
                child: Text(
                  'Register',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 85,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
