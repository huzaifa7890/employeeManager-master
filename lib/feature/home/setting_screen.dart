import 'package:employeemanager/constant/data_constant.dart';
import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum Profilelist {
  viewprofile,
  termcondition,
  privacypolicy,
  logout,
  deleteUser
}

class MobileSettingScreen extends ConsumerStatefulWidget {
  const MobileSettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SellerSettingScreenState();
}

class _SellerSettingScreenState extends ConsumerState<MobileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 24),
            //   child: AppIconButton(
            //     onPressed: () {},
            //     icon: Icons.arrow_back_ios,
            //   ),
            // ),
            const SizedBox(
              height: 37,
            ),
            Text('Settings', style: theme.textTheme.displayLarge),
            const SizedBox(
              height: 37,
            ),
            Text(
              'Manage User',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: Profilelist.values.map(
                    (item) {
                      return InkWell(
                        onTap: () async {
                          if (item == Profilelist.viewprofile) {
                            context.push(AppRoutes.profileScreen);
                          } else if (item == Profilelist.logout) {
                            await ref.read(authProvider.notifier).signOut();
                            context.go(AppRoutes.loginScreen);
                          } else if (item == Profilelist.deleteUser) {
                            _showDeleteConfirmationDialog(context);
                          } else if (item == Profilelist.privacypolicy) {
                            context.push(AppRoutes.privacyPolicyPage);
                          } else if (item == Profilelist.termcondition) {
                            context.push(AppRoutes.termConditionPage);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                getProfileSettingsIcons(item),
                                height: 15,
                                width: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  getProfileSettingsTitle(item),
                                  style: theme.textTheme.bodyMedium,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          title: Text(
            "Delete Account",
            style: context.theme.textTheme.bodyLarge,
          ),
          content: const Text(
              "Are you sure you want to delete your account? This action can't be undone."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).deleteUser();
                ref.read(authProvider.notifier).signOut();
                Future.delayed(Duration.zero, () {
                  context.pop();
                  context.go(AppRoutes.loginScreen);
                });
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
