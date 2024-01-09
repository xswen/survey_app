import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:survey_app/constants/margins_padding.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/widgets/date_select.dart';

class TitleCardDashboard extends StatelessWidget {
  const TitleCardDashboard(
      {super.key,
      required this.surveyHeader,
      required this.onTap,
      required this.onDelete});

  final SurveyHeader surveyHeader;
  final void Function() onTap;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kPaddingV / 2, horizontal: kPaddingH),
      child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => onDelete(),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
              color: surveyHeader.complete ? Colors.grey : Colors.blue,
              child: ListTile(
                onTap: onTap,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        surveyHeader.province,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  'Plot ${surveyHeader.nfiPlot} \nMeas ${surveyHeader.measNum}',
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(formatDate(surveyHeader.measDate)),
                trailing: Text(
                    surveyHeader.complete ? "Complete" : "In Progress",
                    style: const TextStyle(color: Colors.white)),
              ))),
    );
  }
}
