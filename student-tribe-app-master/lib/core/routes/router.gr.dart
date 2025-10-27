// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:architecture/core/data/models/article.dart' as _i53;
import 'package:architecture/core/data/models/education.dart' as _i55;
import 'package:architecture/core/data/models/event/booking_model.dart' as _i56;
import 'package:architecture/core/data/models/event/event_model.dart' as _i50;
import 'package:architecture/core/data/models/experience.dart' as _i57;
import 'package:architecture/core/data/models/groupbyin.dart' as _i51;
import 'package:architecture/core/data/models/skill.dart' as _i59;
import 'package:architecture/core/data/models/stcoin.dart' as _i52;
import 'package:architecture/core/data/models/user.dart' as _i58;
import 'package:architecture/core/presentation/widgets/inappwebview.dart'
    as _i22;
import 'package:architecture/features/auth/screens/auth.dart' as _i2;
import 'package:architecture/features/auth/screens/auth_success.dart' as _i1;
import 'package:architecture/features/auth/screens/forgot_password.dart'
    as _i18;
import 'package:architecture/features/auth/screens/login.dart' as _i29;
import 'package:architecture/features/auth/screens/newpassword.dart' as _i8;
import 'package:architecture/features/auth/screens/register.dart' as _i38;
import 'package:architecture/features/auth/screens/upload_college_id.dart'
    as _i45;
import 'package:architecture/features/auth/screens/verify_otp.dart' as _i46;
import 'package:architecture/features/bottom%20navigation/bookmark/bookmark.dart'
    as _i3;
import 'package:architecture/features/bottom%20navigation/bottom_navigation.dart'
    as _i4;
import 'package:architecture/features/bottom%20navigation/checkout/buy_ticket_screen.dart'
    as _i5;
import 'package:architecture/features/bottom%20navigation/checkout/checkout_screen.dart'
    as _i6;
import 'package:architecture/features/bottom%20navigation/checkout/debit_and_credit_card_screen.dart'
    as _i10;
import 'package:architecture/features/bottom%20navigation/checkout/e_ticket.dart'
    as _i12;
import 'package:architecture/features/bottom%20navigation/events/comment_screen.dart'
    as _i7;
import 'package:architecture/features/bottom%20navigation/events/event_details_screen.dart'
    as _i13;
import 'package:architecture/features/bottom%20navigation/events/event_filter_screen.dart'
    as _i14;
import 'package:architecture/features/bottom%20navigation/events/event_question_answer_screen.dart'
    as _i15;
import 'package:architecture/features/bottom%20navigation/events/event_screen.dart'
    as _i16;
import 'package:architecture/features/bottom%20navigation/events/my_events.dart'
    as _i33;
import 'package:architecture/features/bottom%20navigation/export.dart' as _i49;
import 'package:architecture/features/bottom%20navigation/home/home_screen.dart'
    as _i20;
import 'package:architecture/features/bottom%20navigation/honest/honest_screen.dart'
    as _i21;
import 'package:architecture/features/bottom%20navigation/interships/applied_internship.dart'
    as _i47;
import 'package:architecture/features/bottom%20navigation/interships/internship_details_screen.dart'
    as _i23;
import 'package:architecture/features/bottom%20navigation/interships/internship_filter_screen.dart'
    as _i24;
import 'package:architecture/features/bottom%20navigation/interships/internship_jobtitle_filter_screen.dart'
    as _i26;
import 'package:architecture/features/bottom%20navigation/interships/internship_loction_filter_screen.dart'
    as _i28;
import 'package:architecture/features/bottom%20navigation/interships/internship_screen.dart'
    as _i25;
import 'package:architecture/features/bottom%20navigation/interships/internship_skills_filter_screen.dart'
    as _i40;
import 'package:architecture/features/bottom%20navigation/more/create_article.dart'
    as _i9;
import 'package:architecture/features/bottom%20navigation/more/group_in_details.dart'
    as _i19;
import 'package:architecture/features/bottom%20navigation/more/more_details.dart'
    as _i30;
import 'package:architecture/features/bottom%20navigation/more/more_screen.dart'
    as _i31;
import 'package:architecture/features/bottom%20navigation/more/my_article.dart'
    as _i32;
import 'package:architecture/features/bottom%20navigation/search.dart' as _i39;
import 'package:architecture/features/bottom%20navigation/st%20coins/leaderboard.dart'
    as _i27;
import 'package:architecture/features/bottom%20navigation/st%20coins/refer_friend.dart'
    as _i37;
import 'package:architecture/features/bottom%20navigation/st%20coins/st_coins.dart'
    as _i44;
import 'package:architecture/features/bottom%20navigation/st%20coins/stcoin_info.dart'
    as _i43;
import 'package:architecture/features/onboarding/screens/onboarding.dart'
    as _i34;
import 'package:architecture/features/profile/screen/educational_details.dart'
    as _i11;
import 'package:architecture/features/profile/screen/experience.dart' as _i17;
import 'package:architecture/features/profile/screen/personal_details.dart'
    as _i35;
import 'package:architecture/features/profile/screen/profile.dart' as _i36;
import 'package:architecture/features/profile/screen/skillset.dart' as _i41;
import 'package:architecture/features/splashScreen/splash_screen.dart' as _i42;
import 'package:auto_route/auto_route.dart' as _i48;
import 'package:flutter/material.dart' as _i54;

abstract class $AppRouter extends _i48.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i48.PageFactory> pagesMap = {
    AccountCreatedRoute.name: (routeData) {
      final args = routeData.argsAs<AccountCreatedRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AccountCreatedScreen(key: args.key, email: args.email),
      );
    },
    AuthRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthScreen(),
      );
    },
    BookMark.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BookMark(),
      );
    },
    BottomNavigationRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BottomNavigationScreen(),
      );
    },
    BuyTicketRoute.name: (routeData) {
      final args = routeData.argsAs<BuyTicketRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.BuyTicketScreen(
          key: args.key,
          eventModel: args.eventModel,
          totalPrice: args.totalPrice,
          screenType: args.screenType,
          groupByInModel: args.groupByInModel,
          stcoinModel: args.stcoinModel,
          stPointQuantity: args.stPointQuantity,
          groupBuyInQty: args.groupBuyInQty,
        ),
      );
    },
    CheckOutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckOutRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CheckOutScreen(
          key: args.key,
          eventModel: args.eventModel,
          groupByInModel: args.groupByInModel,
          stcoinModel: args.stcoinModel,
          stPointQuantity: args.stPointQuantity,
          screenType: args.screenType,
          totalPrice: args.totalPrice,
        ),
      );
    },
    CommentRoute.name: (routeData) {
      final args = routeData.argsAs<CommentRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.CommentScreen(args.articleId, key: args.key),
      );
    },
    ConfirmNewPassword.name: (routeData) {
      final args = routeData.argsAs<ConfirmNewPasswordArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.ConfirmNewPassword(key: args.key, email: args.email),
      );
    },
    CreateArticle.name: (routeData) {
      final args = routeData.argsAs<CreateArticleArgs>(
        orElse: () => const CreateArticleArgs(),
      );
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.CreateArticle(
          articleModel: args.articleModel,
          key: args.key,
        ),
      );
    },
    DebitCreditCardRoute.name: (routeData) {
      final args = routeData.argsAs<DebitCreditCardRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.DebitCreditCardScreen(
          key: args.key,
          totalPrice: args.totalPrice,
          eventModel: args.eventModel,
        ),
      );
    },
    EducationalDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EducationalDetailsRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.EducationalDetailsScreen(
          key: args.key,
          educationModel: args.educationModel,
          isUpdate: args.isUpdate,
        ),
      );
    },
    EticketRoute.name: (routeData) {
      final args = routeData.argsAs<EticketRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.EticketScreen(
          key: args.key,
          bookingModel: args.bookingModel,
          eventModel: args.eventModel,
          totalPrice: args.totalPrice,
        ),
      );
    },
    EventDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailsRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.EventDetailsScreen(key: args.key, id: args.id),
      );
    },
    EventFilterRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.EventFilterScreen(),
      );
    },
    EventQuestionAnswerRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.EventQuestionAnswerScreen(),
      );
    },
    EventRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.EventScreen(),
      );
    },
    ExperienceDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ExperienceDetailsRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.ExperienceDetailsScreen(
          key: args.key,
          experienceModel: args.experienceModel,
          isUpdate: args.isUpdate,
        ),
      );
    },
    ForgotPassword.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ForgotPassword(),
      );
    },
    GroupInDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<GroupInDetailsRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.GroupInDetailsScreen(key: args.key, id: args.id),
      );
    },
    HomeRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.HomeScreen(),
      );
    },
    HonestRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.HonestScreen(),
      );
    },
    InAppWeb.name: (routeData) {
      final args = routeData.argsAs<InAppWebArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.InAppWeb(
          key: args.key,
          url: args.url,
          isAppBarNeeded: args.isAppBarNeeded,
          text: args.text,
        ),
      );
    },
    IntershipDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<IntershipDetailsRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.IntershipDetailsScreen(key: args.key, id: args.id),
      );
    },
    IntershipFilterRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.IntershipFilterScreen(),
      );
    },
    IntershipRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.IntershipScreen(),
      );
    },
    JobTitleFilter.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.JobTitleFilter(),
      );
    },
    LeaderBoard.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.LeaderBoard(),
      );
    },
    LocationFilter.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.LocationFilter(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.LoginScreen(),
      );
    },
    MoreDetails.name: (routeData) {
      final args = routeData.argsAs<MoreDetailsArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.MoreDetails(args.id, key: args.key),
      );
    },
    MoreRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.MoreScreen(),
      );
    },
    MyArticle.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.MyArticle(),
      );
    },
    MyEvents.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.MyEvents(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.OnBoardingScreen(),
      );
    },
    PersonalDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PersonalDetailsRouteArgs>(
        orElse: () => const PersonalDetailsRouteArgs(),
      );
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i35.PersonalDetailsScreen(
          key: args.key,
          userModel: args.userModel,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.ProfileScreen(),
      );
    },
    ReferFriend.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.ReferFriend(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.RegisterScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i39.SearchScreen(key: args.key, screenType: args.screenType),
      );
    },
    SkillFilter.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i40.SkillFilter(),
      );
    },
    SkillSetDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<SkillSetDetailsRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i41.SkillSetDetailsScreen(args.selectedSkills, key: args.key),
      );
    },
    SplashRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i42.SplashScreen(),
      );
    },
    StCoinInfo.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i43.StCoinInfo(),
      );
    },
    StCoins.name: (routeData) {
      final args = routeData.argsAs<StCoinsArgs>(
        orElse: () => const StCoinsArgs(),
      );
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i44.StCoins(
          key: args.key,
          isFromBottomNav: args.isFromBottomNav,
        ),
      );
    },
    UploadCollegeIdRoute.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i45.UploadCollegeIdScreen(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i46.VerifyOtpScreen(
          key: args.key,
          email: args.email,
          isFromForgotPassword: args.isFromForgotPassword,
        ),
      );
    },
    AppliedInternship.name: (routeData) {
      return _i48.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i47.appliedInternship(),
      );
    },
  };
}

/// generated route for
/// [_i1.AccountCreatedScreen]
class AccountCreatedRoute extends _i48.PageRouteInfo<AccountCreatedRouteArgs> {
  AccountCreatedRoute({
    _i49.Key? key,
    required String email,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         AccountCreatedRoute.name,
         args: AccountCreatedRouteArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'AccountCreatedRoute';

  static const _i48.PageInfo<AccountCreatedRouteArgs> page =
      _i48.PageInfo<AccountCreatedRouteArgs>(name);
}

class AccountCreatedRouteArgs {
  const AccountCreatedRouteArgs({this.key, required this.email});

  final _i49.Key? key;

  final String email;

  @override
  String toString() {
    return 'AccountCreatedRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i2.AuthScreen]
class AuthRoute extends _i48.PageRouteInfo<void> {
  const AuthRoute({List<_i48.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BookMark]
class BookMark extends _i48.PageRouteInfo<void> {
  const BookMark({List<_i48.PageRouteInfo>? children})
    : super(BookMark.name, initialChildren: children);

  static const String name = 'BookMark';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BottomNavigationScreen]
class BottomNavigationRoute extends _i48.PageRouteInfo<void> {
  const BottomNavigationRoute({List<_i48.PageRouteInfo>? children})
    : super(BottomNavigationRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i5.BuyTicketScreen]
class BuyTicketRoute extends _i48.PageRouteInfo<BuyTicketRouteArgs> {
  BuyTicketRoute({
    _i49.Key? key,
    _i50.EventModel? eventModel,
    required num totalPrice,
    required _i49.ScreenType screenType,
    _i51.GroupByInModel? groupByInModel,
    _i52.StcoinModel? stcoinModel,
    int? stPointQuantity,
    int? groupBuyInQty,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         BuyTicketRoute.name,
         args: BuyTicketRouteArgs(
           key: key,
           eventModel: eventModel,
           totalPrice: totalPrice,
           screenType: screenType,
           groupByInModel: groupByInModel,
           stcoinModel: stcoinModel,
           stPointQuantity: stPointQuantity,
           groupBuyInQty: groupBuyInQty,
         ),
         initialChildren: children,
       );

  static const String name = 'BuyTicketRoute';

  static const _i48.PageInfo<BuyTicketRouteArgs> page =
      _i48.PageInfo<BuyTicketRouteArgs>(name);
}

class BuyTicketRouteArgs {
  const BuyTicketRouteArgs({
    this.key,
    this.eventModel,
    required this.totalPrice,
    required this.screenType,
    this.groupByInModel,
    this.stcoinModel,
    this.stPointQuantity,
    this.groupBuyInQty,
  });

  final _i49.Key? key;

  final _i50.EventModel? eventModel;

  final num totalPrice;

  final _i49.ScreenType screenType;

  final _i51.GroupByInModel? groupByInModel;

  final _i52.StcoinModel? stcoinModel;

  final int? stPointQuantity;

  final int? groupBuyInQty;

  @override
  String toString() {
    return 'BuyTicketRouteArgs{key: $key, eventModel: $eventModel, totalPrice: $totalPrice, screenType: $screenType, groupByInModel: $groupByInModel, stcoinModel: $stcoinModel, stPointQuantity: $stPointQuantity, groupBuyInQty: $groupBuyInQty}';
  }
}

/// generated route for
/// [_i6.CheckOutScreen]
class CheckOutRoute extends _i48.PageRouteInfo<CheckOutRouteArgs> {
  CheckOutRoute({
    _i49.Key? key,
    _i50.EventModel? eventModel,
    _i51.GroupByInModel? groupByInModel,
    _i52.StcoinModel? stcoinModel,
    int? stPointQuantity,
    required _i49.ScreenType screenType,
    required num totalPrice,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         CheckOutRoute.name,
         args: CheckOutRouteArgs(
           key: key,
           eventModel: eventModel,
           groupByInModel: groupByInModel,
           stcoinModel: stcoinModel,
           stPointQuantity: stPointQuantity,
           screenType: screenType,
           totalPrice: totalPrice,
         ),
         initialChildren: children,
       );

  static const String name = 'CheckOutRoute';

  static const _i48.PageInfo<CheckOutRouteArgs> page =
      _i48.PageInfo<CheckOutRouteArgs>(name);
}

class CheckOutRouteArgs {
  const CheckOutRouteArgs({
    this.key,
    this.eventModel,
    this.groupByInModel,
    this.stcoinModel,
    this.stPointQuantity,
    required this.screenType,
    required this.totalPrice,
  });

  final _i49.Key? key;

  final _i50.EventModel? eventModel;

  final _i51.GroupByInModel? groupByInModel;

  final _i52.StcoinModel? stcoinModel;

  final int? stPointQuantity;

  final _i49.ScreenType screenType;

  final num totalPrice;

  @override
  String toString() {
    return 'CheckOutRouteArgs{key: $key, eventModel: $eventModel, groupByInModel: $groupByInModel, stcoinModel: $stcoinModel, stPointQuantity: $stPointQuantity, screenType: $screenType, totalPrice: $totalPrice}';
  }
}

/// generated route for
/// [_i7.CommentScreen]
class CommentRoute extends _i48.PageRouteInfo<CommentRouteArgs> {
  CommentRoute({
    required String articleId,
    _i49.Key? key,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         CommentRoute.name,
         args: CommentRouteArgs(articleId: articleId, key: key),
         initialChildren: children,
       );

  static const String name = 'CommentRoute';

  static const _i48.PageInfo<CommentRouteArgs> page =
      _i48.PageInfo<CommentRouteArgs>(name);
}

class CommentRouteArgs {
  const CommentRouteArgs({required this.articleId, this.key});

  final String articleId;

  final _i49.Key? key;

  @override
  String toString() {
    return 'CommentRouteArgs{articleId: $articleId, key: $key}';
  }
}

/// generated route for
/// [_i8.ConfirmNewPassword]
class ConfirmNewPassword extends _i48.PageRouteInfo<ConfirmNewPasswordArgs> {
  ConfirmNewPassword({
    _i49.Key? key,
    required String email,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         ConfirmNewPassword.name,
         args: ConfirmNewPasswordArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'ConfirmNewPassword';

  static const _i48.PageInfo<ConfirmNewPasswordArgs> page =
      _i48.PageInfo<ConfirmNewPasswordArgs>(name);
}

class ConfirmNewPasswordArgs {
  const ConfirmNewPasswordArgs({this.key, required this.email});

  final _i49.Key? key;

  final String email;

  @override
  String toString() {
    return 'ConfirmNewPasswordArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i9.CreateArticle]
class CreateArticle extends _i48.PageRouteInfo<CreateArticleArgs> {
  CreateArticle({
    _i53.ArticleModel? articleModel,
    _i49.Key? key,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         CreateArticle.name,
         args: CreateArticleArgs(articleModel: articleModel, key: key),
         initialChildren: children,
       );

  static const String name = 'CreateArticle';

  static const _i48.PageInfo<CreateArticleArgs> page =
      _i48.PageInfo<CreateArticleArgs>(name);
}

class CreateArticleArgs {
  const CreateArticleArgs({this.articleModel, this.key});

  final _i53.ArticleModel? articleModel;

  final _i49.Key? key;

  @override
  String toString() {
    return 'CreateArticleArgs{articleModel: $articleModel, key: $key}';
  }
}

/// generated route for
/// [_i10.DebitCreditCardScreen]
class DebitCreditCardRoute
    extends _i48.PageRouteInfo<DebitCreditCardRouteArgs> {
  DebitCreditCardRoute({
    _i49.Key? key,
    required num totalPrice,
    required _i50.EventModel eventModel,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         DebitCreditCardRoute.name,
         args: DebitCreditCardRouteArgs(
           key: key,
           totalPrice: totalPrice,
           eventModel: eventModel,
         ),
         initialChildren: children,
       );

  static const String name = 'DebitCreditCardRoute';

  static const _i48.PageInfo<DebitCreditCardRouteArgs> page =
      _i48.PageInfo<DebitCreditCardRouteArgs>(name);
}

class DebitCreditCardRouteArgs {
  const DebitCreditCardRouteArgs({
    this.key,
    required this.totalPrice,
    required this.eventModel,
  });

  final _i49.Key? key;

  final num totalPrice;

  final _i50.EventModel eventModel;

  @override
  String toString() {
    return 'DebitCreditCardRouteArgs{key: $key, totalPrice: $totalPrice, eventModel: $eventModel}';
  }
}

/// generated route for
/// [_i11.EducationalDetailsScreen]
class EducationalDetailsRoute
    extends _i48.PageRouteInfo<EducationalDetailsRouteArgs> {
  EducationalDetailsRoute({
    _i54.Key? key,
    _i55.EducationModel? educationModel,
    required bool isUpdate,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         EducationalDetailsRoute.name,
         args: EducationalDetailsRouteArgs(
           key: key,
           educationModel: educationModel,
           isUpdate: isUpdate,
         ),
         initialChildren: children,
       );

  static const String name = 'EducationalDetailsRoute';

  static const _i48.PageInfo<EducationalDetailsRouteArgs> page =
      _i48.PageInfo<EducationalDetailsRouteArgs>(name);
}

class EducationalDetailsRouteArgs {
  const EducationalDetailsRouteArgs({
    this.key,
    this.educationModel,
    required this.isUpdate,
  });

  final _i54.Key? key;

  final _i55.EducationModel? educationModel;

  final bool isUpdate;

  @override
  String toString() {
    return 'EducationalDetailsRouteArgs{key: $key, educationModel: $educationModel, isUpdate: $isUpdate}';
  }
}

/// generated route for
/// [_i12.EticketScreen]
class EticketRoute extends _i48.PageRouteInfo<EticketRouteArgs> {
  EticketRoute({
    _i49.Key? key,
    required _i56.BookingModel bookingModel,
    required _i50.EventModel eventModel,
    required num totalPrice,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         EticketRoute.name,
         args: EticketRouteArgs(
           key: key,
           bookingModel: bookingModel,
           eventModel: eventModel,
           totalPrice: totalPrice,
         ),
         initialChildren: children,
       );

  static const String name = 'EticketRoute';

  static const _i48.PageInfo<EticketRouteArgs> page =
      _i48.PageInfo<EticketRouteArgs>(name);
}

class EticketRouteArgs {
  const EticketRouteArgs({
    this.key,
    required this.bookingModel,
    required this.eventModel,
    required this.totalPrice,
  });

  final _i49.Key? key;

  final _i56.BookingModel bookingModel;

  final _i50.EventModel eventModel;

  final num totalPrice;

  @override
  String toString() {
    return 'EticketRouteArgs{key: $key, bookingModel: $bookingModel, eventModel: $eventModel, totalPrice: $totalPrice}';
  }
}

/// generated route for
/// [_i13.EventDetailsScreen]
class EventDetailsRoute extends _i48.PageRouteInfo<EventDetailsRouteArgs> {
  EventDetailsRoute({
    _i49.Key? key,
    required String id,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         EventDetailsRoute.name,
         args: EventDetailsRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'EventDetailsRoute';

  static const _i48.PageInfo<EventDetailsRouteArgs> page =
      _i48.PageInfo<EventDetailsRouteArgs>(name);
}

class EventDetailsRouteArgs {
  const EventDetailsRouteArgs({this.key, required this.id});

  final _i49.Key? key;

  final String id;

  @override
  String toString() {
    return 'EventDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i14.EventFilterScreen]
class EventFilterRoute extends _i48.PageRouteInfo<void> {
  const EventFilterRoute({List<_i48.PageRouteInfo>? children})
    : super(EventFilterRoute.name, initialChildren: children);

  static const String name = 'EventFilterRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i15.EventQuestionAnswerScreen]
class EventQuestionAnswerRoute extends _i48.PageRouteInfo<void> {
  const EventQuestionAnswerRoute({List<_i48.PageRouteInfo>? children})
    : super(EventQuestionAnswerRoute.name, initialChildren: children);

  static const String name = 'EventQuestionAnswerRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i16.EventScreen]
class EventRoute extends _i48.PageRouteInfo<void> {
  const EventRoute({List<_i48.PageRouteInfo>? children})
    : super(EventRoute.name, initialChildren: children);

  static const String name = 'EventRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i17.ExperienceDetailsScreen]
class ExperienceDetailsRoute
    extends _i48.PageRouteInfo<ExperienceDetailsRouteArgs> {
  ExperienceDetailsRoute({
    _i54.Key? key,
    _i57.ExperienceModel? experienceModel,
    required bool isUpdate,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         ExperienceDetailsRoute.name,
         args: ExperienceDetailsRouteArgs(
           key: key,
           experienceModel: experienceModel,
           isUpdate: isUpdate,
         ),
         initialChildren: children,
       );

  static const String name = 'ExperienceDetailsRoute';

  static const _i48.PageInfo<ExperienceDetailsRouteArgs> page =
      _i48.PageInfo<ExperienceDetailsRouteArgs>(name);
}

class ExperienceDetailsRouteArgs {
  const ExperienceDetailsRouteArgs({
    this.key,
    this.experienceModel,
    required this.isUpdate,
  });

  final _i54.Key? key;

  final _i57.ExperienceModel? experienceModel;

  final bool isUpdate;

  @override
  String toString() {
    return 'ExperienceDetailsRouteArgs{key: $key, experienceModel: $experienceModel, isUpdate: $isUpdate}';
  }
}

/// generated route for
/// [_i18.ForgotPassword]
class ForgotPassword extends _i48.PageRouteInfo<void> {
  const ForgotPassword({List<_i48.PageRouteInfo>? children})
    : super(ForgotPassword.name, initialChildren: children);

  static const String name = 'ForgotPassword';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i19.GroupInDetailsScreen]
class GroupInDetailsRoute extends _i48.PageRouteInfo<GroupInDetailsRouteArgs> {
  GroupInDetailsRoute({
    _i49.Key? key,
    required String id,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         GroupInDetailsRoute.name,
         args: GroupInDetailsRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'GroupInDetailsRoute';

  static const _i48.PageInfo<GroupInDetailsRouteArgs> page =
      _i48.PageInfo<GroupInDetailsRouteArgs>(name);
}

class GroupInDetailsRouteArgs {
  const GroupInDetailsRouteArgs({this.key, required this.id});

  final _i49.Key? key;

  final String id;

  @override
  String toString() {
    return 'GroupInDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i20.HomeScreen]
class HomeRoute extends _i48.PageRouteInfo<void> {
  const HomeRoute({List<_i48.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i21.HonestScreen]
class HonestRoute extends _i48.PageRouteInfo<void> {
  const HonestRoute({List<_i48.PageRouteInfo>? children})
    : super(HonestRoute.name, initialChildren: children);

  static const String name = 'HonestRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i22.InAppWeb]
class InAppWeb extends _i48.PageRouteInfo<InAppWebArgs> {
  InAppWeb({
    _i54.Key? key,
    required String url,
    bool isAppBarNeeded = true,
    String? text,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         InAppWeb.name,
         args: InAppWebArgs(
           key: key,
           url: url,
           isAppBarNeeded: isAppBarNeeded,
           text: text,
         ),
         initialChildren: children,
       );

  static const String name = 'InAppWeb';

  static const _i48.PageInfo<InAppWebArgs> page = _i48.PageInfo<InAppWebArgs>(
    name,
  );
}

class InAppWebArgs {
  const InAppWebArgs({
    this.key,
    required this.url,
    this.isAppBarNeeded = true,
    this.text,
  });

  final _i54.Key? key;

  final String url;

  final bool isAppBarNeeded;

  final String? text;

  @override
  String toString() {
    return 'InAppWebArgs{key: $key, url: $url, isAppBarNeeded: $isAppBarNeeded, text: $text}';
  }
}

/// generated route for
/// [_i23.IntershipDetailsScreen]
class IntershipDetailsRoute
    extends _i48.PageRouteInfo<IntershipDetailsRouteArgs> {
  IntershipDetailsRoute({
    _i49.Key? key,
    required String id,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         IntershipDetailsRoute.name,
         args: IntershipDetailsRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'IntershipDetailsRoute';

  static const _i48.PageInfo<IntershipDetailsRouteArgs> page =
      _i48.PageInfo<IntershipDetailsRouteArgs>(name);
}

class IntershipDetailsRouteArgs {
  const IntershipDetailsRouteArgs({this.key, required this.id});

  final _i49.Key? key;

  final String id;

  @override
  String toString() {
    return 'IntershipDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i24.IntershipFilterScreen]
class IntershipFilterRoute extends _i48.PageRouteInfo<void> {
  const IntershipFilterRoute({List<_i48.PageRouteInfo>? children})
    : super(IntershipFilterRoute.name, initialChildren: children);

  static const String name = 'IntershipFilterRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i25.IntershipScreen]
class IntershipRoute extends _i48.PageRouteInfo<void> {
  const IntershipRoute({List<_i48.PageRouteInfo>? children})
    : super(IntershipRoute.name, initialChildren: children);

  static const String name = 'IntershipRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i26.JobTitleFilter]
class JobTitleFilter extends _i48.PageRouteInfo<void> {
  const JobTitleFilter({List<_i48.PageRouteInfo>? children})
    : super(JobTitleFilter.name, initialChildren: children);

  static const String name = 'JobTitleFilter';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i27.LeaderBoard]
class LeaderBoard extends _i48.PageRouteInfo<void> {
  const LeaderBoard({List<_i48.PageRouteInfo>? children})
    : super(LeaderBoard.name, initialChildren: children);

  static const String name = 'LeaderBoard';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i28.LocationFilter]
class LocationFilter extends _i48.PageRouteInfo<void> {
  const LocationFilter({List<_i48.PageRouteInfo>? children})
    : super(LocationFilter.name, initialChildren: children);

  static const String name = 'LocationFilter';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i29.LoginScreen]
class LoginRoute extends _i48.PageRouteInfo<void> {
  const LoginRoute({List<_i48.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i30.MoreDetails]
class MoreDetails extends _i48.PageRouteInfo<MoreDetailsArgs> {
  MoreDetails({
    required String id,
    _i49.Key? key,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         MoreDetails.name,
         args: MoreDetailsArgs(id: id, key: key),
         initialChildren: children,
       );

  static const String name = 'MoreDetails';

  static const _i48.PageInfo<MoreDetailsArgs> page =
      _i48.PageInfo<MoreDetailsArgs>(name);
}

class MoreDetailsArgs {
  const MoreDetailsArgs({required this.id, this.key});

  final String id;

  final _i49.Key? key;

  @override
  String toString() {
    return 'MoreDetailsArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i31.MoreScreen]
class MoreRoute extends _i48.PageRouteInfo<void> {
  const MoreRoute({List<_i48.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i32.MyArticle]
class MyArticle extends _i48.PageRouteInfo<void> {
  const MyArticle({List<_i48.PageRouteInfo>? children})
    : super(MyArticle.name, initialChildren: children);

  static const String name = 'MyArticle';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i33.MyEvents]
class MyEvents extends _i48.PageRouteInfo<void> {
  const MyEvents({List<_i48.PageRouteInfo>? children})
    : super(MyEvents.name, initialChildren: children);

  static const String name = 'MyEvents';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i34.OnBoardingScreen]
class OnBoardingRoute extends _i48.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i48.PageRouteInfo>? children})
    : super(OnBoardingRoute.name, initialChildren: children);

  static const String name = 'OnBoardingRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i35.PersonalDetailsScreen]
class PersonalDetailsRoute
    extends _i48.PageRouteInfo<PersonalDetailsRouteArgs> {
  PersonalDetailsRoute({
    _i54.Key? key,
    _i58.UserModel? userModel,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         PersonalDetailsRoute.name,
         args: PersonalDetailsRouteArgs(key: key, userModel: userModel),
         initialChildren: children,
       );

  static const String name = 'PersonalDetailsRoute';

  static const _i48.PageInfo<PersonalDetailsRouteArgs> page =
      _i48.PageInfo<PersonalDetailsRouteArgs>(name);
}

class PersonalDetailsRouteArgs {
  const PersonalDetailsRouteArgs({this.key, this.userModel});

  final _i54.Key? key;

  final _i58.UserModel? userModel;

  @override
  String toString() {
    return 'PersonalDetailsRouteArgs{key: $key, userModel: $userModel}';
  }
}

/// generated route for
/// [_i36.ProfileScreen]
class ProfileRoute extends _i48.PageRouteInfo<void> {
  const ProfileRoute({List<_i48.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i37.ReferFriend]
class ReferFriend extends _i48.PageRouteInfo<void> {
  const ReferFriend({List<_i48.PageRouteInfo>? children})
    : super(ReferFriend.name, initialChildren: children);

  static const String name = 'ReferFriend';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i38.RegisterScreen]
class RegisterRoute extends _i48.PageRouteInfo<void> {
  const RegisterRoute({List<_i48.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i39.SearchScreen]
class SearchRoute extends _i48.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i49.Key? key,
    required String screenType,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         SearchRoute.name,
         args: SearchRouteArgs(key: key, screenType: screenType),
         initialChildren: children,
       );

  static const String name = 'SearchRoute';

  static const _i48.PageInfo<SearchRouteArgs> page =
      _i48.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({this.key, required this.screenType});

  final _i49.Key? key;

  final String screenType;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, screenType: $screenType}';
  }
}

/// generated route for
/// [_i40.SkillFilter]
class SkillFilter extends _i48.PageRouteInfo<void> {
  const SkillFilter({List<_i48.PageRouteInfo>? children})
    : super(SkillFilter.name, initialChildren: children);

  static const String name = 'SkillFilter';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i41.SkillSetDetailsScreen]
class SkillSetDetailsRoute
    extends _i48.PageRouteInfo<SkillSetDetailsRouteArgs> {
  SkillSetDetailsRoute({
    required List<_i59.SkillModel> selectedSkills,
    _i54.Key? key,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         SkillSetDetailsRoute.name,
         args: SkillSetDetailsRouteArgs(
           selectedSkills: selectedSkills,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'SkillSetDetailsRoute';

  static const _i48.PageInfo<SkillSetDetailsRouteArgs> page =
      _i48.PageInfo<SkillSetDetailsRouteArgs>(name);
}

class SkillSetDetailsRouteArgs {
  const SkillSetDetailsRouteArgs({required this.selectedSkills, this.key});

  final List<_i59.SkillModel> selectedSkills;

  final _i54.Key? key;

  @override
  String toString() {
    return 'SkillSetDetailsRouteArgs{selectedSkills: $selectedSkills, key: $key}';
  }
}

/// generated route for
/// [_i42.SplashScreen]
class SplashRoute extends _i48.PageRouteInfo<void> {
  const SplashRoute({List<_i48.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i43.StCoinInfo]
class StCoinInfo extends _i48.PageRouteInfo<void> {
  const StCoinInfo({List<_i48.PageRouteInfo>? children})
    : super(StCoinInfo.name, initialChildren: children);

  static const String name = 'StCoinInfo';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i44.StCoins]
class StCoins extends _i48.PageRouteInfo<StCoinsArgs> {
  StCoins({
    _i49.Key? key,
    bool isFromBottomNav = true,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         StCoins.name,
         args: StCoinsArgs(key: key, isFromBottomNav: isFromBottomNav),
         initialChildren: children,
       );

  static const String name = 'StCoins';

  static const _i48.PageInfo<StCoinsArgs> page = _i48.PageInfo<StCoinsArgs>(
    name,
  );
}

class StCoinsArgs {
  const StCoinsArgs({this.key, this.isFromBottomNav = true});

  final _i49.Key? key;

  final bool isFromBottomNav;

  @override
  String toString() {
    return 'StCoinsArgs{key: $key, isFromBottomNav: $isFromBottomNav}';
  }
}

/// generated route for
/// [_i45.UploadCollegeIdScreen]
class UploadCollegeIdRoute extends _i48.PageRouteInfo<void> {
  const UploadCollegeIdRoute({List<_i48.PageRouteInfo>? children})
    : super(UploadCollegeIdRoute.name, initialChildren: children);

  static const String name = 'UploadCollegeIdRoute';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}

/// generated route for
/// [_i46.VerifyOtpScreen]
class VerifyOtpRoute extends _i48.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i54.Key? key,
    required String email,
    bool isFromForgotPassword = false,
    List<_i48.PageRouteInfo>? children,
  }) : super(
         VerifyOtpRoute.name,
         args: VerifyOtpRouteArgs(
           key: key,
           email: email,
           isFromForgotPassword: isFromForgotPassword,
         ),
         initialChildren: children,
       );

  static const String name = 'VerifyOtpRoute';

  static const _i48.PageInfo<VerifyOtpRouteArgs> page =
      _i48.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.email,
    this.isFromForgotPassword = false,
  });

  final _i54.Key? key;

  final String email;

  final bool isFromForgotPassword;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, email: $email, isFromForgotPassword: $isFromForgotPassword}';
  }
}

/// generated route for
/// [_i47.appliedInternship]
class AppliedInternship extends _i48.PageRouteInfo<void> {
  const AppliedInternship({List<_i48.PageRouteInfo>? children})
    : super(AppliedInternship.name, initialChildren: children);

  static const String name = 'AppliedInternship';

  static const _i48.PageInfo<void> page = _i48.PageInfo<void>(name);
}
