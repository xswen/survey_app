import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_async_list.dart';

class EcpLayerSelectBuilder extends StatelessWidget {
  const EcpLayerSelectBuilder(
      {super.key,
      required this.title,
      this.onBeforePopup,
      required this.updateLayerId,
      required this.layerCode});

  final String title;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) updateLayerId;
  final String layerCode;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;
    Future<String> getLayerName() =>
        db.referenceTablesDao.getEcpLayerName(layerCode);
    return FutureBuilder(
        future: getLayerName(),
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
              searchable: true,
              title: title,
              onBeforePopup: onBeforePopup,
              onChangedFn: updateLayerId,
              asyncItems: (s) => db.referenceTablesDao.ecpLayerNameList,
              selectedItem: text.data ?? "Please select genus");
        });
  }
}
