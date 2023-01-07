import 'package:attendance_application/ToggleTime.dart';import 'package:attendance_application/UserRecord.dart';
import 'package:attendance_application/model/AttendanceModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SortTime.dart';
import 'package:attendance_application/SearchUser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: "root",
      title: 'Vimigo Technical Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendancePage(isDialogShow: true),
    );
  }
}

class AttendancePage extends StatefulWidget {
  bool isDialogShow;
  AttendancePage({required this.isDialogShow});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  ScrollController _scrollController = ScrollController();
  TextEditingController _user = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _search = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool light = false;
  bool _validate = false;
  String time = '';
  List <Attendance> att = [];
  String query = '';

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    _user.dispose();
    _phone.dispose();
    _search.dispose();
    super.dispose();
  }

  void validateAndSave(){
    final form = _formKey.currentState;
    if(form!.validate())
    {
      setState(() {
        attendanceList.add(
          Attendance(
              user: _user.text,
              phone: _phone.text,
              checkIn:DateTime.now()
          ),
        );
      });

      Navigator.push(context,
        MaterialPageRoute(builder: (context) => AttendancePage(isDialogShow: false)),
      );

      Fluttertoast.showToast(msg: 'Data Successfully Added');
    }
    else
    {
      Fluttertoast.showToast(msg: 'Please Fill In The Form');
    }
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Register New User'),
          content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  controller: _user,
                  decoration: InputDecoration(
                    labelText: 'Name *',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => value!.isEmpty ? 'Name Cannot Be Blank':null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  controller: _phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number *',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) => value!.isEmpty ? 'Phone Number Cannot Be Blank':null,
                ),
              ),
              ElevatedButton(
                child: new Text('Submit'),
                onPressed: () {validateAndSave();},
              )
            ],
          )),
        );
      }
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('How To Use This App?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'User Instructions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Steps to add attendance \n"
                "1. Click on the '+' button to add attendance \n"
                "2. Enter the user's name and phone number \n"
                "3. Click Submit\n"
              ),
              Text(
                "- You may also view user by clicking on the entry to see attendance record\n"
                "- You can see the check-in time by pressing the toggle switch\n"
                "- User may share contact information to others\n"
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(isDialogShow:false)));
                },
              ),
            )
          ],
        );
      },
    );
  }

  void searchUser(String query){
    List<Attendance> results = [];
    if (query.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = attendanceList;
    } else {
      results = attendanceList
        .where((name) =>
          name.user.toLowerCase().contains(query.toLowerCase()))
        .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      att = results;
    });
  }

  @override
  void initState() {
    if(widget.isDialogShow){
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _showDialog();
      });
    }
    _loadData();
    att = attendanceList;
    sortTime();
    // Setup the listener.
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          Fluttertoast.showToast(msg: 'You have reached the end of the list');
        }
      }
    });
    super.initState();
  }

  _loadData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      light = prefs.getBool("light")!;
    });
  }

  @override
  saveToggle() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("light", light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance List',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text('Show Check In Time'),
                Switch(
                  // This bool value toggles the switch.
                  value: light,
                  activeColor: Colors.purple,
                  onChanged: (bool value) {
                    setState(() {
                      light = value;
                      saveToggle();
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
      body:SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children:[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100,vertical: 10),
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search User',
                ),
                onChanged: (value) => searchUser(value),
              ),
            ),
            att.isNotEmpty ?
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:att.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRecordPage(user: attendanceList[index],)),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: ListTile(
                          title: Text('${attendanceList.elementAt(index).user}'),
                          subtitle: Text('${attendanceList.elementAt(index).phone}'),
                          trailing: light ?
                          Text('${DateFormat('dd MMM yyyy, h:mm a').format(attendanceList.elementAt(index).checkIn)}')
                              :Text('${getDuration(index)}'),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ):const Text(
              'No results found',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog(context);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
