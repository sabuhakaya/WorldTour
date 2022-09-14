import 'package:flutter/material.dart';
import 'login_page.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/eiffel2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 60.0, 20.0, 20.0),
                  child: Container(
                    child: Center(child: Text("WorldTour is an \napplication that provides\nthe information about \nall countries in the World.\nIn order to improve your cultural \nknowledge use WorldTour.", style:TextStyle(fontSize: 40,decorationThickness: 2.2,color: Colors.white70))),
                  ),
                ),
              ),

              Container(
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    });
                  },
                  color: Colors.lightBlue[900],
                  textColor: Colors.white70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text('Tap To Start',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            )),
                      ),
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),


      ),
    );
  }
}