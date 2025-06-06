import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/home/setting_screen.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:firebase_auth/firebase_auth.dart';

String firebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case "auth/claims-too-large":
      return "The claims payload provided to setCustomUserClaims() exceeds the maximum allowed size of 1000 bytes.";
    case "auth/email-already-exists":
      return "The provided email is already in use by an existing user. Each user must have a unique email.";
    case "auth/id-token-expired":
      return "The provided Firebase ID token is expired.";
    case "auth/id-token-revoked":
      return "The Firebase ID token has been revoked.";
    case "auth/insufficient-permission":
      return "The credential used to initialize the Admin SDK has insufficient permission to access the requested Authentication resource.";
    case "auth/internal-error":
      return "The Authentication server encountered an unexpected error while trying to process the request.";
    case "auth/invalid-argument":
      return "An invalid argument was provided to an Authentication method.";
    case "auth/invalid-claims":
      return "The custom claim attributes provided to setCustomUserClaims() are invalid.";
    case "auth/invalid-continue-uri":
      return "The continue URL must be a valid URL string.";
    case "auth/invalid-creation-time":
      return "The creation time must be a valid UTC date string.";
    case "auth/invalid-credential":
      return "The credential used to authenticate the Admin SDKs cannot be used to perform the desired action.";
    case "auth/invalid-disabled-field":
      return "The provided value for the disabled user property is invalid. It must be a boolean.";
    case "auth/invalid-display-name":
      return "The provided value for the displayName user property is invalid. It must be a non-empty string.";
    case "auth/invalid-dynamic-link-domain":
      return "The provided dynamic link domain is not configured or authorized for the current project.";
    case "auth/invalid-email":
      return "The provided value for the email user property is invalid. It must be a string email address.";
    case "auth/invalid-email-verified":
      return "The provided value for the emailVerified user property is invalid. It must be a boolean.";
    case "auth/invalid-hash-algorithm":
      return "The hash algorithm must match one of the strings in the list of supported algorithms.";
    case "auth/invalid-hash-block-size":
      return "The hash block size must be a valid number.";
    case "auth/invalid-hash-derived-key-length":
      return "The hash derived key length must be a valid number.";
    case "auth/invalid-hash-key":
      return "The hash key must a valid byte buffer.";
    case "auth/invalid-hash-memory-cost":
      return "The hash memory cost must be a valid number.";
    case "auth/invalid-hash-parallelization":
      return "The hash parallelization must be a valid number.";
    case "auth/invalid-hash-rounds":
      return "The hash rounds must be a valid number.";
    case "auth/invalid-hash-salt-separator":
      return "The hashing algorithm salt separator field must be a valid byte buffer.";
    case "auth/invalid-id-token":
      return "The provided ID token is not a valid Firebase ID token.";
    case "auth/invalid-last-sign-in-time":
      return "The last sign-in time must be a valid UTC date string.";
    case "auth/invalid-page-token":
      return "The provided next page token in listUsers() is invalid. It must be a valid non-empty string.";
    case "auth/invalid-password":
      return "The provided value for the password user property is invalid. It must be a string with at least six characters.";
    case "auth/invalid-password-hash":
      return "The password hash must be a valid byte buffer.";
    case "auth/invalid-password-salt":
      return "The password salt must be a valid byte buffer.";
    case "auth/invalid-phone-number":
      return "The provided value for the phoneNumber is invalid. It must be a non-empty E.164 standard compliant identifier string.";
    case "auth/invalid-photo-url":
      return "The provided value for the photoURL user property is invalid. It must be a string URL.";
    case "auth/invalid-provider-data":
      return "The providerData must be a valid array of UserInfo objects.";
    case "auth/invalid-provider-id":
      return "The providerId must be a valid supported provider identifier string.";
    case "auth/invalid-oauth-responsetype":
      return "Only exactly one OAuth responseType should be set to true.";
    case "auth/invalid-session-cookie-duration":
      return "The session cookie duration must be a valid number in milliseconds between 5 minutes and 2 weeks.";
    case "auth/invalid-uid":
      return "The provided uid must be a non-empty string with at most 128 characters.";
    case "auth/invalid-user-import":
      return "The user record to import is invalid.";
    case "auth/maximum-user-count-exceeded":
      return "The maximum allowed number of users to import has been exceeded.";
    case "auth/missing-android-pkg-name":
      return "An Android Package Name must be provided if the Android App is required to be installed.";
    case "auth/missing-continue-uri":
      return "A valid continue URL must be provided in the request.";
    case "auth/missing-hash-algorithm":
      return "Importing users with password hashes requires that the hashing algorithm and its parameters be provided.";
    case "auth/missing-ios-bundle-id":
      return "The request is missing a Bundle ID.";
    case "auth/missing-uid":
      return "A uid identifier is required for the current operation.";
    case "auth/missing-oauth-client-secret":
      return "The OAuth configuration client secret is required to enable OIDC code flow.";
    case "auth/operation-not-allowed":
      return "The provided sign-in provider is disabled for your Firebase project.";
    case "auth/phone-number-already-exists":
      return "The provided phoneNumber is already in use by an existing user. Each user must have a unique phoneNumber.";
    case "auth/project-not-found":
      return "No Firebase project was found for the credential used to initialize the Admin SDKs.";
    case "auth/reserved-claims":
      return "One or more custom user claims provided to setCustomUserClaims() are reserved.";
    case "auth/session-cookie-expired":
      return "The provided Firebase session cookie is expired.";
    case "auth/session-cookie-revoked":
      return "The Firebase session cookie has been revoked.";
    case "auth/too-many-requests":
      return "The number of requests exceeds the maximum allowed.";
    case "auth/uid-already-exists":
      return "The provided uid is already in use by an existing user.";
    case "auth/unauthorized-continue-uri":
      return "The domain of the continue URL is not whitelisted.";
    case "auth/user-not-found":
      return "There is no existing user record corresponding to the provided identifier.";
    default:
      return e.message ?? e.toString();
  }
}

String getEmployeeAttendenceStatus(
    EmployeeAttendenceStatus employeeAttendenceStatus) {
  switch (employeeAttendenceStatus) {
    case EmployeeAttendenceStatus.present:
      return 'Present';
    case EmployeeAttendenceStatus.absent:
      return 'Absent';
    case EmployeeAttendenceStatus.half:
      return 'Half Day';
    case EmployeeAttendenceStatus.double:
      return 'Double';
    case EmployeeAttendenceStatus.overtime:
      return 'OverTime';
  }
}

String getProfileSettingsTitle(Profilelist profilelist) {
  switch (profilelist) {
    case Profilelist.viewprofile:
      return 'View Profile';
    case Profilelist.termcondition:
      return 'Term and Condition';
    case Profilelist.privacypolicy:
      return 'Privacy Policy';
    // case Profilelist.notification:
    //   return 'Notification';

    case Profilelist.logout:
      return 'Log out';

    case Profilelist.deleteUser:
      return 'Delete User';
  }
}

String getProfileSettingsIcons(Profilelist profilelist) {
  switch (profilelist) {
    case Profilelist.viewprofile:
      return AssetImages.profileIcon;
    // case Profilelist.notification:
    //   return AssetImages.notificationIcon;
    // case Aboutlist.privacy:
    //   return AssetImages.privacyIcon;
    // case Profilelist.leads:
    //   return AssetImages.leadsIcon;
    case Profilelist.logout:
      return AssetImages.logoutIcon;
    case Profilelist.termcondition:
      return AssetImages.profileIcon;
    case Profilelist.privacypolicy:
      return AssetImages.personIcon;
    case Profilelist.deleteUser:
      return AssetImages.delete;
  }
}
