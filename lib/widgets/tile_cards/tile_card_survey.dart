import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey_app/enums/enums.dart';

class TileCardSurvey extends StatelessWidget {
  const TileCardSurvey(
      {super.key,
      required this.title,
      this.subtitle,
      required this.onNotAssessed,
      required this.onPressed,
      this.status});

  final String title;
  final String? subtitle;
  final SurveyStatus? status;
  final void Function() onNotAssessed;
  final void Function() onPressed;

  Color generateColour(SurveyStatus? status) {
    switch (status) {
      case SurveyStatus.notStarted:
        return Colors.blueGrey;
      case SurveyStatus.inProgress:
        return Colors.blue;
      case SurveyStatus.complete:
        return Colors.grey;
      case SurveyStatus.notAssessed:
        return Colors.teal;
      default:
        //Default button colour
        return Colors.indigo;
    }
  }

  String getStatusSubtitle(SurveyStatus? status) {
    switch (status) {
      case SurveyStatus.notStarted:
        return "Not Started";
      case SurveyStatus.inProgress:
        return "In Progress";
      case SurveyStatus.complete:
        return "Complete";
      case SurveyStatus.notAssessed:
        return "Not Assessed";
      default:
        //Case
        return "Error trying to get status";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // startActionPane: ActionPane(
      //   motion: const ScrollMotion(),
      //   children: [
      //     SlidableAction(
      //       onPressed: (context) {},
      //       backgroundColor: Colors.teal,
      //       foregroundColor: Colors.white,
      //       icon: FontAwesomeIcons.circleXmark,
      //       label: 'Mark as not assessed',
      //     ),
      //   ],
      // ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.circleXmark,
            label: 'Mark as not assessed',
          ),
        ],
      ),
      child: Card(
        color: generateColour(status),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(subtitle ?? getStatusSubtitle(status)),
          onTap: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
