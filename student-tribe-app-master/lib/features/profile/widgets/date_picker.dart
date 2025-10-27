import 'package:architecture/core/constants/images.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/widgets/app_datepicker.dart';
import '../../../core/presentation/widgets/border_textfield.dart';

class ProfileDatePicker extends StatelessWidget {
  ProfileDatePicker({
    Key? key,
    required this.controller,
    required this.updateState,
    required this.hint,
    this.minDate,
    this.maxDate,
    DateTime? selectedDate,
  })  : selectedDate = selectedDate ?? DateTime(2020, 9, 8),
        super(key: key);
  final TextEditingController controller;
  final Function() updateState;
  final String hint;
  final DateTime selectedDate;

  final DateTime? minDate;
  final DateTime? maxDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("Date");
        showDatePickerBottomSheet(context, (p0) {
          controller.text = p0.toString();
          updateState();
        }, selectedDate, maxDate: maxDate, minDate: minDate);
      },
      child: AbsorbPointer(
        absorbing: true,
        child: BorderedTextFormField(
          controller: controller,
          hintText: hint,
          underlinedBorder: true,
          suffix: Image.asset(AppImages.calendra),
        ),
      ),
    );
  }
}
