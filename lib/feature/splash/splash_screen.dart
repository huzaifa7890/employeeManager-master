import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/models/employee_manager_user.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // @override
  // void initState() {
  // super.initState();
  // final auth = getIt<FirebaseAuth>();
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   if (auth.currentUser != null) {
  //     ref
  //         .read(authProvider.notifier)
  //         .fetchInvestNetworkUser(auth.currentUser?.uid ?? '');
  //     ref.read(authProvider.notifier).saveAuthUser(auth.currentUser);
  //   }
  // });
  // }

  @override
  Widget build(BuildContext context) {
    // final invesNetworkUser = ref.watch(userProvider);
    return FlutterSplashScreen.fadeIn(
      backgroundColor: AppColors.whiteColors,
      childWidget: SizedBox(
        height: 250,
        width: double.infinity,
        child: Image.asset(
          AssetImages.appLogo,
        ),
      ),
      useImmersiveMode: true,
      asyncNavigationCallback: () async {
        final auth = FirebaseAuth.instance;
        EmployeeManagerUser? invesNetworkUser;
        if (auth.currentUser != null) {
          invesNetworkUser = await ref
              .read(authProvider.notifier)
              .fetchInvestNetworkUser(auth.currentUser?.uid ?? '');
          ref.read(authProvider.notifier).saveAuthUser(auth.currentUser);
        }

        if (invesNetworkUser != null && auth.currentUser != null) {
          context.pushReplacement(AppRoutes.mainScreen);
        } else if (invesNetworkUser == null && auth.currentUser != null) {
          context.pushReplacement(AppRoutes.registerProfileScreen);
        } else {
          Future.delayed(const Duration(milliseconds: 2000), () {
            context.pushReplacement(AppRoutes.mainScreen);
          });
        }
      },
    );
  }
}
