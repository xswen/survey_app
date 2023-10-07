class ColumnHeaders {
  static String headerNameId = "ID";
  static String headerNameEdit = "Edit";

  ColumnHeaders(this.name, {this.sort = true, this.visible = true});
  final String name;
  bool sort;
  bool visible;
}
