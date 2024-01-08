import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/widgets/tile_cards/tile_cards.dart';

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
      enabled:
          status != SurveyStatus.notAssessed && status != SurveyStatus.complete,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onNotAssessed();
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.circleXmark,
            label: 'Mark as not assessed',
          ),
        ],
      ),
      child: Card(
        color: TileCards.getStatusColour(status),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(subtitle ?? TileCards.getStatusSubtitle(status)),
          onTap: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
