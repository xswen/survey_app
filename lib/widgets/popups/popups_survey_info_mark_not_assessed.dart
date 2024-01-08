import '../../barrels/page_imports_barrel.dart';

class PopupsSurveyInfoMarkNotAssessed extends StatelessWidget {
  const PopupsSurveyInfoMarkNotAssessed(
      {super.key, required this.rightBtnOnPressed});

  final void Function() rightBtnOnPressed;

  @override
  Widget build(BuildContext context) {
    return PopupContinue(
      "Warning: Pre-existing data",
      contentText: "There is already data added for this card. Marking as "
          "'Not Assessed' will delete all of this data. "
          "This cannot be undone.\n Are you sure you want to continue?",
      rightBtnOnPressed: rightBtnOnPressed,
    );
  }
}
