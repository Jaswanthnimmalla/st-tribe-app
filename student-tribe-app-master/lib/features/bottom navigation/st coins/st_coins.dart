// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/presentation/widgets/app_dilogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/data/models/stcoin.dart';
import '../export.dart';

@RoutePage()
class StCoins extends StatefulWidget {
  const StCoins({super.key, this.isFromBottomNav = true});
  final bool isFromBottomNav;

  @override
  State<StCoins> createState() => _StCoinsState();
}

class _StCoinsState extends State<StCoins> {
  List<StcoinModel> stCoinsHistory = [];
  String stCoins = "";
  int pageSize = 1;
  String currentSelectedTag = "all";

  List<String> tags = [
    'all',
    'regular',
    'event',
    'group-buy-in',
    'daily-login',
    'referral',
    // 'money-spent',
    // 'bonus',
    'comment',
    'article',
  ];

  @override
  void initState() {
    callStCoinsHistory();
    super.initState();
  }

  Future<void> _fetchMore() async {
    pageSize = pageSize + 1;
    callStCoinsHistory();
  }

  void callStCoinsHistory() {
    if (currentSelectedTag == "all") {
      context.read<ProfileBloc>().add(
        GetStCoinsTransActionHistoryEvent({
          "page": pageSize.toString(),
          "limit": 10,
        }),
      );
    } else {
      context.read<ProfileBloc>().add(
        GetStCoinsTransActionHistoryEvent({
          "tag": currentSelectedTag,
          "page": pageSize.toString(),
          "limit": 10,
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarN(
        text: "Your St. coins ",
        isLeadingIconReq: widget.isFromBottomNav,
        action: [
          //create a popup menu button based on list of String
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_alt_outlined),
            onSelected: (String result) {
              setState(() {
                currentSelectedTag = result;
                pageSize = 1;
                stCoinsHistory.clear();
                callStCoinsHistory();
              });
            },
            itemBuilder: (BuildContext context) {
              // Create a list of PopupMenuEntry<String> from the tags
              return tags.map<PopupMenuEntry<String>>((tag) {
                return PopupMenuItem<String>(
                  value: tag,
                  child: Text(tag[0].toUpperCase() + tag.substring(1)),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            showOverlayLoader(context);
          } else if (state is GetStCoinsTransActionHistorySuccessFull) {
            hideOverlayLoader(context);
            setState(() {
              stCoinsHistory.addAll(state.stCoinsHistory);
            });
          } else if (state is ProfileErrorState) {
            hideOverlayLoader(context);
            showErrorSnackbar(context, state.error);
          }
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.extentAfter == 0) {
              if (notification.metrics.atEdge) {
                bool isTop = notification.metrics.pixels == 0;
                if (isTop) {
                  print('At the top');
                } else {
                  print('At the bottom');

                  _fetchMore();
                }
              }
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 29,
                  ),
                  color: const Color(0xFFCC202E),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'st. coins',
                        style: AppTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF721119),
                        ),
                      ),
                      Text(
                        'Balance',
                        style: AppTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF721119),
                          fontSize: 42,
                        ),
                      ),
                      const Vspace(13),
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(AppImages.coinbg),
                              Image.asset(AppImages.rupee),
                            ],
                          ),
                          const Hspace(7),
                          Text(
                            "${context.read<ProfileBloc>().userModel?.stCoins ?? ''} coins",
                            style: AppTheme.bodyText1.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Expanded(child: Hspace(0)),
                          PrimaryButton(
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
                            fontsize: 15,
                            padding: EdgeInsets.zero,
                            innerPadding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 10,
                              ),
                            ),
                            fontWeight: FontWeight.w700,
                            icon: Image.asset(AppImages.stsolid),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const Vspace(20),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Text(
                //     "Today",
                //     style: AppTheme.bodyText2
                //         .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                //   ),
                // ),
                const Vspace(14),
                GestureDetector(
                  onTap: () {
                    context.router.push(StCoinInfo());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1.00, 0.06),
                        end: Alignment(-1, -0.06),
                        colors: [Color(0xFF77030C), Color(0xFFCC202E)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.bigstcoins,
                          height: 51,
                          width: 51,
                        ),
                        Hspace(7),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Learn How to Earn St. Coins",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Vspace(6),
                              Text(
                                "Discover how you can accumulate and use St. Coins across our offerings.",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: Color(0xFFF7C9CC),
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Hspace(18),
                        SvgPicture.asset(AppImages.forwardArrowSvg),
                      ],
                    ),
                  ),
                ),
                const Vspace(24),
                ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CommonStRow(stcoinModel: stCoinsHistory[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const Vspace(10);
                  },
                  itemCount: stCoinsHistory.length,
                ),
                const Vspace(14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class CommonStRow extends StatelessWidget {
  const CommonStRow({Key? key, required this.stcoinModel}) : super(key: key);

  final StcoinModel stcoinModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x1ECC202E),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stcoinModel.description ?? "",
                  maxLines: 2,
                  style: AppTheme.bodyText3.copyWith(),
                ),
                const Vspace(6),
                Text(
                  'Date: ${DateFormat("dd/MM/yyyy").format(DateTime.parse(stcoinModel.createdAt!))}${stcoinModel.rzpTransactionId != null ? '\nTransaction ID: ${stcoinModel.rzpTransactionId}' : ''}',
                  style: AppTheme.bodyText3.copyWith(
                    fontSize: 10,
                    color: const Color(0xFF6C6C6C),
                  ),
                ),
              ],
            ),
          ),
          stcoinModel.amount! > 0
              ? Text(
                  "+ ${stcoinModel.amount ?? ""}",
                  style: AppTheme.bodyText3.copyWith(
                    fontSize: 26,
                    color: const Color(0xFF259D1B),
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "- ${stcoinModel.amount!.abs()}",
                  style: AppTheme.bodyText3.copyWith(
                    fontSize: 26,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ],
      ),
    );
  }
}
