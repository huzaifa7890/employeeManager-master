import 'package:employeemanager/core/provider/theme_provider.dart';
import 'package:employeemanager/firebase_options.dart';
import 'package:employeemanager/routes/routes.dart';
import 'package:employeemanager/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final router = AppRouter().router;
  runApp(ProviderScope(child: MyApp(router: router)));
}

class MyApp extends ConsumerWidget {
  final GoRouter router;
  const MyApp({
    super.key,
    required this.router,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Employee Manager',
      theme: themeMode == ThemeMode.light
          ? AppTheme.lightThemeCopy
          : AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.read(themeModeProvider),
      routerConfig: router,
    );
  }
}
