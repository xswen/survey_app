import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/margins_padding.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';

class SoilPitAttributesInputPage extends StatefulWidget {
  const SoilPitAttributesInputPage({Key? key}) : super(key: key);

  @override
  State<SoilPitAttributesInputPage> createState() =>
      _SoilPitAttributesInputPageState();
}

class _SoilPitAttributesInputPageState
    extends State<SoilPitAttributesInputPage> {
  String type = "";

  List<Widget> getWidgets(String selectedType) {
    if (type == "Mineral") {
      return [
        DropDownDefault(
            title: "Horizon Test",
            onChangedFn: (String? s) {},
            itemsList: [],
            selectedItem: ""),
        DropDownDefault(
            title: "Horizon Designation",
            onChangedFn: (String? s) {},
            itemsList: [],
            selectedItem: ""),
        DataInput(
          title: "Horizon Upper Depth",
          boxLabel: "In cm",
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
        ),
        DataInput(
          title: "Horizon Thickness",
          boxLabel: "In cm",
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
        ),
      ];
    } else if (type == "Mineral + Organic") {
      return [
        DataInput(
          title: "Soil Colour",
          prefixIcon: FontAwesomeIcons.pencil,
          suffixVal: "cm",
          startingStr: "",
          errorMsg: "",
          onSubmit: (String s) {},
        ),
        DataInput(
          title: "Soil Texture",
          prefixIcon: FontAwesomeIcons.pencil,
          startingStr: "",
          errorMsg: "",
          onSubmit: (String s) {},
        ),
        DataInput(
          title: "Percent Gravel",
          boxLabel: "In percent",
          prefixIcon: FontAwesomeIcons.ruler,
          suffixVal: "Percent",
          inputType: const TextInputType.numberWithOptions(decimal: true),
          startingStr: "",
          errorMsg: "",
          inputFormatters: [
            LengthLimitingTextInputFormatter(5),
            ThousandsFormatter(allowFraction: true, decimalPlaces: 1)
          ],
          onSubmit: (String s) {},
        ),
        DataInput(
          title: "Percent Cobbles",
          boxLabel: "In Percent",
          prefixIcon: FontAwesomeIcons.ruler,
          suffixVal: "Percent",
          inputType: const TextInputType.numberWithOptions(decimal: true),
          startingStr: "",
          errorMsg: "",
          inputFormatters: [
            LengthLimitingTextInputFormatter(5),
            ThousandsFormatter(allowFraction: true, decimalPlaces: 1)
          ],
          onSubmit: (String s) {},
        ),
        DataInput(
          title: "Percent Stones",
          boxLabel: "In Percent",
          prefixIcon: FontAwesomeIcons.ruler,
          suffixVal: "Percent",
          inputType: const TextInputType.numberWithOptions(decimal: true),
          startingStr: "",
          errorMsg: "",
          inputFormatters: [
            LengthLimitingTextInputFormatter(5),
            ThousandsFormatter(allowFraction: true, decimalPlaces: 1)
          ],
          onSubmit: (String s) {},
        ),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar("Soil Pit Attributes Input"),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: kPaddingH),
          children: [
            DropDownDefault(
                title: "Horizon Number",
                onChangedFn: (String? s) {},
                itemsList: [],
                selectedItem: ""),
            DropDownDefault(
                title: "Type",
                onChangedFn: (String? s) {
                  setState(() => type = s ?? "");
                },
                itemsList: ["Mineral", "Mineral + Organic"],
                selectedItem: ""),
            ...getWidgets(type),
          ],
        ),
      ),
    );
  }
}
