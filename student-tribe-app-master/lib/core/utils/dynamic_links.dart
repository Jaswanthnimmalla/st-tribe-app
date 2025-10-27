import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../main.dart';
import '../bloc/auth/auth_bloc.dart';
import '../routes/router.dart';
import '../routes/router.gr.dart';

@singleton
class DynamicLinks {
  bool isDynamicLinkActive = false;
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();

  void listenDynamicLinks() async {
    if (streamSubscription != null) {
      return;
    }
    print("DYNAMIC LINKS STARTS");
    streamSubscription = FlutterBranchSdk.initSession().listen((data) async {
      controllerData.sink.add((data.toString()));
      await Future.delayed(const Duration(milliseconds: 100));
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        await Future.delayed(const Duration(milliseconds: 100));
        BuildContext context =
            GetIt.I<AppRouter>().navigatorKey.currentContext!;

        if (context.read<AuthBloc>().isUserValid) {
          if (data["routeName"] == "articles" &&
              data["articleId"].toString().isNotEmpty) {
            await Future.delayed(const Duration(milliseconds: 100));
            context.read<AuthBloc>().add(const UpdateBottomNavigationIndex(3));
            context.router.push(MoreDetails(
                id: data[
                    "articleId"])); //! If we call api here it will run even if user dont have account which create error
          }

          //!Event Share

          if (data['eventId'] != null && data["eventId"].isNotEmpty) {
            await Future.delayed(const Duration(milliseconds: 100));
            context.read<AuthBloc>().add(const UpdateBottomNavigationIndex(1));
            context.router.push(EventDetailsRoute(id: data["eventId"]));
          }
          //!Internship Share

          if (data['internshipId'] != null && data["internshipId"].isNotEmpty) {
            await Future.delayed(const Duration(milliseconds: 100));
            context.read<AuthBloc>().add(const UpdateBottomNavigationIndex(2));
            context.router
                .push(IntershipDetailsRoute(id: data["internshipId"]));
          }
        }

        if (data["referId"] != null && data["referId"].isNotEmpty) {
          logger.d("REFER FRIEND ID COMES HERE ${data["referId"]}");
          // ignore: use_build_context_synchronously
          context
              .read<AuthBloc>()
              .add(SaveReferIdEvent(referId: data["referId"]));
        }

        print(
            '------------------------------------------------------------------------------------------------');
        // showSnackBar(
        //     message: 'Link clicked: Custom string - ${data['custom_string']}',
        //     duration: 10);
      }
    }, onError: (error) {
      print('InitSesseion error: ${error.toString()}');
    });
  }

  void cancelListen(){
    streamSubscription?.cancel();
  }
}
