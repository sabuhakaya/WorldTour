import 'package:flutter/material.dart';
import 'second_page.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userNameController = new TextEditingController();
  bool isUserNameValidate = false;
  @override
  void initState() {
    super.initState();

    userNameController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    userNameController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${userNameController.text}");
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.lightBlue[900],
          title: Text(
            'Welcome to WorldTour',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(

          children: [
            Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(

                  child: Image(

                    image: AssetImage('images/2.png'),

                  ),

                ),

                Center(

                  child: TextField(

                    controller: userNameController,

                    obscureText: false,

                    decoration: InputDecoration(

                      border: OutlineInputBorder(),

                      labelText: ('Login your username'),

                    ),



                  ),

                ),

                SizedBox(

                  height: 10.0,

                ),

                RaisedButton(

                  onPressed: () {

                    validateTextField(userNameController.text);

                    setState(() {

                      Navigator.push(context,

                          MaterialPageRoute(builder: (context) => SecondPage()));

                    });

                  },

                  color: Colors.lightBlue[800],

                  textColor: Colors.white,

                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[

                      Text('Start Your WorldTour',

                          style: TextStyle(

                            fontSize: 18,

                            fontWeight: FontWeight.w700,

                            color: Colors.white,

                          )),

                      Icon(

                        Icons.login,

                      ),

                    ],

                  ),

                ),

              ],

            ),
          ],
        ),
      ),
    );
  }

  bool validateTextField(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        isUserNameValidate = true;
      });
      return false;
    }
    setState(() {
      isUserNameValidate = false;
    });
    return true;
  }
}