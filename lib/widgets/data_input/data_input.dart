import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_app/widgets/builders/info_popup_builder.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';

class DataInput extends StatefulWidget {
  const DataInput(
      {super.key,
      required this.onSubmit,
      this.title = "",
      this.titleStyle = kTitleStyle,
      this.infoPopupIconBuilder,
      this.boxLabel = "",
      this.startingStr = "",
      this.inputType = TextInputType.text,
      this.inputFormatters,
      this.prefixIcon,
      this.suffixVal,
      this.generalPadding =
          const EdgeInsets.only(top: kPaddingV * 2, bottom: 0),
      this.textBoxPadding = const EdgeInsets.only(top: kPaddingV),
      this.readOnly = false,
      //Manually pass a controller if controller ever needs to be cleared
      //A controller created for this purpose will be cleared by this widget
      //AND SHOULD NOT be cleared by parent class
      this.controller,
      required this.onValidate});

  final bool readOnly;
  final void Function(String) onSubmit;
  final String? Function(String?) onValidate;
  final String title;
  final TextStyle titleStyle;
  final InfoPopupBuilder? infoPopupIconBuilder;
  final String boxLabel;
  final String startingStr;
  final TextInputType inputType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final String? suffixVal;
  final EdgeInsets generalPadding;
  final EdgeInsets textBoxPadding;
  final TextEditingController? controller;

  @override
  State<DataInput> createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  Widget? _prefixIcon;
  Widget? _suffixVal;

  late final TextEditingController controller;

  @override
  void initState() {
    widget.prefixIcon != null ? _prefixIcon = Icon(widget.prefixIcon) : null;
    widget.suffixVal != null
        ? _suffixVal = Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
            child: Text(widget.suffixVal!),
          )
        : null;

    controller = widget.controller ?? TextEditingController();
    controller.text = widget.startingStr;
    super.initState();
  }

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    } else {
      debugPrint("Warning: Parent controller found. Controller deletion needs "
          "to be handled manually");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.generalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.title, style: widget.titleStyle),
                    widget.infoPopupIconBuilder ?? Container(),
                  ],
                )
              : Container(),
          SizedBox(
            child: Padding(
              padding: widget.textBoxPadding,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                readOnly: widget.readOnly,
                controller: controller,
                validator: (String? value) {
                  return widget.onValidate(value);
                },
                onChanged: (s) {
                  widget.onSubmit(s);
                },
                keyboardType: widget.inputType,
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                  labelText: widget.boxLabel,
                  prefixIcon: _prefixIcon,
                  suffixIcon: _suffixVal,
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.grey)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
