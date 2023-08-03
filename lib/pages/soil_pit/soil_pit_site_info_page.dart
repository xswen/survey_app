import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/margins_padding.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/hide_info_checkbox.dart';

class SoilPitSiteInfo extends StatefulWidget {
  const SoilPitSiteInfo({Key? key}) : super(key: key);

  @override
  State<SoilPitSiteInfo> createState() => _SoilPitSiteInfoState();
}

class _SoilPitSiteInfoState extends State<SoilPitSiteInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar("Soil Pit"),
      floatingActionButton: FloatingCompleteButton(
        title: "Soil Pit",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        children: [
          HideInfoCheckbox(
              title: "CSSC Soil Classification",
              checkTitle: "Missing",
              checkValue: false,
              child: DropDownDefault(
                onChangedFn: (String? s) {},
                itemsList: [],
                selectedItem: 'Please select CSSC Soil Classification',
                padding: 0,
              )),
          HideInfoCheckbox(
            title: "Profile Depth",
            checkTitle: "Unreported",
            checkValue: false,
            child: DataInput(
              boxLabel: "Reported to the nearest 0.1cm",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "cm",
              inputType: const TextInputType.numberWithOptions(decimal: true),
              startingStr: "",
              errorMsg: "",
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1)
              ],
              onSubmit: (String s) {},
              generalPadding: const EdgeInsets.all(0),
              textBoxPadding: const EdgeInsets.all(0),
            ),
          ),
          HideInfoCheckbox(
              title: "Soil Drainn",
              checkTitle: "Missing",
              checkValue: false,
              child: DropDownDefault(
                onChangedFn: (String? s) {},
                itemsList: [],
                selectedItem: 'Please select Soil Drain',
                padding: 0,
              )),
          HideInfoCheckbox(
              title: "Moisture",
              checkTitle: "Missing",
              checkValue: false,
              child: DropDownDefault(
                onChangedFn: (String? s) {},
                itemsList: [],
                selectedItem: 'Please select Moisture',
                padding: 0,
              )),
          DropDownDefault(
              title: "Parent Material",
              onChangedFn: (String? s) {},
              itemsList: [],
              selectedItem: "Please select Parent Material"),
          DropDownDefault(
              title: "Humus Form",
              onChangedFn: (String? s) {},
              itemsList: [],
              selectedItem: "Please select Humus Form"),
        ],
      )),
    );
  }
}
