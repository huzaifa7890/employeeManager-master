import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/feature/auth/providers/phone_no_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/widgets/app_text_field.dart';
import 'package:flutter/foundation.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneNumberWidget extends StatefulWidget {
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;

  const PhoneNumberWidget({
    super.key,
    required this.phoneNumberController,
    required this.formKey,
  });

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await init();
    });
  }

  String countryCode = 'PK';
  String countryDialCode = '+92';
  CountryWithPhoneCode? selectedCountry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          margin: const EdgeInsets.only(right: 2, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: [
              CountryCodePicker(
                padding: EdgeInsets.zero,
                dialogBackgroundColor: AppColors.secondary,
                textStyle: theme.textTheme.bodyMedium,
                dialogTextStyle: theme.textTheme.bodyMedium,
                searchStyle: theme.textTheme.bodyMedium,
                searchDecoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: theme.textTheme.bodyMedium,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary),
                  ),
                ),
                builder: (countryCode) {
                  return Row(
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 28,
                        width: 28,
                        child: Image.asset(
                          countryCode?.flagUri ?? '',
                          package: 'country_code_picker',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        countryCode?.dialCode ?? '',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  );
                },
                initialSelection: 'US',
                barrierColor: Colors.transparent,
                onChanged: (value) {
                  countryDialCode = value.dialCode ?? '';
                  countryCode = value.code ?? '';
                },
                onInit: (value) {
                  Future.delayed(const Duration(seconds: 1), () {
                    countryDialCode = value?.dialCode ?? '';
                    countryCode = value?.code ?? '';
                  });
                },
              ),
              const SizedBox(
                width: 8,
              ),
              const SizedBox(
                height: 29,
                child: VerticalDivider(
                  width: 1,
                  thickness: 1,
                  // color: widget.themeData.brightness == Brightness.light
                  //     ? appTheme.gray200
                  //     : Color(0xff3f467c),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 5),
                  child: Consumer(
                    builder: (context, ref, child) {
                      return AppTextField(
                        textController: widget.phoneNumberController,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                        lines: 1,
                        inputFormatters: [
                          selectedCountry != null
                              ? LibPhonenumberTextFormatter(
                                  country: selectedCountry!)
                              : FilteringTextInputFormatter.digitsOnly,
                        ],
                        fillColor: AppColors.secondary,
                        hintText: "Enter Your Phone Number",
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onChanged: (value) async {
                          Future.delayed(const Duration(seconds: 2));
                          debugPrint("Phone Number: $value");
                          final index = CountryManager().countries.indexWhere(
                              (element) => element.countryCode == countryCode);
                          selectedCountry = CountryManager().countries[index];
                          final res = await format(
                            widget.phoneNumberController.text,
                            selectedCountry?.countryCode ?? 'US',
                          );
                          debugPrint(
                              "Res formatted value: ${res['formatted']}");
                          if (!kIsWeb) {
                            setState(
                              () => widget.phoneNumberController.text =
                                  res['formatted'] ?? '',
                            );
                          }
                          final phoneNumber = widget.phoneNumberController.text;
                          final result = await getFormattedParseResult(
                              phoneNumber, selectedCountry!);
                          if (result != null) {
                            ref.read(phoneNoProvider.notifier).state =
                                result.e164;
                          } else {
                            final phoneNumber = countryDialCode +
                                widget.phoneNumberController.text
                                    .removeSpacesAndDashes();
                            ref.read(phoneNoProvider.notifier).state =
                                phoneNumber;
                          }
                          debugPrint(
                              "Phone Number after parsing result: ${result?.formattedNumber ?? result?.e164 ?? "None"}");
                        },
                        onEditingComplete: () async {
                          final phoneNumber = widget.phoneNumberController.text;
                          if (phoneNumber.isNotEmpty) {
                            final result = await getFormattedParseResult(
                                phoneNumber, selectedCountry!);
                            if (result != null) {
                              ref.read(phoneNoProvider.notifier).state =
                                  result.e164;
                            } else {
                              final phoneNumber = countryDialCode +
                                  widget.phoneNumberController.text
                                      .removeSpacesAndDashes();
                              ref.read(phoneNoProvider.notifier).state =
                                  phoneNumber;
                            }
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
