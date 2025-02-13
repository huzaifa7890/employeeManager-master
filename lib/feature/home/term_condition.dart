import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileTermConditionScreen extends ConsumerStatefulWidget {
  const MobileTermConditionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileTermConditionScreenState();
}

class _MobileTermConditionScreenState
    extends ConsumerState<MobileTermConditionScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 25 ),
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
                            'Terms and conditions',
                            style: theme.textTheme.displayLarge!
                                .copyWith(fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text:
                          'Welcome to Invesnetwork. By using our app, you agree to the following terms and conditions:\n\n'
                          'User Accounts: You must provide accurate and complete information when creating an account. You are responsible for maintaining the confidentiality of your account and password.\n\n'
                          'Use of Services: You agree to use Invesnetwork for lawful purposes only. Any fraudulent, abusive, or illegal activity is strictly prohibited.\n\n'
                          'Property Listings: All property listings must be accurate and comply with our guidelines. We reserve the right to remove any listings that violate our policies.\n\n'
                          'Transactions: Invesnetwork facilitates transactions between buyers and sellers but is not responsible for the actual transaction or any disputes that arise.\n\n'
                          'Content Ownership: All content on Invesnetwork, including text, images, and software, is owned by or licensed to us. You may not copy, distribute, or create derivative works without our permission.\n\n'
                          'Objectionable Content: You must not post, upload, or share content that is illegal, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, hateful, or racially, ethnically, or otherwise objectionable. Any user can report your content including properties and chat messages.\n\n'
                          'Enforcement and Termination: We reserve the right to investigate and take appropriate legal action against anyone who violates these terms. This may include removing objectionable content, suspending or terminating your account, and reporting you to law enforcement authorities.\n\n'
                          'No Tolerance Policy: We have a zero-tolerance policy for objectionable content and abusive users. Any violation of these terms will result in immediate action, which may include the suspension or termination of your account without prior notice.\n\n'
                          'Privacy: Your use of Invesnetwork is also governed by our Privacy Policy. Please review it to understand our practices.\n\n'
                          'Termination: We reserve the right to terminate or suspend your account at any time, without notice, for conduct that we believe violates these terms or is harmful to other users.\n\n'
                          'Changes to Terms: We may update these terms periodically. Continued use of Invesnetwork after any changes constitutes your acceptance of the new terms.\n\n',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          'Contact Us: If you have any questions or concerns about these terms, please contact us at ',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: 'asandoval@avatargroups.com\n\n',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textMessageBtnColor,
                          decorationColor: AppColors.textMessageBtnColor,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // url.launchEmail(
                          //     title: 'asandoval@avatargroups.com');
                        },
                    ),
                    TextSpan(
                      text:
                          'By using EmployeeAttendanceManagement, you agree to these terms and conditions. \n',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ])),
                 
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
