import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey_app/enums/enums.dart';

import 'tile_cards.dart';

class TileCardTransect extends StatelessWidget {
  const TileCardTransect(
      {super.key,
      required this.title,
      this.subtitle,
      required this.onPressed,
      this.status,
      required this.onDelete});

  final String title;
  final String? subtitle;
  final SurveyStatus? status;
  final void Function() onPressed;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: status != SurveyStatus.complete,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.trash,
            label: 'Delete',
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
