// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
// Moved import to the top
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../bottom_navigation.dart';
import '../export.dart';

@RoutePage()
class ReferFriend extends StatefulWidget {
  const ReferFriend({super.key});

  @override
  State<ReferFriend> createState() => _ReferFriendState();
}

class _ReferFriendState extends State<ReferFriend> {
  String sharedLink = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      callProfileApi();
    });
    super.initState();
  }

  callProfileApi() {
    context.read<ProfileBloc>().add(const GetMyProfileEvent());
  }

  Future<dynamic> createLink() async {
    showOverlayLoader(context);
    sharedLink = await generateLink(
      context,
      BranchUniversalObject(
        canonicalIdentifier: 'studenttribebranch/app',
        title:
            "Refer a friend and earn 50 ST.Coins for each successful referral.Share now and win together.",
        contentDescription: 'Refer a friend link',
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata(
            'referId',
            context.read<ProfileBloc>().userModel?.id ?? "",
          ),
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch,
      ),
      BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
      ),
      false,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Refer a friend",
          style: AppTheme.bodyText3.copyWith(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            context.router.pop();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          StCoinsWidget(
            text: "${(context.read<ProfileBloc>().userModel?.stCoins ?? 0)}",
            onTap: () {
              context.router.push(StCoins());
            },
          ),
          const Hspace(17),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoadingState) {
              showOverlayLoader(context);
            } else if (state is GetMyProfileSuccessFullState) {
              hideOverlayLoader(context);
              setState(() {
                if (state.userModel.referralLink != null &&
                    state.userModel.referralLink!.isNotEmpty) {
                  sharedLink = state.userModel.referralLink!;
                } else {
                  createLink().then((value) {
                    FormData formData = FormData.fromMap({
                      "referralLink": sharedLink,
                    });
                    context.read<ProfileBloc>().add(
                      UpdateProfileEvent(formData: formData),
                    );
                  });
                }
              });
            } else if (state is ProfileErrorState) {
              hideOverlayLoader(context);
              showErrorSnackbar(context, state.error);
            } else if (state is UpdateProfileSuccessState) {
              hideOverlayLoader(context);
              callProfileApi();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 195,
                decoration: ShapeDecoration(
                  color: const Color(0xFFCC202E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: Column(
                  children: [
                    const Vspace(16),
                    Text(
                      'You and your colleague will get',
                      style: AppTheme.bodyText3.copyWith(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
                    ),
                    const Vspace(6),
                    Text(
                      '1 Referral = 50 St. Coins',
                      style: AppTheme.bodyText3.copyWith(
                        fontSize: 18,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Vspace(14),
                    Row(
                      children: [
                        const Expanded(
                          child: CommonReferImageWidget(
                            imgPath: AppImages.first,
                            text: 'Refer a colleague',
                          ),
                        ),
                        Image.asset(AppImages.arrow),
                        const Expanded(
                          child: CommonReferImageWidget(
                            imgPath: AppImages.second,
                            text: 'Both users get 50 St. coins',
                          ),
                        ),
                        Image.asset(AppImages.arrow),
                        const Expanded(
                          child: CommonReferImageWidget(
                            imgPath: AppImages.third,
                            text: 'Enjoy amazing benefits on our platform',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Vspace(24),
              Text('REFERAL LINK', style: AppTheme.bodyText2),
              const Vspace(12),
              ColoredBox(color: const Color(0xFFFFEEEF)),
              const Vspace(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: "Copy Link",
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(text: sharedLink),
                          );
                          showSnackbar(context, 'Copy successfully');
                        },
                        frontIconWidth: 6.w,
                        borderRadius: 8,
                        frontIcon: const Icon(Icons.copy),
                        padding: EdgeInsets.zero,
                        innerPadding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                    const Hspace(16),
                    Expanded(
                      child: PrimaryButton(
                        text: "Share Link",
                        onTap: () {
                          Share.share(sharedLink);
                        },
                        borderRadius: 8,
                        frontIcon: const Icon(Icons.share),
                        frontIconWidth: 6.w,
                        padding: EdgeInsets.zero,
                        innerPadding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class CommonReferImageWidget extends StatelessWidget {
  const CommonReferImageWidget({
    Key? key,
    required this.imgPath,
    required this.text,
  }) : super(key: key);

  final String imgPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imgPath),
        const Vspace(6),
        Text(
          text,
          textAlign: TextAlign.center,
          style: AppTheme.bodyText3.copyWith(
            fontSize: 10,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
