import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'second_page.dart';



class DetailPage extends StatelessWidget {
  final CountryInfo country;

  const DetailPage(this.country) ;

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(country.name),
        backgroundColor: Colors.lightBlue[900],
      ),

      body:Center(


        child: ListView(
          children: [
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15),
                Card(
                    color: Colors.orangeAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Center(
                        child: Text("Native Name: "+country.nativeName,style: TextStyle(
                          fontSize: 20.0,
                        ),),
                      ),

                    )),
                const SizedBox(height: 8),
                Card(
                    color: Colors.deepPurpleAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Center(
                        child: Text("Region: "+country.region, style: TextStyle(
                          fontSize: 20.0,
                        ),),
                      ),
                    )
                ),
                const SizedBox(height: 8),
                Card(
                    color: Colors.greenAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Center(
                        child: Text("Subregion: "+country.subregion,style: TextStyle(
                          fontSize: 20.0,
                        ),),
                      ),
                    )
                ),
                const SizedBox(height: 8),
                Card(
                    color: Colors.pinkAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Center(
                        child: Text("Demonym: "+country.demonym,style: TextStyle(
                          fontSize: 20.0,
                        ),),
                      ),
                    )
                ),
                const SizedBox(height: 8),
                Card(
                    color: Colors.limeAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Center(
                        child: Text("Alpha-2 Code: "+country.alpha2Code,style: TextStyle(
                          fontSize: 20.0,
                        ),),
                      ),
                    )
                ),
                const SizedBox(height: 8),
                Card(
                    color: Colors.tealAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Center(
                        child: Text("Capital city: "+country.capital,style: TextStyle(
                          fontSize: 20.0,
                        ),),
                      ),
                    )
                ),
                const SizedBox(height: 8),
                Card(
                    color: Colors.purple,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child:Center(
                        child: Text("Population: "+country.population.toString(),style: TextStyle(
                          fontSize: 20.0,
                        ),),
                      ),
                    )
                ),
                const SizedBox(height: 8),
              ],

            ),

          ],


        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Colors.lightBlue[900],
        child: Icon(
          Icons.spellcheck_rounded,



        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizPage(country.name,country.capital,country.subregion,country.alpha2Code)));
        },
      ),
    );
  }
}