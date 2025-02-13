import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyPage extends ConsumerStatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends ConsumerState<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 16),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Privacy Policy',
                            style: theme.textTheme.displayLarge!
                                .copyWith(fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Employee Attendance Management Privacy Policy\n\n'
                              'This privacy policy applies to the Employee Attendance Management app (hereby referred to as "Application") for mobile devices that was created by Huzaifa (hereby referred to as "Service Provider") as a Free service. This service is intended for use "AS IS".\n\n'
                              'Information Collection and Use\n'
                              'The Application collects information when you download and use it. This information may include information such as:\n\n'
                              '- Your device\'s Internet Protocol address (e.g. IP address)\n'
                              '- The pages of the Application that you visit, the time and date of your visit, the time spent on those pages\n'
                              '- The time spent on the Application\n'
                              '- The operating system you use on your mobile device\n\n'
                              'The Application does not gather precise information about the location of your mobile device.\n\n'
                              'The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices and marketing promotions.\n\n'
                              'For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally identifiable information, including but not limited to name, email, pay, date, address. The information that the Service Provider requests will be retained by them and used as described in this privacy policy.\n\n'
                              'Third Party Access\n'
                              'Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways that are described in this privacy statement.\n\n'
                              'Please note that the Application utilizes third-party services that have their own Privacy Policy about handling data. Below are the links to the Privacy Policy of the third-party service providers used by the Application:\n\n'
                              'Google Play Services\n\n'
                              'The Service Provider may disclose User Provided and Automatically Collected Information:\n\n'
                              '- as required by law, such as to comply with a subpoena, or similar legal process;\n'
                              '- when they believe in good faith that disclosure is necessary to protect their rights, protect your safety or the safety of others, investigate fraud, or respond to a government request;\n'
                              '- with their trusted services providers who work on their behalf, do not have an independent use of the information we disclose to them, and have agreed to adhere to the rules set forth in this privacy statement.\n\n'
                              'Opt-Out Rights\n'
                              'You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.\n\n'
                              'Data Retention Policy\n'
                              'The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If you\'d like them to delete User Provided Data that you have provided via the Application, please contact them at huzaifasgd25@gmail.com and they will respond in a reasonable time.\n\n'
                              'Children\n'
                              'The Service Provider does not use the Application to knowingly solicit data from or market to children under the age of 13.\n\n'
                              'The Application does not address anyone under the age of 13. The Service Provider does not knowingly collect personally identifiable information from children under 13 years of age. In the case the Service Provider discovers that a child under 13 has provided personal information, the Service Provider will immediately delete this from their servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact the Service Provider (huzaifasgd25@gmail.com) so that they will be able to take the necessary actions.\n\n'
                              'Security\n'
                              'The Service Provider is concerned about safeguarding the confidentiality of your information. The Service Provider provides physical, electronic, and procedural safeguards to protect information the Service Provider processes and maintains.\n\n'
                              'Changes\n'
                              'This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to the Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.\n\n'
                              'This privacy policy is effective as of 2025-02-13\n\n'
                              'Your Consent\n'
                              'By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by us.\n\n'
                              'Contact Us\n'
                              'If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at ',
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: 'huzaifasgd25@gmail.com\n\n',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textMessageBtnColor,
                              decorationColor: AppColors.textMessageBtnColor,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // url.launchEmail(
                              //     title: 'huzaifasgd25@gmail.com');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
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
}