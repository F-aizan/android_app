import 'package:flutter/material.dart';
import 'package:fproject/problems.dart';
import 'home.dart';


var bip =[
  "Do you have mood swings all the time",
  "Do you feel your self worthless and guilty",
  "Do have suicidal thoughts",
  "Do you face difficulty in concentrating",
  "Do face extremely irritated by any physical activity",
  "Do you have irregular sleep",
  "Do you have face changes  in your appetite",
  "Do you have a risky behaviour",
  "Do you feel  more tired by doing normal work"
  "Do you have a risky and reckless behaviour"
];

var bip_count = 0;
class Bipolar  extends StatefulWidget{
  const Bipolar({super.key});

@override
State<Bipolar> createState() => DepState();
}

class DepState extends State<Bipolar>{


var p_controller  = PageController();
var count = 1;
Object? ischecked;
var b_color;


void tap_position(TapDownDetails details){
  var tap = details.globalPosition;

}

getvalue(){
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView.builder(
            controller: p_controller,
            itemCount:bip.length,
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
                    Text("Bipolar Disorder Test",
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      ),
                    ),
                  ]),
                  Text("${bip[index]}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${count} of ${bip.length}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
                          activeColor: Colors.greenAccent,
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
                        if(count <= bip.length - 1){
                          p_controller.nextPage(duration: Duration(milliseconds: 2), curve: Curves.easeIn);
                          count = count + 1;
                        }
                        }
                        if(ischecked == 1 && bip_count <= bip.length){
                          bip_count = bip_count + 1;
                        }
                        else{
                          bip_count = 0;
                        }
                        if(count > bip.length -1){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Score()));
                        }
                        
                      });
                    }, 
                    child: Text(count < bip.length  ? "Next Question":"Submit")
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
      body:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Text("Your Score ${bip_count} out of ${bip.length}",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(bip_count >=7 ? 
            "Based on Your Score you might be facing some Bipolar disorder issues"+"\n"+ "If the problem persists consider consulting a counsellor.":
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