class FormatString {
  static String generateBulletList(List<String> lines) {
    String text = "";
    for (String line in lines) {
      //Check if it's the first bullet point
      line.isEmpty
          ? text += "\n"
          //If first line of text don't add a new line
          : text += text.isEmpty ? "• $line" : "\n • $line";
    }
    return text;
  }
}
