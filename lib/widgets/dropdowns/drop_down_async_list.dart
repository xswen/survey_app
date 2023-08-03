import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';

class DropDownAsyncList extends StatefulWidget {
  const DropDownAsyncList(
      {Key? key,
      this.searchable = false,
      this.title = "",
      this.disabledFn,
      this.onBeforePopup,
      required this.onChangedFn,
      this.asyncItems,
      required this.selectedItem,
      this.padding = kPaddingV * 2})
      : super(key: key);

  //default false
  final String title;
  final bool searchable;
  final bool Function(String?)? disabledFn;
  //return false to prevent popup
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final Future<List<String>> Function(String)? asyncItems;
  final String selectedItem;
  final double padding;

  @override
  State<DropDownAsyncList> createState() => _DropDownAsyncListState();
}

class _DropDownAsyncListState extends State<DropDownAsyncList> {
  late Widget _title;

  @override
  void initState() {
    _title = widget.title.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Text(
              widget.title,
              style: kTitleStyle,
            ),
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title,
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: widget.searchable,
              disabledItemFn: widget.disabledFn,
            ),
            onBeforePopupOpening: widget.onBeforePopup,
            onChanged: widget.onChangedFn,
            asyncItems: widget.asyncItems,
            selectedItem: widget.selectedItem,
          ),
        ],
      ),
    );
  }
}
