// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:architecture/core/data/models/article.dart';
import 'package:architecture/core/data/models/groupbyin.dart';
import 'package:architecture/core/presentation/widgets/popup_menu.dart';

import 'package:html/parser.dart';

import '../export.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;

  const ArticleCard({
    required this.article,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: SizedBox(
        // height: 116,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 106.w,
              height: 116.h,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(article.thumbnailImg.isEmpty
                      ? "https://via.placeholder.com/106x111"
                      : article.thumbnailImg),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            const Hspace(10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        article.tag != null
                            ? Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 3),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.primary,
                                ),
                                child: Text(
                                  article.tag!,
                                  style: AppTheme.bodyText3.copyWith(
                                      fontSize: ScreenUtil().setSp(10),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            // UnselectedChip(
                            //     text: article.tag!,
                            //     color: AppColors.primary,
                            //   )
                            : Container(),
                        Text(
                          DateFormat("MMM d, yyyy")
                              .format(article.createdAt.toLocal()),
                          style: AppTheme.bodyText3.copyWith(
                              fontSize: 10.sp, color: const Color(0xFF676767)),
                        )
                      ],
                    ),
                    const Vspace(8),
                    Text(
                      parse(article.title).body?.text ?? '',
                      style: AppTheme.bodyText3
                          .copyWith(fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Vspace(6),
                    AvatarImageWithName(
                      author: article.author,
                    ),
                  ],
                ),
                const Vspace(8),
                Row(
                  children: [
                    Image.asset(AppImages.heart),
                    const Hspace(3),
                    Text(
                      "${article.likes.length}",
                      style: AppTheme.bodyText3.copyWith(
                          fontSize: 10.sp, color: const Color(0xFF676767)),
                    ),
                    const Hspace(13),
                    Image.asset(AppImages.comment),
                    const Hspace(3),
                    Text(
                      "${article.commentsCount}",
                      style: AppTheme.bodyText3.copyWith(
                          fontSize: 10.sp, color: const Color(0xFF676767)),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class GroupBuyInCard extends StatelessWidget {
  const GroupBuyInCard({
    Key? key,
    required this.groupByInModel,
  }) : super(key: key);

  final GroupByInModel groupByInModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: !(groupByInModel.status != "available" ||
                DateTime.parse(groupByInModel.offerEndDate!)
                    .toLocal()
                    .isBefore(DateTime.now().toLocal()) ||
                groupByInModel.sold >= groupByInModel.target)
            ? Colors.white
            : Color(0xffe0e0e0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              groupByInModel.coverImg == null
                  ? SizedBox.fromSize()
                  : Container(
                      width: 112,
                      height: 122,
                      padding: const EdgeInsets.only(top: 15),
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(groupByInModel.coverImg!),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 2),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Text(
                            '${(((groupByInModel.originalPrice! - groupByInModel.discountedPrice!) / groupByInModel.originalPrice!) * 100).toStringAsFixed(0)}% OFF',
                            style: AppTheme.bodyText2.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
              const Hspace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: LinearProgressIndicator(
                                  minHeight: 20,
                                  backgroundColor: const Color(0xffCBCBCB),
                                  value: max<num>(groupByInModel.target * 0.04,
                                          groupByInModel.sold) /
                                      groupByInModel.target,
                                ),
                              ),
                              Center(
                                child: Text(
                                  groupByInModel.sold >= groupByInModel.target
                                      ? "SOLD OUT"
                                      : "${groupByInModel.sold} Sold",
                                  style: AppTheme.bodyText3.copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                        if (groupByInModel.status == "cancelled" ||
                            (DateTime.parse(groupByInModel.offerEndDate!).toLocal()
                                .isBefore(DateTime.now().toLocal()))) ...[
                          Hspace(29),
                          Text(
                            "EXPIRED",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary),
                          )
                        ],
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   padding: EdgeInsets.only(
                        //       top: 2, bottom: 2.5, left: 30, right: 1),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //           colors: [
                        //             Color(0xffCC202E),
                        //             Color(0xffCC202E).withOpacity(0.5),
                        //           ],
                        //           begin: Alignment.centerLeft,
                        //           end: Alignment.centerRight)),
                        // child: Text(
                        //   "${groupByInModel.sold ?? ""} Sold",
                        //   style: AppTheme.bodyText3.copyWith(
                        //       fontSize: 12,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w600),
                        // ),
                        // ),
                      ],
                    ),
                    const Vspace(4),
                    Text(
                      groupByInModel.title ?? "",
                      style: AppTheme.bodyText3
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const Vspace(1),
                    Row(
                      children: [
                        Text(
                          formattedCurrency(groupByInModel.discountedPrice!),
                          style: AppTheme.bodyText3.copyWith(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700),
                        ),
                        const Hspace(2),
                        Text(
                          formattedCurrency(groupByInModel.originalPrice!),
                          style: AppTheme.bodyText3.copyWith(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 10,
                              color: const Color(0xFF676767),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Vspace(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Offer till: ${DateFormat('dd MMM, hh:mm a').format(DateTime.parse(groupByInModel.offerEndDate!).toLocal())}",
                          style: AppTheme.bodyText3.copyWith(
                              fontSize: 10.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700),
                        ),
                        // PrimaryButton(
                        //   text: "Buy-in",
                        //   padding: EdgeInsets.zero,
                        //   onTap: () {},
                        //   fontsize: 12,
                        //   innerPadding: MaterialStateProperty.all(
                        //       const EdgeInsets.symmetric(
                        //           vertical: 4, horizontal: 20)),
                        // )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PublishedArticleCard extends StatelessWidget {
  final ArticleModel article;

  const PublishedArticleCard(
    this.article, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: SizedBox(
        child: Row(
          children: [
            article.thumbnailImg.isNotEmpty
                ? Container(
                    width: 106,
                    height: 116,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            // "https://images.unsplash.com/photo-1534423861386-85a16f5d13fd?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            article.thumbnailImg
                            //   ? "https://via.placeholder.com/106x111"
                            //   : article.thumbnailImg
                            ),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  )
                : Container(),
            const Hspace(10),
            Expanded(
                child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            parse(article.title).body?.text ?? '',
                            style: AppTheme.bodyText3
                                .copyWith(fontWeight: FontWeight.w700),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // const Vspace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${DateFormat("MMM d").format(article.createdAt)} ${article.readTime != null ? '- ${article.readTime} min read' : ''}",
                          style: AppTheme.bodyText3.copyWith(
                              fontSize: 14, color: const Color(0xFF676767)),
                        )
                      ],
                    ),
                    const Vspace(6),
                    Row(
                      children: [
                        Image.asset(AppImages.heart),
                        const Hspace(3),
                        Text(
                          "${article.likes.length}",
                          style: AppTheme.bodyText3.copyWith(
                              fontSize: 10, color: const Color(0xFF676767)),
                        ),
                        const Hspace(13),
                        Image.asset(AppImages.comment),
                        const Hspace(3),
                        Text(
                          "${article.commentsCount}",
                          style: AppTheme.bodyText3.copyWith(
                              fontSize: 10, color: const Color(0xFF676767)),
                        ),
                      ],
                    ),
                    const Vspace(22),
                    Text(
                      "${article.viewsCount} Views",
                      style: AppTheme.bodyText3.copyWith(
                          fontSize: 14, color: const Color(0xFF676767)),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CustomPopUpMenuItem(padding: 0, items: [
                    PopupMenuItem<SampleItem>(
                      value: SampleItem.itemOne,
                      child: const Text('Edit Article'),
                      onTap: () {
                        context.router
                            .push(CreateArticle(articleModel: article));
                      },
                    ),
                  ]),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
