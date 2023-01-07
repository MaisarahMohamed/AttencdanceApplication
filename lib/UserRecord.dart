import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/AttendanceModel.dart';
import 'package:share_plus/share_plus.dart';


class UserRecordPage extends StatefulWidget {
  const UserRecordPage({Key? key, required this.user}) : super(key: key);
  final Attendance user;
  @override
  State<UserRecordPage> createState() => _UserRecordPageState();
}

class _UserRecordPageState extends State<UserRecordPage> {
  // _onShare method:

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Record',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: 300,
          child: Card(
            elevation: 10,
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Table(
                  defaultColumnWidth: IntrinsicColumnWidth(),
                  border: TableBorder.all(color: Colors.white),
                  children: [
                    TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Name:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.user.user}',
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Phone Number:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.user.phone}',
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Checked-in:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${DateFormat('dd MMM yyyy, h:mm a').format(widget.user.checkIn)}',
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      ),
                      onPressed: ()async{
                        await Share.share(
                          'Contact Information \nName: ${widget.user.user} '
                              '\nPhone Number: ${widget.user.phone}',);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:10),
                            child: Icon(Icons.share),
                          ),
                          Text('Share Contact'),
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

