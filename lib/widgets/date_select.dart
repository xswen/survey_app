import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/margins_padding.dart';
import 'popups/popup_dismiss.dart';

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

class CalendarSelect extends StatefulWidget {
  const CalendarSelect(
      {super.key,
      required this.date,
      required this.label,
      required this.setStateFn,
      this.readOnly,
      this.readOnlyPopup});

  final DateTime date;
  final String label;
  final Function setStateFn;
  final bool? readOnly;
  final PopupDismiss? readOnlyPopup;

  @override
  State<CalendarSelect> createState() => _CalendarSelectState();
}

class _CalendarSelectState extends State<CalendarSelect> {
  final TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = formatDate(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(kPaddingH, kPaddingV, kPaddingH, 0),
        child: Center(
            child: TextField(
          controller: dateInput,
          //editing controller of this TextField
          decoration: InputDecoration(
              icon:
                  const Icon(FontAwesomeIcons.calendarDay), //icon of text field
              labelText: widget.label //label text of field
              ),
          readOnly: true,
          //set it true, so that user will not able to edit text
          onTap: () async {
            bool readOnly = widget.readOnly ?? false;

            if (readOnly) {
              widget.readOnlyPopup != null
                  ? Get.dialog(widget.readOnlyPopup as Widget)
                  : null;
            } else {
              DateTime date = await datePicker(context, widget.date);

              setState(() {
                dateInput.text = formatDate(date);
                widget.setStateFn(date);
              });
            }
          },
        )));
  }
}
