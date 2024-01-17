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
      this.paddingGeneral =
          const EdgeInsets.only(top: kPaddingV * 2, bottom: 0),
      this.paddingTextbox = const EdgeInsets.only(top: kPaddingV),
      this.readOnly = false,
      //Manually pass a controller if controller ever needs to be cleared
      //A controller created for this purpose will be cleared by this widget
      //AND SHOULD NOT be cleared by parent class
      this.controller,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      required this.onValidate});

  final bool readOnly;
  final void Function(String) onSubmit;
  final String? Function(String?) onValidate;
  final AutovalidateMode autovalidateMode;
  final String title;
  final TextStyle titleStyle;
  final InfoPopupBuilder? infoPopupIconBuilder;
  final String boxLabel;
  final String startingStr;
  final TextInputType inputType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final String? suffixVal;
  final EdgeInsets paddingGeneral;
  final EdgeInsets paddingTextbox;
  final TextEditingController? controller;

  @override
  State<DataInput> createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  Widget? _prefixIcon;
  Widget? _suffixVal;

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.startingStr);
    super.initState();
  }

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    widget.controller == null
        ? _controller.dispose()
        : debugPrint(
            "Warning: Parent controller found. Controller deletion needs "
            "to be handled manually");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.paddingGeneral,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.title, style: widget.titleStyle),
                if (widget.infoPopupIconBuilder != null)
                  widget.infoPopupIconBuilder!,
              ],
            ),
          Padding(
            padding: widget.paddingTextbox,
            child: TextFormField(
              autovalidateMode: widget.autovalidateMode,
              readOnly: widget.readOnly,
              controller: _controller,
              validator: widget.onValidate,
              onChanged: widget.onSubmit,
              keyboardType: widget.inputType,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                labelText: widget.boxLabel,
                prefixIcon:
                    widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
                suffixIcon: widget.suffixVal != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(widget.suffixVal!),
                      )
                    : null,
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
