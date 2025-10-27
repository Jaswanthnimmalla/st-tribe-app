import 'package:architecture/core/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),

    //! Auth Routes
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: OnBoardingRoute.page),
    AutoRoute(page: VerifyOtpRoute.page),
    AutoRoute(page: AccountCreatedRoute.page),
    AutoRoute(page: UploadCollegeIdRoute.page),
    AutoRoute(page: ForgotPassword.page),
    AutoRoute(page: ConfirmNewPassword.page),

    //! Profile Routes
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: PersonalDetailsRoute.page),
    AutoRoute(page: EducationalDetailsRoute.page),
    AutoRoute(page: SkillSetDetailsRoute.page),
    AutoRoute(page: ExperienceDetailsRoute.page),

    //! BottomNavigation Routes And Screens
    AutoRoute(page: BottomNavigationRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: EventRoute.page),
    AutoRoute(page: IntershipRoute.page),
    AutoRoute(page: HonestRoute.page),
    AutoRoute(page: MoreRoute.page),

    //! Event Screens
    AutoRoute(page: EventFilterRoute.page),
    AutoRoute(page: EventDetailsRoute.page),
    AutoRoute(page: CommentRoute.page),
    AutoRoute(page: MyEvents.page),

    //!Event Checkout Screen
    AutoRoute(page: BuyTicketRoute.page),
    AutoRoute(page: CheckOutRoute.page),
    AutoRoute(page: DebitCreditCardRoute.page),
    AutoRoute(page: EticketRoute.page),

    //!IntershipScreen
    AutoRoute(page: IntershipDetailsRoute.page),
    AutoRoute(page: IntershipFilterRoute.page),
    AutoRoute(page: LocationFilter.page),
    AutoRoute(page: JobTitleFilter.page),
    AutoRoute(page: SkillFilter.page),
    AutoRoute(page: AppliedInternship.page),

    //!More Routes
    AutoRoute(page: GroupInDetailsRoute.page),
    AutoRoute(page: MoreDetails.page),
    AutoRoute(page: MyArticle.page),
    AutoRoute(page: CreateArticle.page),

    //!BookMark Routes
    AutoRoute(page: BookMark.page),

    //!Search Route
    AutoRoute(page: SearchRoute.page),

    //! Stcoin Route
    AutoRoute(page: StCoins.page),
    AutoRoute(page: StCoinInfo.page),

    //! ReferFriend Route
    AutoRoute(page: ReferFriend.page),
    //!LeaderBoard  Route
    AutoRoute(page: LeaderBoard.page),

    AutoRoute(page: InAppWeb.page),
  ];
}
