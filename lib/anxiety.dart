import 'package:flutter/material.dart';


var depression = [
  "Do you Negelect your friends and hobbies",
  "Do you have change in sleeping pattern",
  "Do you think there is increase in your appetite",
  "Do you face low self esteem most of the times",
  "Do you think you have decrease in hygiene",
  "Do you get edited most of the times",
  "Do you face flat emotions"
];


class Anxiety  extends StatelessWidget{
  const Anxiety({super.key});

void tap_position(TapDownDetails details){
  var tap = details.globalPosition;

}



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:SizedBox(
        height:400,         
        child:Scrollbar(
          controller: ScrollController(),
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: 5,
            itemBuilder: (context,index){
              return Material(
                shadowColor:Colors.black,
                borderRadius: BorderRadius.circular(10),
                child:ListTile(
                  title: Text("${depression[index]}"),
                  onTap:(){
                    
                  },
              )
              );
            }
            )
          )
      )
    );
  }
  
}