import 'package:intl/intl.dart';

extension TimeExtension on DateTime {
  String curTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('MM-dd-yyyy');
    String finalDate = "";
    String formattedDate = formatter.format(now);
    if (formattedDate.startsWith("01")) {
      finalDate += "January ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("02")) {
      finalDate += "February ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("03")) {
      finalDate += "March ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("04")) {
      finalDate += "April ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("05")) {
      finalDate += "May ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("06")) {
      finalDate += "June ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("07")) {
      finalDate += "July ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("08")) {
      finalDate += "August ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("09")) {
      finalDate += "September ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("10")) {
      finalDate += "October ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("11")) {
      finalDate += "November ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else if (formattedDate.startsWith("12")) {
      finalDate += "December ";
      if (formattedDate.substring(3, 4).contains("0")) {
        finalDate += formattedDate.substring(4, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      } else {
                finalDate += formattedDate.substring(3, 5);
        finalDate += ", ";
        finalDate += formattedDate.substring(6, 10);
      }
    } else {
    }
    return finalDate;
  }
}
