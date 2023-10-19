import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../builders/set_transect_num_builder.dart';

class PopupCreateTransect extends StatelessWidget {
  const PopupCreateTransect(
      {super.key,
      required this.getUsedTransNums,
      this.name = "Transect",
      this.hideTitle = true,
      required this.selectedItem,
      required this.transList,
      this.onBeforePopup,
      required this.updateTransNum,
      required this.onSave});

  final Future<List<int?>> getUsedTransNums;
  final String name;
  final bool hideTitle;
  final String selectedItem;
  final List<String> transList;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(int) updateTransNum;
  final void Function() onSave;

  @override
  PopupContinue build(BuildContext context) {
    return PopupContinue(
      "Select $name Number",
      contentWidget: Card(
        elevation: 0,
        color: Colors.transparent,
        child: SetTransectNumBuilder(
          name: name,
          hideTitle: true,
          getUsedTransNums: getUsedTransNums,
          startingTransNum: '',
          selectedItem: selectedItem.isNotEmpty
              ? selectedItem
              : "Please select a ${name.toLowerCase()} number",
          transList: transList,
          updateTransNum: updateTransNum,
        ),
      ),
      rightBtnOnPressed: onSave,
    );
  }
}
