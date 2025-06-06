import 'package:employeemanager/constant/navigation_service.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/auth/screens/login_screen.dart';
import 'package:employeemanager/feature/auth/screens/register_account_screen.dart';
import 'package:employeemanager/feature/auth/screens/register_profile_screen.dart';
import 'package:employeemanager/feature/home/home_screen.dart';
import 'package:employeemanager/feature/home/privacy_policy.dart';
import 'package:employeemanager/feature/home/profile_screen.dart';
import 'package:employeemanager/feature/home/setting_screen.dart';
import 'package:employeemanager/feature/home/term_condition.dart';
import 'package:employeemanager/feature/splash/splash_screen.dart';
import 'package:employeemanager/feature/welcome/screen/welcome_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;
  AppRouter() {
    router = GoRouter(
      navigatorKey: NavigationService.navigatorKey,
      initialLocation: AppRoutes.splashScreen,
      routes: [
        GoRoute(
          path: AppRoutes.mainScreen,
          builder: (context, state) {
            final firebaseuser = FirebaseAuth.instance;
            final isLoggedIn = firebaseuser.currentUser != null;
            return isLoggedIn ? const HomeScreen() : const WelcomeScreens();
          },
        ),
        GoRoute(
          path: AppRoutes.splashScreen,
          builder: ((context, state) => const SplashScreen()),
        ),
        GoRoute(
          path: AppRoutes.loginScreen,
          builder: ((context, state) => const LoginScreen()),
        ),
        GoRoute(
          path: AppRoutes.homeScreen,
          builder: ((context, state) => const HomeScreen()),
        ),
        GoRoute(
          path: AppRoutes.welcomeScreen,
          builder: ((context, state) => const WelcomeScreens()),
        ),
        GoRoute(
          path: AppRoutes.registerProfileScreen,
          builder: ((context, state) => const RegisterProfileAccountScreen()),
        ),
        GoRoute(
          path: AppRoutes.registerAccountScreen,
          builder: ((context, state) => const RegisterAccountScreen()),
        ),
        GoRoute(
          path: AppRoutes.settingScreen,
          builder: ((context, state) => const MobileSettingScreen()),
        ),
        GoRoute(
          path: AppRoutes.termConditionPage,
          builder: ((context, state) => const MobileTermConditionScreen()),
        ),
        GoRoute(
          path: AppRoutes.privacyPolicyPage,
          builder: ((context, state) => const PrivacyPolicyPage()),
        ),
        GoRoute(
          path: AppRoutes.profileScreen,
          builder: ((context, state) => const MobileProfileScreen()),
        ),
      ],
    );
  }
}
