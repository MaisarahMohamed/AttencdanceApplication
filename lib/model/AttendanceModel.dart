import 'package:flutter/material.dart';

class Attendance{
  String user;
  String phone;
  DateTime checkIn;

  Attendance(
    {
      required this.user,
      required this.phone,
      required this.checkIn,
    }
  );
}


List <Attendance> attendanceList = [
  Attendance(
    user: "Chan Saw Lin",
    phone: "0152131113",
    checkIn: DateTime.parse("2020-06-30 16:10:05"),
  ),

  Attendance(
    user: "Lee Saw Loy",
    phone: "0161231346",
    checkIn: DateTime.parse("2020-07-11 15:39:59")
  ),

  Attendance(
  user: "Khaw Tong Lin",
  phone: "0158398109",
  checkIn: DateTime.parse("2020-08-19 11:10:18")
  ),

  Attendance(
    user: "Lim Kok Lin",
    phone: "0168279101",
    checkIn: DateTime.parse("2020-08-19 11:11:35")
  ),

  Attendance(
    user: "Low Jun Wei",
    phone: "0112731912",
    checkIn: DateTime.parse("2020-08-15 13:00:05")
  ),

  Attendance(
    user: "Yong Weng Kai",
    phone: "0172332743",
    checkIn: DateTime.parse("2020-07-31 18:10:11")
  ),

  Attendance(
    user: "Jayden Lee",
    phone: "0191236439",
    checkIn: DateTime.parse("2020-08-22 08:10:38")
  ),

  Attendance(
    user: "Kong Kah Yan",
    phone: "0111931233",
    checkIn: DateTime.parse("2020-07-11 12:00:00")
  ),

  Attendance(
    user: "Jasmine Lau",
    phone: "0162879190",
    checkIn: DateTime.parse("2020-08-01 12:10:05")
  ),

  Attendance(
    user: "Chan Saw Lin",
    phone: "016783239",
    checkIn: DateTime.parse("2020-08-23 11:59:05")
  ),
];