import 'package:attendance_application/model/AttendanceModel.dart';

List<Attendance> users = attendanceList;

void _runFilter(String query) {
  List<Attendance> results = [];
  if (query.isEmpty) {
    // if the search field is empty or only contains white-space, we'll display all users
    results = attendanceList;
  } else {
    results = users
        .where((user) =>
        user.user.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // we use the toLowerCase() method to make it case-insensitive
  }

}