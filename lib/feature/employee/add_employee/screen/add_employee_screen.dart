import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/constant/ui_constant.dart';
import 'package:employeemanager/core/service/image_picker_service.dart';
import 'package:employeemanager/feature/auth/providers/image_provider.dart';
import 'package:employeemanager/feature/auth/providers/user_provider.dart';
import 'package:employeemanager/feature/auth/screens/register_profile_screen.dart';
import 'package:employeemanager/feature/employee/add_employee/provider/add_employee_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddEmployeeScreen extends ConsumerStatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends ConsumerState<AddEmployeeScreen> {
  TextEditingController cnicController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController payController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pickedImage = ref.watch(imagePickerProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          iconTheme: const IconThemeData(color: AppColors.primary),
          title: Text(
            'Add Employee',
            style: theme.textTheme.titleMedium!.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            maxRadius: 60,
                            minRadius: 60,
                            backgroundColor:
                                AppColors.fieldGrey, // Placeholder color
                            child: (pickedImage != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      pickedImage,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    AssetImages.personIcon,
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.contain,
                                  ),
                            // : (pickedImage != null)
                            //     ? ClipRRect(
                            //         borderRadius: BorderRadius.circular(100),
                            //         child: Image.file(
                            //           pickedImage,
                            //           height: 100,
                            //           width: 100,
                            //           scale: 1,
                            //           filterQuality: FilterQuality.medium,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       )
                            //     : Image.asset(
                            //         AssetImages.personIcon,
                            //         height: 55,
                            //         width: 55,
                            //         fit: BoxFit.contain,
                            //       ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.darkBlue),
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  iconSize: 16,
                                  color: AppColors.primary,
                                  onPressed: () {
                                    ref.read(overlayProvider.notifier).state =
                                        true;
                                  },
                                ),
                              ),
                            ),
                          ),

                          /////// click me
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.darkBlue),
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  iconSize: 16,
                                  color: AppColors.primary,
                                  onPressed: () async {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    final imagePickerService =
                                                        ImagePickerService();
                                                    final mediaUrls =
                                                        await imagePickerService
                                                            .imagePicker(
                                                                ImageSource
                                                                    .camera);
                                                    if (mediaUrls != null) {
                                                      ref
                                                          .read(
                                                              imagePickerProvider
                                                                  .notifier)
                                                          .state = mediaUrls;
                                                      context.pop();
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 327,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: AppColors
                                                              .textMessageBtnColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        Text(
                                                          "Take Photo",
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: AppColors
                                                                      .textMessageBtnColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final imagePickerService =
                                                        ImagePickerService();
                                                    final mediaUrls =
                                                        await imagePickerService
                                                            .imagePicker(
                                                                ImageSource
                                                                    .gallery);

                                                    ref
                                                        .read(
                                                            imagePickerProvider
                                                                .notifier)
                                                        .state = mediaUrls;
                                                    context.pop();
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width: 327,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.image_outlined,
                                                          color: AppColors
                                                              .textMessageBtnColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 15),
                                                        Text(
                                                          "Upload From Gallery",
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color: AppColors
                                                                .textMessageBtnColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 40),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      context.pop();
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 327,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                              width: 15),
                                                          Text(
                                                            "Cancel",
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                              color: AppColors
                                                                  .textMessageBtnColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              height: 65,
                              textController: cnicController,
                              fillColor: AppColors.fieldGrey,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Check NIC / Employee";
                                }
                                return null;
                              },
                              hintText: 'NIC / Employee ID',
                              hintStyle: theme.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.fieldTextcolor),
                              lines: 1,
                            ),
                            const SizedBox(height: 20),
                            AppTextField(
                              height: 65,
                              textController: fullNameController,
                              fillColor: AppColors.fieldGrey,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Check Empployee Full Name";
                                }
                                return null;
                              },
                              hintText: 'Full Name',
                              hintStyle: theme.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.fieldTextcolor),
                              lines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    height: 65,
                    textController: designationController,
                    fillColor: AppColors.fieldGrey,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Check Designation";
                      }
                      return null;
                    },
                    hintText: 'Designation',
                    hintStyle: theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.fieldTextcolor),
                    lines: 1,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    height: 65,
                    textController: mobileNoController,
                    keyboardType: TextInputType.number,
                    fillColor: AppColors.fieldGrey,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Check Mobile Number";
                      }
                      return null;
                    },
                    hintText: 'Mobile No',
                    hintStyle: theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.fieldTextcolor),
                    lines: 1,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    height: 65,
                    textController: payController,
                    fillColor: AppColors.fieldGrey,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Check Employee Pay";
                      }
                      return null;
                    },
                    hintText: 'Pay',
                    hintStyle: theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.fieldTextcolor),
                    lines: 1,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    height: 65,
                    textController: addressController,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColors.fieldGrey,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    hintText: 'Address',
                    hintStyle: theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.fieldTextcolor),
                    lines: 1,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    height: 65,
                    textController: detailsController,
                    textInputAction: TextInputAction.done,
                    fillColor: AppColors.fieldGrey,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    hintText: 'Details',
                    hintStyle: theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.fieldTextcolor),
                    lines: 1,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showLoaderDialog(
                          context,
                          true,
                          theme: theme,
                        );

                        final userId = ref.read(userProvider)?.id;

                        final response =
                            ref.read(addEmployeeProvider.notifier).addEmployee(
                                  id: const Uuid().v1(),
                                  userId: userId ?? '',
                                  cnicId: cnicController.text,
                                  fullName: fullNameController.text,
                                  designation: designationController.text,
                                  mobileNo: int.parse(mobileNoController.text),
                                  pay: int.parse(payController.text),
                                  address: addressController.text,
                                  selectedImage: pickedImage,
                                );

                        response.then((value) {
                          if (value.errorMessage.isNotEmpty) {
                            context.showSnackBar(value.errorMessage);
                          } else {
                            context.showSuccessSnackBar("Employee Added");
                            context.pop();
                          }
                        });
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
