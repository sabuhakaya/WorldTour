import 'package:flutter/material.dart';
import 'second_page.dart';

class QuizPage extends StatefulWidget {
  String name;
  String capital;
  String subregion;
  String alpha2code;
  QuizPage(this.name, this.capital, this.subregion, this.alpha2code);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final snackBar =SnackBar(
    content: Text("Wrong answer! Try again"),
    backgroundColor: Colors.red,
  );
  @override
  Widget build(BuildContext context) {
    String name1 = widget.name;
    String capital1 = widget.capital;
    String subregion1 = widget.subregion;
    String alpha2code1 = widget.alpha2code;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: (){
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage()));

            });
          },
        ),
        appBar: AppBar(
          title: Text("Quiz Time",style: TextStyle(color: Colors.white),),
        ),
        body: Stack(

          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListView(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Which is the capital city of $name1?",style: TextStyle(color: Colors.black,
                          fontSize: 22.0),),
                    ),
                  ),
                  buildCard("A:Baku",Colors.teal),
                  buildCard("B:London",Colors.deepOrange),
                  Card(
                    color: Colors.purple,
                    child: new InkWell(
                      onTap: () {
                        print("Correct answer");},
                      child: ListTile(
                        title: Text("C:$capital1"),
                      ),
                    ),),
                  buildCard("D:Baghdad",Colors.blue),
                  SizedBox(height: 10,),

                  Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Which is the subreagion of $name1?",style: TextStyle(color: Colors.black,
                          fontSize: 22.0),),
                    ),
                  ),
                  buildCard('A:Sub-Saharan Africa',Colors.green,),
                  buildCard('B:Central Asia',Colors.indigoAccent),
                  buildCard('C:Eastern Europe',Colors.orange),
                  Card(
                    color: Colors.deepOrange,
                    child: new InkWell(
                      onTap: () {
                        print("Correct answer");},
                      child: ListTile(
                        title: Text('D:$subregion1'),
                      ),
                    ), ),
                  SizedBox(height: 10,),

                  Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("Which is the alpha-2 code of $name1?",style: TextStyle(color: Colors.black,
                          fontSize: 22.0),),
                    ),
                  ),
                  Card(
                    color: Colors.lightGreenAccent,
                    child: new InkWell(
                      onTap: () {
                        print("Correct answer");},
                      child: ListTile(
                        title: Text('A:$alpha2code1'),
                      ),
                    ),),
                  buildCard('B:IM',Colors.cyanAccent),
                  buildCard('C:VA',Colors.indigoAccent),
                  buildCard('D:ZW',Colors.pinkAccent),


                ],
              ),
            ),








          ],
        ),
      ),
    );

  }

  Card buildCard(String text,Color color) {
    return Card(color: color,
      child: new InkWell(
        onTap: () {
          print("Wrong answer! Try again");},
        child: ListTile(
          title: Text(text),
        ),
      ),
    );
  }





}