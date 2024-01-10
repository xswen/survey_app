extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String camelCaseToTitle() {
    if (isEmpty) return this;

    String spaced = replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (Match m) => "${m[1]} ${m[2]}",
    );

    List<String> words = spaced.split(' ');

    String titled = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return word;
    }).join(' ');

    return titled;
  }
}
