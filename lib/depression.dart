import 'package:flutter/material.dart';
import 'home.dart';
import 'problems.dart';


var depression =[
  "Do you Negelect your friends and hobbies",
  "Do you have change in sleeping pattern",
  "Do you think there is increase in your appetite",
  "Do you face low self esteem most of the times",
  "Do you think you have decrease in hygiene",
  "Do you get edited most of the times",
  "Do you face flat emotions"
];

int dep_count = 0;
class Depression  extends StatefulWidget{
  const Depression({super.key});

@override
State<Depression> createState() => DepState();
}

class DepState extends State<Depression>{


var p_controller  = PageController();
var count = 1;
Object? ischecked;
var b_color;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
            controller: p_controller,
            itemCount:depression.length,
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
                    Text("Clinical Depression Test",
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      ),
                    ),
                  ]),
                  Text("${depression[index]}",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("${count} of ${depression.length}",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 200,
                    child:Column(
                    children: [
                      RadioListTile(
                        activeColor: Colors.redAccent,
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
                          selected: ischecked == 0 ? true : false,
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
                        if(count <= depression.length + 1){
                          p_controller.nextPage(duration: Duration(milliseconds: 2), curve: Curves.easeIn);
                          count = count + 1;
                        }
                        }
                        if(ischecked == 1 && dep_count <= depression.length){
                          dep_count = dep_count + 1;
                        }
                        else{
                          dep_count = 0;
                        }
                        if(count > depression.length - 1){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Score()));
                        }
                        
                      });
                    }, 
                    child: Text(count < depression.length  ? "Next Question":"Submit")
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
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children:[
            Text("Your Score ${dep_count} out of ${depression.length}",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(dep_count >=5 ? 
            "Based on Your Score you might be facing some depression issues"+"\n" +"If the problem persists consider consulting a counsellor.":
            "Based on Your Score you do not seem to have any kind of this disorder.",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>  Home()),
                  ModalRoute.withName("/home")
                  );
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