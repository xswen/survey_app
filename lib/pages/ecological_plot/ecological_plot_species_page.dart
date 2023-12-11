import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ecological_plot/ecological_plot_header_page.dart';
import 'package:survey_app/providers/ecological_plot_providers.dart';
import 'package:survey_app/widgets/builders/ecp_genus_select_builder.dart';
import 'package:survey_app/widgets/builders/ecp_layer_select_builder.dart';
import 'package:survey_app/widgets/builders/ecp_species_select_builder.dart';
import 'package:survey_app/widgets/builders/ecp_variety_select_builder.dart';
import 'package:survey_app/widgets/builders/info_popup_builder.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/buttons/delete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../delete_page.dart';

class PlotInfo {
  final String plot;
  final String tenMeterPlot;
  final String fiveMeterPlot;

  PlotInfo(this.plot, this.tenMeterPlot, this.fiveMeterPlot);
}

class PlotDataSource extends DataGridSource {
  final List<DataGridRow> _plotRows = [
    const DataGridRow(cells: [
      DataGridCell<String>(columnName: 'plot', value: 'Plot area'),
      DataGridCell<String>(
          columnName: 'tenMeterPlot', value: '314 m² (0.0314 ha)'),
      DataGridCell<String>(
          columnName: 'fiveMeterPlot', value: '100 m² (0.01 ha)'),
    ]),
    const DataGridRow(cells: [
      DataGridCell<String>(columnName: 'plot', value: '25% coverage'),
      DataGridCell<String>(columnName: 'tenMeterPlot', value: '¼ of the plot'),
      DataGridCell<String>(columnName: 'fiveMeterPlot', value: '¼ of the plot'),
    ]),
    const DataGridRow(cells: [
      DataGridCell<String>(columnName: 'plot', value: '1% coverage'),
      DataGridCell<String>(columnName: 'tenMeterPlot', value: '∼1.8 x 1.8 m'),
      DataGridCell<String>(columnName: 'fiveMeterPlot', value: '1 x 1 m'),
    ]),
    const DataGridRow(cells: [
      DataGridCell<String>(columnName: 'plot', value: '0.1%'),
      DataGridCell<String>(columnName: 'tenMeterPlot', value: '∼55 x 55 cm'),
      DataGridCell<String>(columnName: 'fiveMeterPlot', value: '∼33 x 33 cm'),
    ]),
    const DataGridRow(cells: [
      DataGridCell<String>(columnName: 'plot', value: '0.01%'),
      DataGridCell<String>(columnName: 'tenMeterPlot', value: '∼18 x 18 cm'),
      DataGridCell<String>(columnName: 'fiveMeterPlot', value: '∼10 x 10 cm'),
    ]),
    const DataGridRow(cells: [
      DataGridCell<String>(columnName: 'plot', value: '0.001%'),
      DataGridCell<String>(columnName: 'tenMeterPlot', value: '∼6 x 6 cm'),
      DataGridCell<String>(columnName: 'fiveMeterPlot', value: '∼3 x 3 cm'),
    ]),
    // ... Add the rest of the rows in a similar fashion
  ];

  @override
  List<DataGridRow> get rows => _plotRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
          child: Text(
            row.getCells()[0].value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[1].value.toString()),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[2].value.toString()),
      ),
    ]);
  }
}

class EcologicalPlotSpeciesPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotSpecies";
  final GoRouterState state;
  const EcologicalPlotSpeciesPage(this.state, {super.key});

  @override
  EcologicalPlotSpeciesPageState createState() =>
      EcologicalPlotSpeciesPageState();
}

class EcologicalPlotSpeciesPageState
    extends ConsumerState<EcologicalPlotSpeciesPage> {
  final String title = "Ecological Plot Layer";
  late final int ecpHId;
  late bool moreInfo;
  late EcpSpeciesCompanion layer;

  ColNames colNames = ColNames();

  @override
  void initState() {
    ecpHId = PathParamValue.getEcpHeaderId(widget.state);
    layer = widget.state.extra as EcpSpeciesCompanion;
    moreInfo = false;
    super.initState();
  }

  void addOrUpdateEcpSpecies(void Function() fn) => ref
      .read(databaseProvider)
      .ecologicalPlotTablesDao
      .addOrUpdateSpecies(layer)
      .then((value) => fn());

  void returnToHeader() {
    ref.refresh(ecpSpeciesListProvider(ecpHId));
    context.goNamed(EcologicalPlotHeaderPage.routeName,
        pathParameters:
            PathParamGenerator.ecpHeader(widget.state, ecpHId.toString()));
  }

  void createNewEcpSpeciesCompanion() => ref
          .read(databaseProvider)
          .ecologicalPlotTablesDao
          .getNextSpeciesNum(ecpHId)
          .then((speciesNum) {
        context.pushReplacementNamed(EcologicalPlotSpeciesPage.routeName,
            pathParameters: PathParamGenerator.ecpSpecies(
                widget.state, speciesNum.toString()),
            extra: EcpSpeciesCompanion(
              ecpHeaderId: d.Value(ecpHId),
              speciesNum: d.Value(speciesNum),
            ));
      });

  List<String>? _errorCheck() {
    List<String> results = [];
    if (layer.layerId == const d.Value.absent()) {
      results.add("Missing layer id");
    }
    if (layer.genus == const d.Value.absent()) {
      results.add("Missing genus");
    }
    if (layer.species == const d.Value.absent()) {
      results.add("Missing species");
    }
    if (layer.variety == const d.Value.absent()) {
      results.add("Missing variety");
    }

    String? errorPct = _errorSpeciesPct(
        ref.read(databaseProvider).companionValueToStr(layer.speciesPct));
    if (errorPct != null) results.add("Species %: $errorPct");

    return results.isEmpty ? null : results;
  }

  String? _errorSpeciesPct(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    }
    if (0.001 > double.parse(text) || double.parse(text) > 100) {
      return "Input out of range. Must be between 0.001 to 100 inclusive";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
        appBar: OurAppBar(
          "$title: Species number ${db.companionValueToStr(layer.speciesNum)}",
        ),
        endDrawer: DrawerMenu(onLocaleChange: () {}),
        body: Padding(
          padding: const EdgeInsets.all(kPaddingH),
          child: Center(
            child: ListView(
              children: [
                EcpLayerSelectBuilder(
                    title: "Layer Id",
                    updateLayerId: (s) => setState(
                        () => layer = layer.copyWith(layerId: d.Value(s))),
                    layerCode: db.companionValueToStr(layer.layerId)),
                EcpGenusSelectBuilder(
                    title: "Genus",
                    updateGenus: (genus, species, variety) => setState(() =>
                        layer = layer.copyWith(
                            genus: genus, species: species, variety: variety)),
                    genus: db.companionValueToStr(layer.genus)),
                EcpSpeciesSelectBuilder(
                    title: "Species",
                    updateSpecies: (species, variety) => setState(() => layer =
                        layer.copyWith(species: species, variety: variety)),
                    genus: db.companionValueToStr(layer.genus),
                    species: db.companionValueToStr(layer.species)),
                db.companionValueToStr(layer.species).isNotEmpty &&
                        db.companionValueToStr(layer.species) != "unknown"
                    ? EcpVarietySelectBuilder(
                        title: "Variety",
                        updateVariety: (variety) => setState(
                            () => layer = layer.copyWith(variety: variety)),
                        genus: db.companionValueToStr(layer.genus),
                        species: db.companionValueToStr(layer.species),
                        variety: db.companionValueToStr(layer.variety))
                    : Container(),
                DataInput(
                    title: "Percent cover of this species in this layer",
                    infoPopupIconBuilder: InfoPopupBuilder(
                      popup: AlertDialog(
                        title: const Text(
                          "Percent Cover Table",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: SingleChildScrollView(
                            child: SfDataGrid(
                              verticalScrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              source: PlotDataSource(),
                              columns: <GridColumn>[
                                GridColumn(
                                    columnName: 'plot', label: const Text('')),
                                GridColumn(
                                  columnName: 'tenMeterPlot',
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '10-m radius plot',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                GridColumn(
                                  columnName: 'fiveMeterPlot',
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '5.64-m radius plot',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                              columnWidthMode: ColumnWidthMode.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    boxLabel: "Report to the nearest 0.001%",
                    prefixIcon: FontAwesomeIcons.angleLeft,
                    suffixVal: "%",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: false),
                    startingStr: db.companionValueToStr(layer.speciesPct),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      ThousandsFormatter(allowFraction: true, decimalPlaces: 3),
                    ],
                    onSubmit: (String s) {
                      double? val = double.tryParse(s);
                      val != null
                          ? setState(() =>
                              layer = layer.copyWith(speciesPct: d.Value(val)))
                          : null;
                    },
                    onValidate: _errorSpeciesPct),
                const SizedBox(
                  height: kPaddingV * 2,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: kPaddingV)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          List<String>? errors = _errorCheck();
                          if (errors != null) {
                            Popups.show(
                                context, PopupErrorsFoundList(errors: errors));
                          } else {
                            addOrUpdateEcpSpecies(returnToHeader);
                          }
                        },
                        child: const Text("Save and Return")),
                    ElevatedButton(
                        onPressed: () async {
                          List<String>? errors = _errorCheck();
                          if (errors != null) {
                            Popups.show(
                                context, PopupErrorsFoundList(errors: errors));
                          } else {
                            addOrUpdateEcpSpecies(createNewEcpSpeciesCompanion);
                          }
                        },
                        child: const Text("Save and Add New Species")),
                  ],
                ),
                layer.id != const d.Value.absent()
                    ? DeleteButton(
                        delete: () => Popups.show(
                          context,
                          PopupContinue("Warning: Deleting Piece",
                              contentText:
                                  "You are about to delete this piece. "
                                  "Are you sure you want to continue?",
                              rightBtnOnPressed: () {
                            //close popup
                            context.pop();
                            context.pushNamed(DeletePage.routeName, extra: {
                              DeletePage.keyObjectName:
                                  "Ecological Plot Layer: ${layer.toString()}",
                              DeletePage.keyDeleteFn: () {
                                (db.delete(db.ecpSpecies)
                                      ..where((tbl) =>
                                          tbl.id.equals(layer.id.value)))
                                    .go()
                                    .then((value) => returnToHeader());
                              },
                            });
                          }),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }
}
