import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../formatters/thousands_formatter.dart';
import '../checkbox/hide_info_checkbox.dart';
import '../data_input/data_input.dart';

class soilPitBuildCoarseFragment extends StatelessWidget {
  const soilPitBuildCoarseFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget buildCoarseFragmentContent({
  required String title,
  required String titleWidget,
  required String boxLabel,
  required String startingStr,
  required d.Value<int> horizonValue,
  required void Function(bool) onChange,
  required void Function(String) onSubmit,
  required String? Function(String?) onValidate,
}) {
  return HideInfoCheckbox(
    title: title,
    titleWidget: titleWidget,
    padding: const EdgeInsets.all(0),
    checkValue: startingStr == "-9",
    onChange: (b) => b! ? onChange(true) : onChange(false),
    child: DataInput(
      boxLabel: boxLabel,
      prefixIcon: FontAwesomeIcons.percent,
      suffixVal: "%",
      startingStr: startingStr,
      paddingGeneral: const EdgeInsets.all(0),
      onValidate: onValidate,
      inputType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
      ],
      onSubmit: onSubmit,
    ),
  );
}
