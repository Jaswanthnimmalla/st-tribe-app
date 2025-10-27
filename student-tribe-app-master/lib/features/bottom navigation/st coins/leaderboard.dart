// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/data/models/leaderboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/presentation/widgets/app_dilogs.dart';
import '../export.dart';

@RoutePage()
class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  String stCoins = "";
  List<LeaderBoardModel>? leaderBoardList;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetLeaderBoardEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "St. Coins",
          style: AppTheme.bodyText3.copyWith(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              context.router.push(SearchRoute(screenType: "Home"));
            },
            child: const Icon(Icons.search),
          ),
          const Hspace(19),
          Center(
            child: PrimaryButton(
              text: "Purchase",
              onTap: () {
                showStCoinDilog(
                  cancelTap: () {
                    context.router.pop();
                  },
                  context: context,
                  onChange: (p0) {
                    stCoins = p0;
                  },
                  purchaseTap: () {
                    if (stCoins.isEmpty) return;
                    context.router.push(
                      BuyTicketRoute(
                        totalPrice: int.parse(stCoins) / 10,
                        screenType: ScreenType.STCOINS,
                        stPointQuantity: int.parse(stCoins),
                      ),
                    );
                  },
                );
              },
              color: Colors.white,
              textColor: const Color(0xFFCA202F),
              fontsize: 12,
              padding: EdgeInsets.zero,
              innerPadding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              fontWeight: FontWeight.w700,
              icon: Image.asset(AppImages.stsolid),
            ),
          ),
          const Hspace(17),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            showOverlayLoader(context);
          } else if (state is GetLeaderBoardSuccessFullState) {
            hideOverlayLoader(context);
            setState(() {
              leaderBoardList = state.leaderBoardList;
            });
          } else if (state is ProfileErrorState) {
            hideOverlayLoader(context);
            showErrorSnackbar(context, state.error);
          }
        },
        child: leaderBoardList == null
            ? Container()
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/confetti.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (leaderBoardList!.length > 1)
                          Positioned(
                            left: 49.w,
                            child: CustomLearboardCircle(
                              coins:
                                  leaderBoardList?[1].stCoins.toString() ?? "",
                              text: "${leaderBoardList?[1].name}",
                              imageUrl: leaderBoardList?[1].profileImg ?? "",
                              color: const Color(0xff4080FF),
                            ),
                          ),
                        if (leaderBoardList!.length > 2)
                          Positioned(
                            right: 49.w,
                            child: CustomLearboardCircle(
                              coins:
                                  leaderBoardList?[2].stCoins.toString() ?? "",
                              text: "${leaderBoardList?[2].name}",
                              imageUrl: leaderBoardList?[2].profileImg ?? "",
                              color: const Color(0xffFFCC16),
                            ),
                          ),
                        if (leaderBoardList!.isNotEmpty)
                          Positioned(
                            top: 20.h,
                            child: IntrinsicHeight(
                              child: CustomLearboardCircle(
                                coins:
                                    leaderBoardList?[0].stCoins.toString() ??
                                    "",
                                text: "${leaderBoardList?[0].name}",
                                imageUrl: leaderBoardList?[0].profileImg ?? "",
                                color: const Color(0xffFF5E6D),
                                showCrown: true,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x1E000000),
                            blurRadius: 20,
                            offset: Offset(0, -4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      // alignment: Alignment.bottomCenter,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 24,
                        ),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              const Hspace(20),
                              Text(
                                '#${index + 4}',
                                style: AppTheme.bodyText3.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const Hspace(27),
                              Expanded(
                                child: Text(
                                  leaderBoardList?[index + 3].name ?? "",
                                  style: AppTheme.bodyText3.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Image.asset(
                                AppImages.stcoins,
                                height: 14,
                                width: 14,
                              ),
                              const Hspace(6),
                              Text(
                                "${leaderBoardList?[index + 3].stCoins ?? ""}",
                                style: AppTheme.bodyText3.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 20,
                            color: Color(0xffD9D9D9),
                          );
                        },
                        itemCount: leaderBoardList?.skip(3).length ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class CustomLearboardCircle extends StatelessWidget {
  const CustomLearboardCircle({
    Key? key,
    required this.imageUrl,
    required this.text,
    required this.coins,
    required this.color,
    this.showCrown = false,
  }) : super(key: key);
  final String imageUrl;
  final String text;
  final String coins;
  final bool showCrown;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showCrown) Image.asset(AppImages.crown),
          const Vspace(5),
          CircleAvatar(
            radius: 55,
            backgroundColor: color,
            child: CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(imageUrl),
            ),
          ),
          const Vspace(11),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.bodyText3.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.stcoins, height: 10.h, width: 10.w),
              const Hspace(2),
              Text(
                coins,
                style: AppTheme.bodyText3.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
