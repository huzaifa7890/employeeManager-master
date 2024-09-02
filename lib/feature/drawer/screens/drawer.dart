import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FractionallySizedBox(
      // Use FractionallySizedBox to control width
      widthFactor: 0.5, // Set to 0.5 for half the screen width
      child: Drawer(
        backgroundColor: AppColors.primary,
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('HomePage'),
              onTap: () {
                context.pushReplacementNamed('/');
              },
            ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.payment),
            //   title: const Text('Orders'),
            //   onTap: () {
            //     // Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            //   },
            // ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.edit),
            //   title: const Text('Manage Products'),
            //   onTap: () {
            //     // Navigator.of(context).pushReplacementNamed(UserProduct.routeName);
            //   },
            // ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                ref.read(authProvider.notifier).signOut();
                context.pushReplacement(AppRoutes.mainScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
