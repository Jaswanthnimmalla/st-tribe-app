import 'dart:async';

import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/constants/images.dart';
import 'package:architecture/core/routes/router.gr.dart';
import 'package:architecture/core/utils/dynamic_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

import '../../core/presentation/widgets/app_background.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // listenDynamicLinks();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
      if (context.read<AuthBloc>().state is AuthSuccessState) {
        // context.read<AuthBloc>().add(CheckUserAuthEvent());
        print("USER IS VALID FROM SPLASH SCREEN");
        context.router.replace(const BottomNavigationRoute());
        GetIt.I<DynamicLinks>().listenDynamicLinks();
      } else {
        print("USER IS INVALID FROM SPLASH SCREEN");
        context.router.replace(const AuthRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackGround(child: Center(child: Image.asset(AppImages.splash))),
    );
  }
}
