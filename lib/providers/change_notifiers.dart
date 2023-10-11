import 'package:flutter/cupertino.dart';

class UpdateNotifierSurveyInfo extends ChangeNotifier {
  bool _shouldRebuild = false;

  bool get shouldRebuild => _shouldRebuild;

  void triggerRebuild() {
    _shouldRebuild = true;
    notifyListeners();
  }

  void resetRebuild() {
    _shouldRebuild = false;
    notifyListeners();
  }
}
