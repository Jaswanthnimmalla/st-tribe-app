import 'dart:async';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:architecture/core/bloc/article/article_bloc.dart';
import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:architecture/core/bloc/groupbyin/group_by_in_bloc.dart';
import 'package:architecture/core/bloc/home/home_bloc.dart';
import 'package:architecture/core/bloc/intership/intership_bloc.dart';
import 'package:architecture/core/routes/router.dart';
import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:architecture/firebase_options.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:architecture/amplifyconfiguration.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'core/dependencyInjection/di.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:appcenter_sdk_flutter/appcenter_sdk_flutter.dart';

var logger = Logger();
var remoteConfig;

void checkForUpdate({bool initial = false}) async {
  if (kDebugMode) return;
  if (initial) {
    await Future.delayed(const Duration(seconds: 5));
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String updateTitle = remoteConfig.getString("update_title");
  String updateMessage = remoteConfig.getString("update_message");

  // await remoteConfig.activate();
  //Fetch new versions for android and iOS, and show update dialog if needed
  if (Platform.isAndroid) {
    String androidVersion = remoteConfig.getString("android_version");
    bool androidForceUpdate = remoteConfig.getBool("android_forced_update");
    //Print above two variables
    print("Android version: $androidVersion");
    print("Android force update: $androidForceUpdate");
    if (int.parse(androidVersion) > int.parse(packageInfo.buildNumber)) {
      showUpdateDialog(androidForceUpdate, updateTitle, updateMessage);
    }
  } else {
    String iosVersion = remoteConfig.getString("ios_version");
    bool iosForceUpdate = remoteConfig.getBool("ios_forced_update");
    if (int.parse(iosVersion) > int.parse(packageInfo.buildNumber)) {
      showUpdateDialog(iosForceUpdate, updateTitle, updateMessage);
    }
  }
}

Future<void> main() async {
  await AppContainer.init();
  runZonedGuarded(
    () async {
      EquatableConfig.stringify = true;

      WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
      // Initialize the FlutterBranchSdk
      await FlutterBranchSdk.init();
      // FlutterBranchSdk.validateSDKIntegration();
      if (Platform.isAndroid || Platform.isIOS) {
        await AppCenter.start(
          secret: Platform.isAndroid
              ? "829a1a39-ecb5-4104-bc44-e13649a3de67"
              : "dbceec1b-f7cf-4fb2-a896-04a37b2dd298",
        );
        await AppCenter.enable();
        FlutterError.onError = (final details) async {
          await AppCenterCrashes.trackException(
            message: details.exception.toString(),
            type: details.exception.runtimeType,
            stackTrace: details.stack,
          );
        };
      }

      OneSignal.initialize("ffe7c0b1-a028-4054-a081-adfe1ab0b901");
      FlutterNativeSplash.preserve(widgetsBinding: binding);

      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        remoteConfig = FirebaseRemoteConfig.instance;
        await remoteConfig.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(minutes: 1),
            minimumFetchInterval: const Duration(hours: 1),
          ),
        );
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        if (Platform.isAndroid) {
          await remoteConfig.setDefaults({
            "android_version": packageInfo.buildNumber,
            "android_force_update": false,
            "update_message":
                "An update is available for this app. Please update the app to continue using it.",
            "update_title": "Update Available!",
          });
        } else {
          await remoteConfig.setDefaults({
            "ios_version": packageInfo.buildNumber,
            "ios_force_update": false,
            "update_message":
                "An update is available for this app. Please update the app to continue using it.",
            "update_title": "Update Available!",
          });
        }
        await remoteConfig.fetchAndActivate();
        checkForUpdate(initial: true);

        remoteConfig.onConfigUpdated.listen((event) async {
          await remoteConfig.fetchAndActivate();
          checkForUpdate();
        });
        if (kReleaseMode) {
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterFatalError;
        }
      }

      //Remove this method to stop OneSignal Debugging
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

      // FlutterBranchSdk.validateSDKIntegration();
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.primary),
      );

      BindingBase.debugZoneErrorsAreFatal = true;

      final authPlugin = AmplifyAuthCognito();
      await Amplify.addPlugin(authPlugin);

      try {
        await Amplify.configure(amplifyconfig);
        print("Amplify Configured");
      } on AmplifyAlreadyConfiguredException {
        safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.",
        );
      }
      runApp(
        const MyApp(),
        // DevicePreview(
        //   enabled: !kReleaseMode,
        //   builder: (context) => MyApp(), // Wrap your app
        // ),
      );
    },
    (e, s) {
      logger.e(s);
      logger.e('catches error of first error-zone.$e');
      if (kReleaseMode) {
        FirebaseCrashlytics.instance.recordError(e, s, fatal: true);
      }

      BuildContext? context = GetIt.I<AppRouter>().navigatorKey.currentContext;
      if (context != null) {
        hideOverlayLoader(context);
      }
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    GetIt.I.registerSingleton<AppRouter>(_appRouter);

    // initDeepLinkData();
    super.initState();
  }

  //Facebook App Secret: edeadf4a4535b12be0f04536630ac6f8
  //Facebook App ID: 1173657240259730

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: GetIt.I<AuthBloc>()..add(CheckUserAuthEvent()),
          ),
          BlocProvider.value(value: GetIt.I<ProfileBloc>()),
          BlocProvider.value(value: GetIt.I<InternshipBloc>()),
          BlocProvider.value(value: GetIt.I<ArticleBloc>()),
          BlocProvider.value(value: GetIt.I<EventBloc>()),
          BlocProvider.value(value: GetIt.I<HomeBloc>()),
          BlocProvider.value(value: GetIt.I<GroupByInBloc>()),
        ],
        child: ScreenUtilInit(
          ensureScreenSize: true,
          minTextAdapt: true,
          builder: (_, child) {
            return MaterialApp.router(
              title: 'Student Tribe',
              routerConfig: _appRouter.config(),
              theme: AppTheme.theme,
              debugShowCheckedModeBanner: false,
            );
          },
          designSize: const Size(360, 800),
        ),
      ),
    );
  }
}
