import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//messages
class Chat extends StatelessWidget{
  const Chat({super.key});


  @override
  Widget build(BuildContext context) {

   final t_key = TextEditingController(); 

  String? msg;

  Future<void> Send_Messages() async{

    final ref = FirebaseFirestore.instance.collection("Messages");
    if(FirebaseAuth.instance.currentUser != null){
      if(t_key.value != null){
        ref
        .add({
          "message":t_key.value.text,
          "Time": DateTime.now(),
          "User":FirebaseAuth.instance.currentUser!.email
        })
        .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e"))));
      
      }
    }
   }
   
    return Scaffold(
      body:Container(
        alignment: Alignment.bottomCenter,
        child:TextField(
            controller: t_key,
            onChanged: (value){
              msg= t_key.text;
            },
            decoration: InputDecoration(
              hintText: "Enter message here",
              suffixIcon: IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context) => AlertDialog(content: Text("$msg")));
                }, 
              icon: Icon(Icons.forward)
              ),
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
        ),
      )
    );
  }
  
}



