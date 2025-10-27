import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';



class SortWidget extends StatelessWidget {
  const SortWidget({
    Key? key,
    required this.sortRowsList,
    required this.clearAll,
    required this.done,
  }) : super(key: key);
  final List<Widget> sortRowsList;
  final Function() clearAll;
  final Function() done;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 38).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sort by",
            style: AppTheme.bodyText2.copyWith(color: const Color(0xFF818181)),
          ),
          const Vspace(20),
          Column(
            children: sortRowsList,
          ),
          const Vspace(50),
          Row(
            children: [
              Expanded(
                child: PrimaryOutlineButton(
                  text: "Clear all",
                  onTap: () {
                    clearAll();
                  },
                  textColor: AppColors.grey,
                  padding: EdgeInsets.zero,
                  outlineColor: const Color(0xFF818181),
                ),
              ),
              const Hspace(12),
              Expanded(
                child: PrimaryButton(
                  text: "Done",
                  onTap: () {
                    done();
                  },
                  padding: EdgeInsets.zero,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget buildRow(String text, bool isChecked, Function(dynamic) onTap) {
  // Initialize with your own logic for checkbox state.
  return ListTile(
    title: Transform.translate(
      offset: const Offset(-16, 0),
      child: Text(
        text,
        style: AppTheme.bodyText2.copyWith(fontWeight: FontWeight.w400),
      ),
    ),
    trailing: Checkbox(
      value: isChecked,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      side: const BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
      activeColor: AppColors.primary,
      focusColor: AppColors.grey,
      onChanged: (dynamic value) {
        onTap(value);
      },
    ),
  );
}