import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/MongoDBModel.dart';
import 'package:hotel_manager/login.dart';
import 'package:hotel_manager/mongodb.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var email = new TextEditingController();
  // var name = new TextEditingController();
  // var roomcode = new TextEditingController();
  // var reason = new TextEditingController();
  // var fromdate = new TextEditingController();
  // var todate = new TextEditingController();
  DateTime? todatee;
  DateTime? fromdatee;
  TextEditingController profilenamecontroller = new TextEditingController();
  TextEditingController profileroomnocontroller = new TextEditingController();
  String _userName = ''; // Variable to store the user's name
  String _userRoomNumber = '';

  @override
  void initState() {
    // WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    MongoDatabase.connect();

    _loadUserName(); // Call method to load the user's name when the widget initializes
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail =
        prefs.getString('userEmail') ?? ''; // Get the logged-in user's email

    if (userEmail.isNotEmpty) {
      // Query the users collection to get the user document based on the email
      var db = await M.Db.create(MONGO_URL);
      await db.open();
      var usersCollection = db.collection('users');
      var query = M.where.eq('email', userEmail);
      var userDoc = await usersCollection.findOne(query);

      if (userDoc != null) {
        setState(() {
          // Update the _userName variable with the fullName from the user document
          _userName = userDoc['fullName'] ??
              ''; // Assuming fullName is the field containing the user's name
        });
      }

      // Fetch user's room number from the 'roomallocations' collection
      var roomAllocationsCollection = db.collection('roomallocations');
      var roomQuery = M.where.eq('email', userEmail);
      var roomDoc = await roomAllocationsCollection.findOne(roomQuery);
      if (roomDoc != null) {
        setState(() {
          _userRoomNumber = roomDoc['roomNumber'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            _userRoomNumber,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle notification icon tap
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  childAspectRatio: 2,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              TextEditingController roomcheckercontroller =
                                  TextEditingController();
                              return AlertDialog(
                                title: Text(
                                  "Room Availability Check",
                                  textAlign: TextAlign
                                      .center, // Center align the title
                                  style: TextStyle(
                                    fontSize:
                                        20, // Increase font size if needed
                                    fontWeight:
                                        FontWeight.bold, // Make title bold
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: roomcheckercontroller,
                                        decoration: InputDecoration(
                                            labelText: 'Enter Room No'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      // Get the input values from the controllers

                                      _roomchecker(
                                          context, roomcheckercontroller.text);

                                      // Navigator.of(context).pop();
                                    },
                                    // style: ButtonStyle(
                                    //   backgroundColor:
                                    //       MaterialStateProperty.all<Color>(Colors
                                    //           .orange), // Set background color to orange
                                    // ),
                                    child: Text(
                                      'Check Availability',
                                      // style: TextStyle(color: Colors.white),
                                    ), // Set text color to white
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Clear the text field controllers
                                      roomcheckercontroller.clear();
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            });
                      },
                      child: itemDashboard(
                        'Room Availability',
                        Image.asset('assets/images/room_avail.png',
                            height: 100, width: 100),
                        Colors.transparent,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            // Define controllers to handle text field inputs
                            TextEditingController emailController =
                                TextEditingController();
                            TextEditingController nameController =
                                TextEditingController();
                            TextEditingController roomCodeController =
                                TextEditingController();
                            TextEditingController reasonController =
                                TextEditingController();
                            TextEditingController fromdatecontroller =
                                TextEditingController();
                            TextEditingController todatecontroller =
                                TextEditingController();

                            return AlertDialog(
                              title: Text(
                                'Leave Request Form',
                                textAlign:
                                    TextAlign.center, // Center align the title
                                style: TextStyle(
                                  fontSize: 20, // Increase font size if needed
                                  fontWeight:
                                      FontWeight.bold, // Make title bold
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: emailController,
                                      decoration:
                                          InputDecoration(labelText: 'Email'),
                                    ),
                                    TextField(
                                      controller: nameController,
                                      decoration:
                                          InputDecoration(labelText: 'Name'),
                                    ),
                                    TextField(
                                      controller: roomCodeController,
                                      decoration: InputDecoration(
                                          labelText: 'Room Code'),
                                    ),
                                    TextFormField(
                                      controller: fromdatecontroller,
                                      decoration: InputDecoration(
                                          labelText: 'From Date'),
                                      onTap: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );

                                        if (pickedDate != null) {
                                          fromdatecontroller.text =
                                              DateFormat('MM-dd-yyyy')
                                                  .format(pickedDate);
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      controller: todatecontroller,
                                      decoration:
                                          InputDecoration(labelText: 'To Date'),
                                      onTap: () async {
                                        final DateTime? pickedDatee =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );

                                        if (pickedDatee != null) {
                                          // todatee = pickedDatee;
                                          todatecontroller.text =
                                              DateFormat('MM-dd-yyyy')
                                                  .format(pickedDatee);
                                        }
                                      },
                                    ),
                                    TextField(
                                      controller: reasonController,
                                      decoration:
                                          InputDecoration(labelText: 'Reason'),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                // print(date); // Output: 2024-04-26 00:00:00.000
                                // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                                // String string = dateFormat.format(DateTime.now());
                                // DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
                                TextButton(
                                  onPressed: () {
                                    _insertData(
                                      context,
                                      emailController.text,
                                      nameController.text,
                                      roomCodeController.text,
                                      reasonController.text,
                                      todatecontroller.text,
                                      fromdatecontroller.text,
                                    );
                                    // Get the input values from the controllers
                                    // String email = emailController.text;
                                    // String name = nameController.text;
                                    // String roomCode = roomCodeController.text;
                                    // String todate = todatecontroller.text;
                                    // String fromdate = fromdatecontroller.text;
                                    // String reason = reasonController.text;

                                    // // Process the input values here
                                    // print('Email: $email');
                                    // print('Name: $name');
                                    // print('Room Code: $roomCode');
                                    // print('Reason: $reason');
                                    // print('todate: $todate');
                                    // print('$fromdate: $fromdate');

                                    // Clear the text field controllers
                                    emailController.clear();
                                    nameController.clear();
                                    roomCodeController.clear();
                                    fromdatecontroller.clear();
                                    todatecontroller.clear();
                                    reasonController.clear();

                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  // style: ButtonStyle(
                                  //   backgroundColor:
                                  //       MaterialStateProperty.all<Color>(Colors
                                  //           .orange), // Set background color to orange
                                  // ),
                                  child: Text(
                                    'Submit',
                                    // style: TextStyle(color: Colors.white),
                                  ), // Set text color to white
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Clear the text field controllers
                                    emailController.clear();
                                    nameController.clear();
                                    roomCodeController.clear();
                                    todatecontroller.clear();
                                    fromdatecontroller.clear();
                                    reasonController.clear();

                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: itemDashboard(
                        'Leave Request',
                        Image.asset('assets/images/leave.png',
                            height: 80, width: 80),
                        Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  color: Colors.white,
                  child: MaterialButton(
                    child: Text(
                      "Log out",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _logout();
                    },
                    height: 50,
                    color: Colors.orange[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDashboard(String title, Widget iconOrImage, Color background) =>
      Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: iconOrImage,
            ),
            SizedBox(height: 4),
            Text(
              title.toUpperCase(),
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      );

  Future<void> _logout() async {
    // Clear authentication information in local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    // Navigate back to the login screen
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}

Future<void> _insertData(BuildContext context, email, String name,
    String roomcode, String reason, String _todate, String _fromdate) async {
  var _id = M.ObjectId();
  final data = MongoDbModel(
      id: _id,
      email: email,
      fullName: name,
      fromDate: _fromdate,
      toDate: _todate,
      reason: reason,
      roomcode: roomcode);

  var result = await MongoDatabase.insert(data);
  print(_id);
  print(email);
  print(reason);
  print(name);
  print(roomcode);
  print(_todate);
  print(result);
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("inserted ID" + _id.$oid)));
}

Future<void> _roomchecker(BuildContext context, String roomno) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent user from dismissing the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(), // Show the loading indicator
            SizedBox(height: 16),
            Text("Checking room availability..."), // Optional: Show a message
          ],
        ),
      );
    },
  );

  try {
    var db = await M.Db.create(MONGO_URL);
    await db.open();
    var occupiedsCollection = db.collection('occupieds');
    var query = M.where.eq('roomcode', roomno);
    var room = await occupiedsCollection.findOne(query);
    if (room != null) {
      // Room is occupied
      Navigator.of(context).pop(); // Hide the loading indicator
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Room not available'),
            content: Text('Sorry, you are late.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Room is available
      Navigator.of(context).pop(); // Hide the loading indicator
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Room available'),
            content: Text('Yes, you are at the right place!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error during room check: $e');
    // Hide the loading indicator
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
              'An error occurred during room check. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
