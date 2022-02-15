class DateManager {
  static String getCurrentDate() {
    DateTime currentDateTime = DateTime.now();
    return '${currentDateTime.day}/${currentDateTime.month}/${currentDateTime.year}';
  }

  static String getDate(DateTime date) {
    int day = date.day;
    int month = date.month;
    int year = date.year;
    return '$day/$month/$year';
  }
}
