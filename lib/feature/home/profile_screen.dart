import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/auth/providers/user_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileProfileScreen extends ConsumerStatefulWidget {
  const MobileProfileScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileBuyerProfileScreenState();
}

class _MobileBuyerProfileScreenState extends ConsumerState<MobileProfileScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = ref.read(userProvider);
      nameController.text = user?.name ?? '';
      phoneNoController.text = user?.phoneNo ?? '';
      emailController.text = user?.email ?? '';
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(userProvider);
    nameController.text = user?.name ?? '';
    phoneNoController.text = user?.phoneNo ?? '';
    emailController.text = user?.email ?? '';
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: theme.textTheme.displayLarge,
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20.0, left: 24, right: 24, bottom: 24),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.fieldGrey),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: user?.profilePic != null
                                  ? Image.network(
                                      user?.profilePic ?? '',
                                      fit: BoxFit.cover,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        AssetImages.personIcon,
                                        height: 20,
                                        width: 20,
                                        scale: 4,
                                      ),
                                    )),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 0,
                        //   child: IconButtonWidget(
                        //     height: 30,
                        //     width: 30,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(50),
                        //       color: AppColors.appThemeColor,
                        //     ),
                        //     icon: Image.asset(
                        //       AssetImages.edit,
                        //       height: 4,
                        //       width: 4,
                        //       scale: 4,
                        //       color: theme.colorScheme.primary,
                        //     ),
                        //     onPressed: () {
                        //       context.push(AppRoutes.buyerEditProfileScreen);
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(user?.name ?? '', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 30),
                    if (nameController.text.isNotEmpty)
                      AppTextField(
                          height: 65,
                          enabled: false,
                          textController: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          prefixIcon: Image.asset(
                            AssetImages.profileIcon,
                            scale: 3.5,
                            color: theme.colorScheme.inversePrimary,
                          ),
                          fillColor: theme.colorScheme.shadow,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          hintText: 'Jonathan Anderson',
                          hintStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: AppColors.fieldTextcolor),
                          lines: 1),
                    if (phoneNoController.text.isNotEmpty)
                      const SizedBox(
                        height: 29,
                      ),
                    if (phoneNoController.text.isNotEmpty)
                      AppTextField(
                          enabled: false,
                          height: 65,
                          textController: phoneNoController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          prefixIcon: Icon(
                            Icons.call_outlined,
                            size: 20,
                            color: theme.colorScheme.inversePrimary,
                          ),
                          textStyle: theme.textTheme.displayMedium!
                              .copyWith(fontSize: 16),
                          fillColor: theme.colorScheme.shadow,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          hintText: '+62 112-3288-9111 ',
                          hintStyle: theme.textTheme.displayMedium!.copyWith(
                              color: AppColors.fieldTextcolor, fontSize: 16),
                          lines: 1),
                    if (emailController.text.isNotEmpty)
                      const SizedBox(
                        height: 30,
                      ),
                    if (emailController.text.isNotEmpty)
                      AppTextField(
                          enabled: false,
                          height: 65,
                          textController: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            } else if (!value.isValidEmail()) {
                              return '';
                            }
                            return null;
                          },
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: theme.colorScheme.inversePrimary,
                            size: 20,
                          ),
                          fillColor: theme.colorScheme.shadow,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          hintText: 'jonathan@gmail.com',
                          hintStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: AppColors.fieldTextcolor),
                          lines: 1),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),

              // tab == 0
              //     ? const AcceptedOffers()
              //     : tab == 1
              //         ? BuyerPendingTab(
              //             pendingPropertyList: pendingPropertyList,
              //           )
              //         : BuyerRejectedTab(
              //             soldpropertylist: soldPropertyList,
              //           )
            ],
          ),
        ));
  }
}
