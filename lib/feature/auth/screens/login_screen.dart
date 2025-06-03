import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/constant/ui_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/widgets/app_logo_button_widget.dart';
import 'package:employeemanager/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final showPasswordProvider = StateProvider<bool>((ref) => true);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider.select((value) => value), (prev, next) {
      if (next.navigateToHome) {
        context.pop();
        context.push(AppRoutes.mainScreen);
      }
      if (next.navigateToRegisterScreen) {
        final extraData = {
          'fromPhoneLogin': false,
          'isGoogleLogin': next.googleLogin,
        };
        context.pop();
        context.push(AppRoutes.registerProfileScreen, extra: extraData);
      }
    });
    final theme = Theme.of(context);
    final showPassword = ref.watch(showPasswordProvider);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 69,
              ),
              // Center(
              //   child: Image.asset(AssetImages.appLogo),
              // ),
              const SizedBox(height: 37),
              Center(
                child: Text(
                  'Sign In',
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              AppTextField(
                textController: emailController,
                hintText: "Enter Your Email",
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                textStyle: theme.textTheme.bodyMedium,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.primary,
                ),
                hintStyle: theme.textTheme.bodyMedium,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Valid Emails";
                  } else if (!value.isValidEmail()) {
                    return "Please Enter Valid Emails";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                  textController: passwordController,
                  obscureText: showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Valid Password";
                    }
                    return null;
                  },
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  textStyle: theme.textTheme.bodyMedium,
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                    color: AppColors.primary,
                  ),
                  hintText: 'Password',
                  hintStyle: theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.primary),
                  // length: 327,
                  lines: 1),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     // context.push(AppRoutes.forgotPasswordScreen);
                  //   },
                  //   child: Text(
                  //     'Forgot password?',
                  //     style: theme.textTheme.bodyMedium!.copyWith(),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () {
                      ref.read(showPasswordProvider.notifier).state =
                          !showPassword;
                    },
                    child: Text(
                      'Show password',
                      style: theme.textTheme.bodyMedium?.copyWith(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showLoaderDialog(
                      context,
                    );
                    final response = ref.read(authProvider.notifier).loginUser(
                        emailController.text, passwordController.text);
                    response.then((response) {
                      if (response.errorMessage.isNotEmpty) {
                        return context.showSnackBar(response.errorMessage);
                      } else {
                        context.pushReplacement(AppRoutes.homeScreen);
                      }
                    });
                  }
                },
                child: Text(
                  'Login',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogoButton(
                    imagePath: AssetImages.googleLogo,
                    onPressed: () {
                      showLoaderDialog(
                        context,
                      );
                      final response =
                          ref.read(authProvider.notifier).loginWithGoogle();
                      response.then((response) {
                        if (response.errorMessage.isNotEmpty) {
                          return context.showSnackBar(response.errorMessage);
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 42,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: theme.textTheme.bodyMedium!.copyWith(),
                        children: [
                      TextSpan(
                          text: 'Register',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push(AppRoutes.registerAccountScreen);
                            },
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold))
                    ])),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
