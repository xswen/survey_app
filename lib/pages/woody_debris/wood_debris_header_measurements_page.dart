import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';

import '../../constants/margins_padding.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/data_input/data_input.dart';

class WoodyDebrisHeaderMeasurements extends StatefulWidget {
  static const String keyWdHeader = "wdHeader";

  const WoodyDebrisHeaderMeasurements({Key? key, required this.wdh})
      : super(key: key);
  final WoodyDebrisHeaderData wdh;

  @override
  State<WoodyDebrisHeaderMeasurements> createState() =>
      _WoodyDebrisHeaderMeasurementsState();
}

class _WoodyDebrisHeaderMeasurementsState
    extends State<WoodyDebrisHeaderMeasurements> {
  late WoodyDebrisHeaderCompanion wdh;

  String get title => "Woody Debris Transect";

  @override
  void initState() {
    wdh = widget.wdh.toCompanion(true);
    super.initState();
  }

  //Error checks
  //Nominal length of the sample transect (m). 10.0 to 150.0
  static String? nomTransLen(String text) {
    print(text);
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (10.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 10.0 to 150.0 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);

    return Scaffold(
      appBar:
          OurAppBar("Woody Debris Measurement Data: Transect ${wdh.transNum}"),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        children: [
          DataInput(
            title: "The nominal length of the sample transect.",
            boxLabel: "Report to the nearest 0.1m",
            prefixIcon: FontAwesomeIcons.ruler,
            suffixVal: "m",
            startingStr: Global.dbCompanionValueToStr(wdh.nomTransLen),
            errorMsg:
                nomTransLen(Global.dbCompanionValueToStr(wdh.nomTransLen)),
            inputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              LengthLimitingTextInputFormatter(5),
              ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
            ],
            onSubmit: (String s) {
              print(s);
              // double.tryParse(s) != null
              //     ? setState(() {
              //         wdh = wdh.copyWith(nomTransLen: d.Value(double.parse(s)));
              //       })
              //     : null;
            },
          ),
        ],
      ),
    );
  }
}
