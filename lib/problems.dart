import 'package:flutter/material.dart';
import 'PSTD.dart';
import 'bipolar.dart';
import 'depression.dart';


class Tests extends  StatefulWidget{
  const Tests({super.key});

State<Tests> createState() => TestState();

}

class TestState extends State<Tests>{

  var selected = false;
 // var _scfstate = GlobalKey<ScaffoldState>();
  var n_index;

  final tests = {
    "Disorders":["Anxiety","Clinical Depression","PSTD","Bipolar Disorder"],
    "Selected":[false,false,false,false],
    "Images":[
    "assets/images/th-3859197198.jpg",
    "assets/images/th-1951899228.jpg",
    "assets/images/th-1849730954.jpg",
    "assets/images/bipolar.jpg"
    ]
  };


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:Column(
      children:[
        Padding(
          padding:EdgeInsets.only(top: 50),
          child:Text("Pick a Test",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.lightBlue
            ),),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding:EdgeInsets.only(left: 20,right: 20,top: 80,bottom: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            ),
          itemCount: tests["Disorders"]!.length,
          itemBuilder: (context,index){
          return Material(
            elevation: 15,
            shadowColor:Colors.lightBlue,
            borderRadius: BorderRadius.circular(20),
            child:Container(
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("${tests["Images"]![index]}"),
                  opacity: 0.8,
                  fit: BoxFit.fill
                  )
                  ),
                child:ListTile(
                title:Center(child:Text("${tests["Disorders"]![index]}",
                style: TextStyle(color: Colors.white),textAlign: TextAlign.justify,)),
                selected: selected,
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(20),
              ),
              onTap: (){
                switch (index) {
                  case 1:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Depression()));
                    break;
                  case 2:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PSTD()));
                    break;
                  case 3:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Bipolar()));
                    break;
                  default:
                }
              },
              )
            )
            );
          }  
          ),

      ])
    );
  }
}