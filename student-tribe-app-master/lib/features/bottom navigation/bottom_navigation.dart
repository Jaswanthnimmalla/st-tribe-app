// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_flushbar/flushbar.dart';
import 'package:architecture/core/routes/router.gr.dart' as routeFiles;
import 'package:auto_route/auto_route.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/presentation/widgets/app_dilogs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../core/bloc/profile/profile_bloc.dart';
import '../../core/constants/images.dart';
import '../../core/presentation/widgets/hspace.dart';
import '../../core/presentation/widgets/vspace.dart';
import '../../core/theme/app_color.dart';
import '../../core/theme/apptheme.dart';
import '../../core/utils/common_methods.dart';
import '../../core/utils/dynamic_links.dart';
import 'events/event_screen.dart';
import 'home/home_screen.dart';
import 'interships/internship_screen.dart';
import 'more/more_screen.dart';
import 'st coins/st_coins.dart';

@RoutePage()
class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0; // Index of the currently selected tab
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<AuthBloc>().add(CheckUserAuthEvent());
    GetIt.I<DynamicLinks>().listenDynamicLinks();
    super.initState();
  }

  // Define a list of tabs you want in the bottom navigation bar
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    EventScreen(),
    IntershipScreen(),
    // HonestScreen(),
    MoreScreen(),
  ];
  String text = "";
  // Function to handle tab selection

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: kToolbarHeight * 2,
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/svg/stlogo_transparent.svg',
                    height: 52.h,
                    width: 52.w,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return StCoinsWidget(
                        margin: EdgeInsets.zero,
                        text:
                            "${(context.read<ProfileBloc>().userModel?.stCoins ?? 0)}",
                        onTap: () {
                          context.router.push(routeFiles.StCoins());
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          DrawerItems(
            text: "My Profile",
            iconData: Icons.person,
            imagePath: AppImages.myprofile,
            onTap: () {
              final facebookAppEvents = FacebookAppEvents();
              facebookAppEvents.logEvent(
                name: 'button_clicked',
                parameters: {'button_id': 'My Profile'},
              );
              context.router.push(const routeFiles.ProfileRoute());
              closeDrawer();
            },
          ),
          DrawerItems(
            text: "St Coins",
            iconData: Icons.currency_exchange,
            imagePath: AppImages.stblack,
            onTap: () {
              context.router.push(const routeFiles.LeaderBoard());
              closeDrawer();
            },
          ),
          DrawerItems(
            text: "Applied Internships",
            iconData: Icons.done,
            imagePath: AppImages.appliedInternship,
            onTap: () {
              context.router.push(const routeFiles.AppliedInternship());
              closeDrawer();
            },
          ),
          DrawerItems(
            text: "Bookmarks",
            iconData: Icons.bookmark_outline,
            imagePath: AppImages.bookmark,
            onTap: () {
              context.router.push(const routeFiles.BookMark());
            },
          ),
          DrawerItems(
            text: "Bookings",
            iconData: Icons.event,
            imagePath: AppImages.calendra3,
            onTap: () {
              context.router.push(const routeFiles.MyEvents());
              closeDrawer();
            },
          ),
          DrawerItems(
            text: "Privacy Policy",
            iconData: Icons.edit_document,
            imagePath: AppImages.privacy,
            onTap: () async {
              context.router.push(
                routeFiles.InAppWeb(
                  url: "https://studenttribe.in/privacy-policy/",
                  text: "Privacy Policy",
                  isAppBarNeeded: true,
                ),
              );
            },
          ),
          DrawerItems(
            text: "Terms & Conditions",
            iconData: Icons.description,
            imagePath: AppImages.terms,
            onTap: () async {
              context.router.push(
                routeFiles.InAppWeb(
                  url: "https://studenttribe.in/terms-and-conditions/",
                  text: "Terms & Conditions",
                  isAppBarNeeded: true,
                ),
              );
            },
          ),
          DrawerItems(
            text: "Refer a friend",
            iconData: Icons.description,
            imagePath: AppImages.refer,
            onTap: () {
              context.router.push(const routeFiles.ReferFriend());
              closeDrawer();
            },
          ),
          DrawerItems(
            text: "Logout",
            iconData: Icons.logout,
            imagePath: AppImages.logout,
            onTap: () {
              showConfirmDialog(
                context: context,
                message: 'Are you sure you want to log out?',
                cancelTap: () {
                  context.router.pop();
                },
                confirmTap: () {
                  context.router.pop();
                  context.read<AuthBloc>().isUserValid = false;
                  GetIt.I<DynamicLinks>().cancelListen();
                  context.read<AuthBloc>().add(LogOutAuthEvent());
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void closeDrawer() {
    _scaffoldKey.currentState!.closeDrawer();
  }

  setBottomBarIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(),
      backgroundColor: AppColors.primary,
      appBar: _selectedIndex == 5
          ? null
          : AppBar(
              title:
                  //  _selectedIndex == 0
                  //     ?
                  SvgPicture.asset(
                    'assets/svg/stlogo_transparent.svg',
                    // height: 46.h,
                    width: 46.w,
                  ),
              // :
              //  Text(
              //     text,
              //     style: AppTheme.bodyText3.copyWith(
              //         fontSize: 16.sp,
              //         color: AppColors.white,
              //         fontWeight: FontWeight.w700),
              //   ),
              backgroundColor: AppColors.primary,
              centerTitle: false,
              leading: GestureDetector(
                onTap: () {
                  // context.router.push(VerifyOtpRoute());
                  // context.router.push(LoginRoute());
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: const Icon(Icons.menu),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    context.router.push(
                      routeFiles.SearchRoute(screenType: text),
                    );
                  },
                  child: const Icon(Icons.search),
                ),
                const Hspace(19),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return StCoinsWidget(
                      text:
                          "${context.read<ProfileBloc>().userModel?.stCoins ?? ""}",
                      onTap: () {
                        context.router.push(
                          routeFiles.StCoins(isFromBottomNav: true),
                        );
                      },
                    );
                  },
                ),
                const Hspace(17),
              ],
            ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showOverlayLoader(context);
          } else {
            hideOverlayLoader(context);
          }
          if (state is UnAuthenticatedAuthState) {
            context.router.pushAndPopUntil(
              const routeFiles.AuthRoute(),
              predicate: (route) => false,
            );
          }
          if (state is UpdatedNavigationState) {
            setState(() {
              _selectedIndex = state.index;
            });
          }
        },
        child:
            // Center(
            //   child: _widgetOptions.elementAt(_selectedIndex),
            // ),
            Stack(
              children: [
                Center(
                  child: _selectedIndex == 5
                      ? StCoins(isFromBottomNav: false)
                      : _widgetOptions.elementAt(_selectedIndex),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: size.width,
                    height: 69,
                    child: Stack(
                      // overflow: Overflow.visible,
                      children: [
                        ColoredBox(
                          color: Color(0xfffffdfd),
                          child: CustomPaint(
                            size: Size(size.width, 80),
                            painter: BNBCustomPainter(),
                          ),
                        ),
                        Center(
                          heightFactor: 0.6,
                          child: GestureDetector(
                            onTap: () {
                              setBottomBarIndex(5);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 4,
                              ),
                              height: 50,
                              width: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: AppColors.primary,
                                border: Border.all(color: AppColors.primary),
                              ),
                              child: SvgPicture.asset(
                                AppImages.redcoin,
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonCustomBottomElements(
                                selectedIndex: _selectedIndex,
                                imagePath: AppImages.home,
                                updateState: setBottomBarIndex,
                                text: "Home",
                                specificIndex: 0,
                              ),
                              CommonCustomBottomElements(
                                selectedIndex: _selectedIndex,
                                imagePath: AppImages.events,
                                updateState: setBottomBarIndex,
                                text: "Events",
                                specificIndex: 1,
                              ),
                              Container(width: size.width * 0.20),
                              CommonCustomBottomElements(
                                selectedIndex: _selectedIndex,
                                imagePath: AppImages.interships,
                                updateState: setBottomBarIndex,
                                text: "Internships",
                                specificIndex: 2,
                              ),
                              CommonCustomBottomElements(
                                selectedIndex: _selectedIndex,
                                imagePath: AppImages.more,
                                updateState: setBottomBarIndex,
                                text: "More",
                                specificIndex: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      ),
      // bottomNavigationBar: BottomNavBarV2()
      // BottomNavigationBar(
      //   elevation: 0,
      //   backgroundColor: AppColors.white,
      //   unselectedItemColor: AppColors.grey,
      //   selectedLabelStyle:
      //       AppTheme.bodyText3.copyWith(fontSize: 10, color: AppColors.primary),
      //   showUnselectedLabels: true,
      //   showSelectedLabels: true,
      //   unselectedLabelStyle:
      //       AppTheme.bodyText3.copyWith(fontSize: 10, color: AppColors.grey),
      //   type: BottomNavigationBarType.fixed,
      //   items: <BottomNavigationBarItem>[
      //     const BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home_outlined,
      //           color: AppColors.grey,
      //         ),
      //         label: 'Home',
      //         activeIcon: Icon(
      //           Icons.home_outlined,
      //           color: AppColors.primary,
      //         )),
      //     BottomNavigationBarItem(
      //         icon: Image.asset(
      //           AppImages.events,
      //           color: AppColors.grey,
      //         ),
      //         label: 'Events',
      //         activeIcon: Image.asset(
      //           AppImages.events,
      //           color: AppColors.primary,
      //         )),
      //     BottomNavigationBarItem(
      //         icon: Image.asset(
      //           AppImages.interships,
      //           color: AppColors.grey,
      //         ),
      //         label: 'Internships',
      //         activeIcon: Image.asset(
      //           AppImages.interships,
      //           color: AppColors.primary,
      //         )),

      //     // BottomNavigationBarItem(
      //     //     icon: Image.asset(
      //     //       AppImages.honest,
      //     //       color: AppColors.grey,
      //     //     ),
      //     //     label: 'Honest',
      //     //     activeIcon: Image.asset(
      //     //       AppImages.honest,
      //     //       color: AppColors.primary,
      //     //     )),
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         AppImages.more,
      //         color: AppColors.grey,
      //       ),
      //       label: 'More',
      //       activeIcon: Image.asset(
      //         AppImages.more,
      //         color: AppColors.primary,
      //       ),
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: AppColors.primary, // Color of the selected tab
      //   onTap: _onItemTapped, // Callback when a tab is tapped
      // ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class CommonCustomBottomElements extends StatelessWidget {
  const CommonCustomBottomElements({
    super.key,
    required int selectedIndex,
    required this.updateState,
    required this.imagePath,
    required this.text,
    required this.specificIndex,
  }) : _selectedIndex = selectedIndex;

  final int _selectedIndex;
  final Function(int) updateState;
  final String imagePath;
  final String text;
  final int specificIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateState(specificIndex);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text == "Home"
              ? Icon(
                  Icons.home_outlined,
                  color: _selectedIndex == specificIndex
                      ? AppColors.primary
                      : AppColors.grey,
                )
              : Image.asset(
                  imagePath,
                  color: _selectedIndex == specificIndex
                      ? AppColors.primary
                      : AppColors.grey,
                ),
          Vspace(4),
          Text(
            text,
            style: AppTheme.bodyText3.copyWith(
              fontSize: 10.sp,
              color: _selectedIndex == specificIndex
                  ? AppColors.primary
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class StCoinsWidget extends StatelessWidget {
  const StCoinsWidget({
    Key? key,
    this.margin,
    this.padding,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: margin ?? const EdgeInsets.symmetric(vertical: 13).r,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 10, vertical: 3).r,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppImages.redcoin, width: 25),
              const Hspace(5),
              Text(
                text,
                style: AppTheme.bodyText3.copyWith(
                  color: AppColors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({
    Key? key,
    this.imagePath,
    this.iconData,
    this.onTap,
    required this.text,
  }) : super(key: key);
  final String? imagePath;
  final String text;
  final IconData? iconData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imagePath == null
          ? Icon(iconData, color: Colors.black)
          : Image.asset(imagePath!),
      title: Text(text, style: AppTheme.bodyText3),
      onTap:
          onTap ??
          () {
            Flushbar(
              message: 'Under development',
              duration: const Duration(milliseconds: 1500),
            ).show(context);
          },
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(
      Offset(size.width * 0.60, 10),
      radius: Radius.circular(1.0),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.62, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
