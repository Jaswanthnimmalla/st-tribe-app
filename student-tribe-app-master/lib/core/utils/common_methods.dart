import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/data/models/user.dart';
import 'package:architecture/core/routes/router.dart';
import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:html/parser.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'loader.dart';

// ignore: constant_identifier_names
enum ScreenType { EVENT, GROUPBYIN, STCOINS }

String? capitalizeFirstLetter(String? input) {
  if (input == null || input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

String? lowercaseFirstLetter(String? input) {
  if (input == null || input.isEmpty) {
    return input;
  }
  return input[0].toLowerCase() + input.substring(1);
}

void showOverlayLoader(BuildContext context) {
  GetIt.instance<Loader>().showLoader(context);
}

void hideOverlayLoader(BuildContext context) {
  debugPrint("Hiding Loader");
  GetIt.instance<Loader>().hideLoader(context);
}

void showSnackbar(context, String message) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
  ).show(context);
}

void showErrorSnackbar(context, String message) {
  var title = "Error";
  if (message.isEmpty) return;
  Flushbar(
    title: title,
    backgroundColor: Colors.red,
    message: message,
    duration: const Duration(seconds: 3),
  ).show(context);
}

void showSuccessSnackbar(context, message) {
  var title = "Success";
  Flushbar(
    title: title,
    backgroundColor: Colors.green,
    message: message,
    duration: const Duration(seconds: 3),
  ).show(context);
}

String getPathParamsFromUrl(String uri, Map<String, dynamic> data) {
  List<String> subStrings = uri.split("/");
  var paramIndex = subStrings.indexWhere((element) => element.startsWith(":"));
  subStrings[paramIndex] = data[subStrings[paramIndex].substring(1)].toString();
  return subStrings.join("/");
}

double calculateSizeInMb(sizeInBytes) => sizeInBytes / (1024 * 1024);

String formattedCurrency(num data) =>
    NumberFormat.currency(symbol: "₹").format(data);

DateTime? dateTimeFromString(String? dateTime) {
  return dateTime == null ? null : DateTime.parse(dateTime);
}

DateTime mandatoryDateTimeFromString(String dateTime) {
  return DateTime.parse(dateTime);
}

String parsedHtmlString(String input) {
  return parse(input).body?.text ?? '';
}

String formatDateTimeToMonthYear(DateTime? dateTime) {
  return dateTime == null ? "Present" : DateFormat("MMM yyyy").format(dateTime);
}

String formatDateTimeToDayMonthYear(DateTime? dateTime) {
  return dateTime == null ? "" : DateFormat("dd MMM yyyy").format(dateTime);
}

String formatDateTimeRange(String startDate, String endDate) {
  // Parse the input strings into DateTime objects
  DateTime startDateTime = DateTime.parse(startDate).toLocal();
  DateTime endDateTime = DateTime.parse(endDate).toLocal();

  // Define date and time formatters
  final dateFormatter = DateFormat('d MMM');
  final timeFormatter = DateFormat('h:mm a');

  // Format the date and time components
  String startDayMonth = dateFormatter.format(startDateTime);
  String endDayMonth = dateFormatter.format(endDateTime);
  String startTime = timeFormatter.format(startDateTime);
  String endTime = timeFormatter.format(endDateTime);

  // Build the formatted string
  String formattedString =
      '$startDayMonth - $endDayMonth | $startTime - $endTime';

  return formattedString;
}

List<String> commonEmailDomains = [
  'gmail.com',
  'yahoo.com',
  'outlook.com',
  'hotmail.com',
  'aol.com',
  'icloud.com',
  'protonmail.com',
  'yandex.com',
  'mail.com',
  'zoho.com',
  'gmx.com',
  'fastmail.com',
  'live.com',
  'me.com',
  'qq.com',
  '163.com',
  'rediffmail.com',
  'indiatimes.com',
  'rocketmail.com',
  'inbox.com',
  'yopmail.com',
];

Future<void> showSuccessMessage(
  BuildContext context, {
  String message = "Action Successful!",
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
          LottieBuilder.asset("assets/json/success.json", repeat: false),
          const Vspace(12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTheme.bodyText1.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}

void showUpdateDialog(bool isForced, String updateTitle, String updateMessage) {
  BuildContext? context = GetIt.I<AppRouter>().navigatorKey.currentContext;
  if (context == null) return;
  showDialog(
    context: context,
    barrierDismissible: !isForced,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        return !isForced;
      },
      child: AlertDialog(
        title: Text(updateTitle),
        content: Text(updateMessage),
        actions: [
          if (!isForced)
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              child: const Text("Cancel"),
            ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                launchUrlString(
                  "https://play.google.com/store/apps/details?id=com.tdevelopers.stumagz",
                );
              } else {
                launchUrlString(
                  "https://apps.apple.com/us/app/student-tribe/id1362552730",
                );
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    ),
  );
}

extension on StackRouter {
  void pop() {}
}

class SocialLoginContainer extends StatelessWidget {
  const SocialLoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(SignInWithGoogleEvent());
          },
          child: SocialSignInButton(AppImages.google),
        ),
        const Hspace(12),
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(SignInWithAppleEvent());
          },
          child: SocialSignInButton(AppImages.apple, padding: 10),
        ),
      ],
    );
  }
}

class SocialSignInButton extends StatelessWidget {
  final String assetName;
  final double padding;

  const SocialSignInButton(this.assetName, {this.padding = 12, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(assetName),
    );
  }
}

class EmptyPageGraphic extends StatelessWidget {
  final String message;
  const EmptyPageGraphic({
    this.message = "No data found!\nPlease check back later!",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset("assets/svg/no-content.svg", width: 250),
            const Vspace(24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

//! generate link method

Future<String> generateLink(
  BuildContext context,
  BranchUniversalObject buo,
  BranchLinkProperties lp,
  bool shareRequired,
) async {
  BranchResponse response = await FlutterBranchSdk.getShortUrl(
    buo: buo,
    linkProperties: lp,
  );
  if (response.success) {
    if (context.mounted) {
      print(response.result);
      hideOverlayLoader(context);
      if (shareRequired) {
        Share.share(response.result);
        return response.result;
      }
    }
    return response.result;
  } else {
    hideOverlayLoader(context);
    print(
      "  message: 'Error : ${response.errorCode} - ${response.errorMessage}'",
    );
    return "";
  }
}

bool checkIfProfileCompleted(UserModel? user) {
  if (user == null) {
    return false;
  }
  if (user.number == null || user.number!.isEmpty) {
    return false;
  }

  return true;
}

String commonProfileError =
    "Please Enter the Basic details of Name, Email & Mobile Number to Apply for Internships/Events”";

bool isDateExpired(String? date) {
  if (date == null || date.isEmpty) {
    return false;
  }
  DateTime parsedDate = DateTime.parse(date);
  return parsedDate.isBefore(DateTime.now());
}
