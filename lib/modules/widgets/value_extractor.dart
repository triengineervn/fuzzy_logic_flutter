// ignore_for_file: unnecessary_null_comparison

class ValueExtractor {
  String? text;
  String? searchKey;
  extractValue(String text, String searchKey) {
    int startIndex = text.indexOf("$searchKey: ");
    if (startIndex != -1) {
      startIndex += searchKey.length +
          2; // Add the length of the search key and ": " to get the starting index of the value
      int endIndex = text.indexOf(",", startIndex); // Find the index of the comma after the value
      if (endIndex == -1) {
        endIndex = text.indexOf(
            "}", startIndex); // If a comma is not found, find the index of the closing bracket
      }
      String valueString = text.substring(startIndex, endIndex);
      return valueString;
    } else {
      String a = '';
      return a;
    }
  }
}
