import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/margins_padding.dart';
import 'popups/popups.dart';

String formatDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

Future<DateTime> datePicker(context, DateTime date) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1950),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100));

  if (pickedDate != null) {
    log("Picked date is: $pickedDate"); //pickedDate output format => 2021-03-10 00:00:00.000
    date = pickedDate;
  }

  return date;
}

class CalendarSelect extends StatelessWidget {
  const CalendarSelect({
    super.key,
    required this.date,
    required this.label,
    required this.onDateSelected,
    this.readOnly,
    this.readOnlyPopup,
  });

  final DateTime date;
  final String label;
  final Function(DateTime) onDateSelected;
  final bool? readOnly;
  final Widget? readOnlyPopup;

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateInput = TextEditingController(
        text: formatDate(date)); // This can be initialized directly

    return Container(
      margin: const EdgeInsets.fromLTRB(kPaddingH, kPaddingV, kPaddingH, 0),
      child: Center(
        child: TextField(
          controller: dateInput,
          decoration: InputDecoration(
            icon:
                const Icon(FontAwesomeIcons.calendarDay), // Icon of text field
            labelText: tr(label), // Label text of field
          ),
          readOnly: true, // Set it true, so user will not be able to edit text
          onTap: () async {
            if (readOnly ?? false) {
              if (readOnlyPopup != null) {
                Popups.show(context,
                    readOnlyPopup!); // Assuming Popups.show is defined somewhere
              }
            } else {
              DateTime newDate = await datePicker(context, date);
              onDateSelected(newDate);
            }
          },
        ),
      ),
    );
  }
}

// class CalendarSelect extends StatefulWidget {
//   const CalendarSelect(
//       {super.key,
//       required this.date,
//       required this.label,
//       required this.onDateSelected,
//       this.readOnly,
//       this.readOnlyPopup});
//
//   final DateTime date;
//   final String label;
//   final Function onDateSelected;
//   final bool? readOnly;
//   final Widget? readOnlyPopup;
//
//   @override
//   State<CalendarSelect> createState() => _CalendarSelectState();
// }
//
// class _CalendarSelectState extends State<CalendarSelect> {
//   final TextEditingController dateInput = TextEditingController();
//   late DateTime selectedDate;
//
//   @override
//   void initState() {
//     dateInput.text = formatDate(widget.date);
//     selectedDate = widget.date;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.fromLTRB(kPaddingH, kPaddingV, kPaddingH, 0),
//         child: Center(
//             child: TextField(
//           controller: dateInput,
//           //editing controller of this TextField
//           decoration: InputDecoration(
//               icon:
//                   const Icon(FontAwesomeIcons.calendarDay), //icon of text field
//               labelText: tr(widget.label) //label text of field
//               ),
//           readOnly: true,
//           //set it true, so that user will not able to edit text
//           onTap: () async {
//             bool readOnly = widget.readOnly ?? false;
//
//             if (readOnly) {
//               widget.readOnlyPopup != null
//                   ? Popups.show(context, widget.readOnlyPopup!)
//                   : null;
//             } else {
//               DateTime date = await datePicker(context, widget.date);
//
//               setState(() {
//                 dateInput.text = formatDate(date);
//                 selectedDate = date;
//                 widget.onDateSelected(date);
//               });
//             }
//           },
//         )));
//   }
// }
