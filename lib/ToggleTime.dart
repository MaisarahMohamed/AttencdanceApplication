import 'model/AttendanceModel.dart';

String getDuration(int i){
  String duration = '';
  DateTime currentTime = DateTime.now();
  Duration diff = currentTime.difference(attendanceList.elementAt(i).checkIn);
  if(diff.inDays == 0) {
    if (diff.inHours == 0) {
      if (diff.inMinutes == 0) {
        if(diff.inSeconds <= 1){
          duration += '${diff.inSeconds} second ago';
        }else{
          duration += '${diff.inSeconds} seconds ago';
        }
      } else {
        if(diff.inMinutes <= 1){
          duration += '${diff.inMinutes} minute ago';
        }else{
          duration += '${diff.inMinutes} minutes ago';
        }
      }
    } else {
      if(diff.inHours <= 1){
        duration += '${diff.inHours} hour ago';
      }else{
        duration += '${diff.inHours} hours ago';
      }
    }
  }else{
    if(diff.inDays == 1){
      duration += '${diff.inDays} day ago';
    }else{
      duration += '${diff.inDays} days ago';
    }
  }
  return duration;
}