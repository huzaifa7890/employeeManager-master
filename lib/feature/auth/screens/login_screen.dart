import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/constant/ui_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
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
    final theme = Theme.of(context);
    final showPassword = ref.watch(showPasswordProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
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
              Center(
                child: Image.asset(AssetImages.appLogo),
              ),
              const SizedBox(height: 37),
              const Center(
                child: Text(
                  'Sign In',
                  // style: theme.textTheme.displayLarge,
                ),
              ),
              const SizedBox(
                height: 66,
              ),
              AppTextField(
                textController: emailController,
                hintText: "Enter Your Email",
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
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
                fillColor: AppColors.fieldGrey,
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
                  fillColor: AppColors.fieldGrey,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.fieldTextcolor),
                  // length: 327,
                  lines: 1),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // context.push(AppRoutes.forgotPasswordScreen);
                    },
                    child: Text(
                      'Forgot password?',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: AppColors.appThemeColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(showPasswordProvider.notifier).state =
                          !showPassword;
                    },
                    child: Text(
                      'Show password',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.appThemeColor),
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
                      true,
                      theme: theme,
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
                child: const Text(
                  'Sign in',
                  // style: theme.textTheme.bodyLarge!
                  //     .copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.textColor),
                        children: [
                      TextSpan(
                          text: 'Register',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push(AppRoutes.registerAccountScreen);
                            },
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.appThemeColor,
                              fontWeight: FontWeight.bold))
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
