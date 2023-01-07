import 'model/AttendanceModel.dart';

void sortTime() {
  attendanceList.sort((a,b) => b.checkIn.compareTo(a.checkIn));
}