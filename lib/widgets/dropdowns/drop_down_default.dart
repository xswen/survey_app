import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';

class DropDownDefault extends StatefulWidget {
  const DropDownDefault(
      {super.key,
      this.searchable = false,
      this.enabled = true,
      this.title = "",
      this.disabledItemFn,
      this.onBeforePopup,
      required this.onChangedFn,
      required this.itemsList,
      required this.selectedItem,
      this.padding = kPaddingV * 2});

  //default false
  final String title;
  final bool searchable;
  final bool enabled;
  final bool Function(String?)? disabledItemFn;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final List<String> itemsList;
  final String selectedItem;
  final double padding;

  @override
  State<DropDownDefault> createState() => _DropDownDefaultState();
}

class _DropDownDefaultState extends State<DropDownDefault> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    tr(widget.title),
                    style: kTitleStyle,
                  ),
                ),
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: widget.searchable,
              disabledItemFn: widget.disabledItemFn,
              searchDelay: const Duration(microseconds: 0),
            ),
            enabled: widget.enabled,
            onBeforePopupOpening: widget.onBeforePopup,
            onChanged: widget.onChangedFn,
            items: widget.itemsList,
            selectedItem: widget.selectedItem,
          ),
        ],
      ),
    );
  }
}
