import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hotel_manager/constant.dart';
import 'package:hotel_manager/home.dart';
import 'package:hotel_manager/mongodb.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    MongoDatabase.connect();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade900,
          Colors.orange.shade800,
          Colors.orange.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: emailcontroller,
                                    decoration: const InputDecoration(
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: passwordcontroller,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      // FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Forgot Password?", style: TextStyle(color: Colors.grey),)),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      Container(
                        width: double.infinity,
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: MaterialButton(
                              onPressed: () {
                                _checkData(context, emailcontroller.text,
                                    passwordcontroller.text);
                              },
                              height: 50,
                              // margin: EdgeInsets.symmetric(horizontal: 50),
                              color: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              // decoration: BoxDecoration(
                              // ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      // height: 50,
                      // ),
                      // FadeInUp(
                      //     duration: Duration(milliseconds: 1700),
                      //     child: Text(
                      //       "Continue with social media",
                      //       style: TextStyle(color: Colors.grey),
                      //     )),
                      // SizedBox(
                      // height: 30,
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: FadeInUp(r
                      //           duration: Duration(milliseconds: 1800),
                      //           child: MaterialButton(
                      //             onPressed: () {},
                      //             height: 50,
                      //             color: Colors.blue,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             child: Center(
                      //               child: Text(
                      //                 "Facebook",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           )),
                      //     ),
                      //     SizedBox(
                      //       width: 30,
                      //     ),
                      //     Expanded(
                      //       child: FadeInUp(
                      //           duration: Duration(milliseconds: 1900),
                      //           child: MaterialButton(
                      //             onPressed: () {},
                      //             height: 50,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             color: Colors.black,
                      //             child: Center(
                      //               child: Text(
                      //                 "Github",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           )),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _checkData(
      BuildContext context, String email, String password) async {
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
              Text("Logging in..."), // Optional: Show a message
            ],
          ),
        );
      },
    );

    try {
      var db = await M.Db.create(MONGO_URL);
      await db.open();
      var usersCollection = db.collection('users');
      var query = M.where.eq('email', email).eq('password', password);
      var user = await usersCollection.findOne(query);
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString(
            'userEmail', email); // Store user's email in SharedPreferences
        emailcontroller.text = "";
        passwordcontroller.text = "";
        // Perform the login action only if the user exists
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        // Hide the loading indicator
        Navigator.of(context).pop();
        // Show an error dialog if the user does not exist
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid email or password. Please try again.'),
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
      print('Error during login: $e');
      // Hide the loading indicator
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'An error occurred during login. Please try again later. $e'),
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
}
