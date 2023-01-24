import 'package:flutter/material.dart';
import 'home.dart';


var pstd =[
  "Have you disconnected yourself from friends and family",
  "Does any passed instant give you flashbacks ",
  "Do you feel your heart beating more than normal",
  "Do you have night me at all bad dreams",
  "Do you feel world is dangerous no and can be trusted",
  "Easily get started by loud noise or surprise",
  "Do have trouble in sleeping or concentrating",
  "Do  you have frightening thoughts",
  "Do you avoid in attending any events around it by people"
];

var ptsd_count = 0;
class PSTD  extends StatefulWidget{
  const PSTD({super.key});

@override
State<PSTD> createState() => DepState();
}

class DepState extends State<PSTD>{


var p_controller  = PageController();
var count = 1;
Object? ischecked;
var b_color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView.builder(
            controller: p_controller,
            itemCount:pstd.length,
            physics:NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                  children:[
                    IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, 
                      icon: Icon(Icons.arrow_back)
                      ),
                    Text("Clinical PSTD Test",
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      ),
                    ),
                  ]),
                  Text("${pstd[index]}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${count} of ${pstd.length}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 200,
                    child:Column(
                    children: [
                      RadioListTile(
                        activeColor:Colors.redAccent,
                        selected: ischecked == 0 ? true : false,
                        title: Text("Yes"),
                        value: 1, 
                        groupValue: ischecked, 
                        onChanged: (Object? value){
                          setState(() {
                              ischecked = value;
                          });
                        },
                      ),
                      RadioListTile(
                          activeColor:Colors.greenAccent,
                          title: Text("No"),
                          value: 0, 
                          groupValue: ischecked, 
                          onChanged: (value){
                            setState(() {
                                ischecked = value;
                            });
                          },
                          ), 
                       ])
                      ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),side: BorderSide(width: 5,color: Colors.white)),
                        fixedSize: Size(350,50)
                        ),
                    onPressed: (){
                      setState(() {
                        if(ischecked == 1 || ischecked == 0){
                        if(count <= pstd.length - 1){
                          p_controller.nextPage(duration: Duration(milliseconds: 2), curve: Curves.easeIn);
                          count = count + 1;
                        }
                        }
                        if(ischecked == 1 && ptsd_count <= pstd.length){
                          ptsd_count = ptsd_count + 1;
                        }
                        else{
                          ptsd_count = 0;
                        }
                        if(count > pstd.length -1){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Score()));
                        }
                        
                      });
                    }, 
                    child: Text(count < pstd.length  ? "Next Question":"Submit")
                    ),

                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),side: BorderSide(width: 5,color: Colors.white)),
                        fixedSize: Size(350,50)
                        ),
                    onPressed: (){
                      setState(() {
                        p_controller.previousPage(duration: Duration(milliseconds: 2), curve: Curves.easeIn);
                        if(count > index+1){
                          count = count - 1;
                        }
                        
                      });
                    }, 
                    child: Text("Previous Question")
                    )
                ],
              );
            }
      )      
    );
  }
  
}

//Score Bar 
class Score extends StatelessWidget{
  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Text("Your Score ${ptsd_count} out of ${pstd.length}",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(ptsd_count >=7 ? 
            "Based on Your Score you might be facing some PSTD issues"+"\n"+"If the problem persists consider consulting a counsellor.":
            "Based on Your Score you do not seem to have any kind of this disorder.",
            style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify,
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>  Home()),
                  ModalRoute.withName("/home")
                  );
              ptsd_count = 0;
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple,
                fixedSize: Size(350,50),
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                )
                ),
              child: Text("Finish"),
              )
          ])
    );
  }
}