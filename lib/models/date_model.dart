import 'package:cloud_firestore/cloud_firestore.dart';

const String dateFieldTimestemp = "timestamp";
const String dateFieldDay = "day";
const String dateFieldMonth = "Month";
const String dateFieldYear = "Year";

class DateModel {
  Timestamp timestamp;
  num day, month, year;

  DateModel({
    required this.timestamp,
    required this.day,
    required this.month,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      dateFieldTimestemp: timestamp,
      dateFieldDay: day,
      dateFieldMonth: month,
      dateFieldYear: year,
    };
  }

  factory DateModel.fromMap(Map<String, dynamic> map) => DateModel(
        timestamp: map[dateFieldTimestemp],
        day: map[dateFieldDay],
        month: map[dateFieldMonth],
        year: map[dateFieldYear],
      );
}
