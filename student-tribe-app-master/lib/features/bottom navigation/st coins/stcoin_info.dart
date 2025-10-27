// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../core/data/models/stcoin.dart';
import '../export.dart';

@RoutePage()
class StCoinInfo extends StatefulWidget {
  const StCoinInfo({super.key});

  @override
  State<StCoinInfo> createState() => _StCoinInfoState();
}

class _StCoinInfoState extends State<StCoinInfo> {
  List<StcoinModel> stCoinsHistory = [];
  List<StcoinModel> filterList = [];
  String stCoins = "";

  @override
  void initState() {
    super.initState();
    // context.read<ProfileBloc>().add(GetStCoinsTransActionHistoryEvent());
  }

  List<Map<String, String>> data = [
    {
      "title": "Refer a Friend",
      "subtitle": "Earn 50 St. Coins by Referring a Friend.",
      "coins": "50",
    },
    {
      "title": "Profile Completion",
      "subtitle": "Complete your profile and Earn 30 St. Coins.",
      "coins": "30",
    },
    {
      "title": "Comment on Articles",
      "subtitle": "By Commenting on an Article, Earn 1 St. Coin.",
      "coins": "1",
    },
    {
      "title": "Daily App Login",
      "subtitle": "Login Daily to Earn 1 St. Coin.",
      "coins": "1",
    },
    {
      "title": "St. Coins Purchase",
      "subtitle": "Buy 100 INR worth of St. Coins and Earn 5 extra St. Coins.",
      "coins": "5",
    },
    // {
    //   "title": "Upload an Article",
    //   "subtitle":
    //       "Upload an article on the platform and earn 100 points for your upload",
    //   "coins": "100"
    // }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarN(text: "Your St. coins "),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            showOverlayLoader(context);
          } else if (state is GetStCoinsTransActionHistorySuccessFull) {
            hideOverlayLoader(context);
            setState(() {
              stCoinsHistory = state.stCoinsHistory;
            });
          } else if (state is ProfileErrorState) {
            hideOverlayLoader(context);
            showErrorSnackbar(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Reward Points',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Vspace(16),
              ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CommonStInfoRow(
                    title: data[index]["title"]!,
                    subtitle: data[index]["subtitle"]!,
                    coins: data[index]["coins"]!,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Vspace(10);
                },
                itemCount: data.length,
              ),
              const Vspace(14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Utilization',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Vspace(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonStInfoRow(
                  title: "Make the most of your points!",
                  subtitle:
                      "Redeem them for enriching workshops, events, and access to exclusive paid communities that foster growth. Every 1 st. coin equals 1 paisa, amplifying the value of your rewards for various platform offerings.",
                  coins: "",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonStInfoRow extends StatelessWidget {
  const CommonStInfoRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.coins,
  });

  final String title;
  final String subtitle;
  final String coins;

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
                  title,
                  maxLines: 2,
                  style: AppTheme.bodyText3.copyWith(fontSize: 14),
                ),
                const Vspace(6),
                Text(
                  subtitle,
                  style: AppTheme.bodyText3.copyWith(
                    fontSize: 10,
                    color: const Color(0xFF6C6C6C),
                  ),
                ),
              ],
            ),
          ),
          if (coins.isNotEmpty) ...[
            Hspace(28),
            Column(
              children: [
                Text(
                  "${coins}",
                  style: AppTheme.bodyText3.copyWith(
                    fontSize: 22,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "coins",
                    style: AppTheme.bodyText3.copyWith(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
