// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/data/models/intership/intership_model.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../export.dart';

class AboutCompany extends StatelessWidget {
  const AboutCompany({
    super.key,
    required this.companyDescription,
  });

  final String companyDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          text1: "About Company",
          fontsize: 16,
          labelfontWeight: FontWeight.w700,
          labelColor: AppColors.primary,
        ),
        const Vspace(9),
        Linkify(
          onOpen: (link) async {
            if (await canLaunchUrl(Uri.parse(link.url))) {
              await launchUrl(Uri.parse(link.url));
            } else {
              throw 'Could not launch $link';
            }
            // context.router.push(InAppWeb(url: link.url));
          },
          text: companyDescription,
          style: AppTheme.bodyText3,
          linkStyle: TextStyle(color: AppColors.primary),
        ),
      ],
    );
  }
}

class JobDescription extends StatelessWidget {
  const JobDescription({
    Key? key,
    required this.internshipModel,
  }) : super(key: key);
  final InternshipModel? internshipModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          text1: "Description",
          fontsize: 16,
          labelfontWeight: FontWeight.w700,
          labelColor: AppColors.primary,
        ),
        const Vspace(9),
        Linkify(
          onOpen: (link) async {
            if (await canLaunchUrl(Uri.parse(link.url))) {
              await launchUrl(Uri.parse(link.url));
            } else {
              throw 'Could not launch $link';
            }
            // context.router.push(InAppWeb(url: link.url));
          },
          text: internshipModel?.description ?? "",
          style: AppTheme.bodyText3,
          linkStyle: TextStyle(color: AppColors.primary),
        ),
        const Vspace(15),
        const Label(
          text1: "Skills Required",
          fontsize: 16,
          labelfontWeight: FontWeight.w700,
          labelColor: AppColors.primary,
        ),
        const Vspace(15),
        if (internshipModel?.skills != null &&
            internshipModel!.skills!.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: internshipModel!.skills!
                .map(
                  (e) => UnselectedChip(
                    text: e.name,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 25)
                            .r,
                    color: AppColors.primary,
                  ),
                )
                .toList(),
          ),
          const Vspace(29),
        ],
        // const Label(
        //   text1: "Roles and Responsibilities",
        //   fontsize: 16,
        //   labelfontWeight: FontWeight.w700,
        //   labelColor: AppColors.primary,
        // ),
        // const Vspace(9),
        // Text(
        //   "Work on user research and user experience for both web and mobile platforms. Work on the following technologies and software including Figma, Sketch, HTML, CSS, Adobe creative suite.",
        //   style: AppTheme.bodyText3,
        // ),
      ],
    );
  }
}

class DualImageWithTextRow extends StatelessWidget {
  const DualImageWithTextRow({
    Key? key,
    required this.text,
    required this.imagePath,
  }) : super(key: key);

  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          color: AppColors.primary,
          height: 15.h,
          width: 17.h,
          fit: BoxFit.contain,
        ),
        const Hspace(7),
        Expanded(
          child: Text(
            text,
            style: AppTheme.bodyText3.copyWith(
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
