import 'package:survey_app/enums/enums.dart';

class SurveyCard {
  SurveyCard(this.category, this.name, this.surveyCardData);

  final SurveyCardCategories category;
  final String name;
  dynamic surveyCardData;
}
