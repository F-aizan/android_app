import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import  'package:firebase_auth/firebase_auth.dart';



 final formkey = GlobalKey<FormState>();

//Signup class
class Signup extends StatefulWidget{
  
  @override
  State<Signup> createState() => Signupstate();

}

class Signupstate extends State<Signup>{

  bool obscureText = true;
  final myname = TextEditingController();
  final myPassword = TextEditingController();
  final confpass = TextEditingController();
  final myEmail = TextEditingController();

  


  @override
  void toggle(){
    setState(() {
      obscureText = !obscureText;
    });
  }


  @override
  Widget build(BuildContext context){

//Adding  user 
  Future<void> addUser() async{
    if(formkey.currentState!.validate()){
     var ref = FirebaseFirestore.instance.collection('Users');
     FirebaseAuth.instance.createUserWithEmailAndPassword(email: myEmail.text,password: myPassword.text)
      .then((value) => 
       ref.add({
        "Name":myname.text,
        "Email":myEmail.text,
        "Pasword":myPassword.text
        }))
      .then((value) =>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signed up successfully"),elevation: 4)))
      .catchError((e) { 
        final FirebaseAuthException err = e;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${err.message}")));
      });
    } 
  }

  Future<void> addCoun() async{
    if(formkey.currentState!.validate()){
     var cou = FirebaseFirestore.instance.collection('Counsellors');
     FirebaseAuth.instance.createUserWithEmailAndPassword(email: myEmail.text,password: myPassword.text)
      .then((value) => 
       cou.add({
        "Name":myname.text,
        "Email":myEmail.text,
        "Pasword":myPassword.text
        }))
      .then((value) =>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signed up successfully"),elevation: 4)))
      .catchError((e) { 
        final FirebaseAuthException err = e;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${err.message}")));
      });
    }
    
  }

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body:Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children:<Widget> [
          //Top Toxt
            Padding(
              padding: EdgeInsets.only(right: 270),
              child: Text("Signup ",style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
                textAlign: TextAlign.end,
                ),
            ),
          //Name field
          Padding(padding: EdgeInsets.only(bottom: 30),
          child:TextFormField(
            controller: myname,
            initialValue: null,
            validator: (value) {
              if(value == null || value.isEmpty){
                return "Name can't be empty";
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Name"),
              hintText: "Full Name"
            ),
            ),
          ),


          //Email field
          Padding(padding:EdgeInsets.only(),
          child: TextFormField(
            initialValue: null,
            controller: myEmail,
            validator: (value) {
            if(value == null || value.isEmpty){
              return "Email can't be empty";
            }
            else if(!value.startsWith("[0-9][@#%^&*()!~`{}\|/?,;:'-_+=]") && !value.contains("@")){
              if(!value.endsWith(".")){
              return "Email format not valid";
            }
            }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Email"),
              hintText: "Enter Email"
            ),
            ),
          ),
          
          //Password field
          Padding(padding: EdgeInsets.only(),
            child: TextFormField(
              initialValue: null,
              controller: myPassword,
              validator:(value) {
                if(value == null || value.isEmpty){
                  return "Password can't be empty";
                }
                else if(value.length < 8){
                  return "Password too short";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Password"),
                hintText: "Enter Password",
                suffixIcon: IconButton(onPressed: toggle, icon:Icon(obscureText ? Icons.remove_red_eye: Icons.remove_red_eye_outlined))
              ),
              obscureText: obscureText,
              ),
            ),
            
          //Re-enter password Field
            Padding(
              padding: EdgeInsets.only(),
            child: TextFormField(
              initialValue: null,
              controller: confpass,
              validator:(value) {
                if(value != myPassword.text)
                return "Passwords do not match";
              },
              decoration: InputDecoration(
                border:OutlineInputBorder(),
                label: Text("Re-Enter Password"),
                hintText: "Confirm Password",
              ),
              obscureText: true,
              ),
            ),
            //Signup Counsellor
            TextButton(
              onPressed: (){
                FutureBuilder(
                  future: addUser(),
                  builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                    }
                  else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  else{
                    return Text("${snapshot.data}");
                  }
                }
                );
              },
                style: TextButton.styleFrom(
                  elevation: 10,
                  shadowColor: Color(0xFF000000),
                  backgroundColor:Color.fromARGB(255, 199, 22, 169).withOpacity(0.8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  fixedSize: Size(350, 50)),
                child: Text("Signup as User"),
            ),

              //Signup Button
            TextButton(
              onPressed: (){
                FutureBuilder(
                  future: addCoun(),
                  builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                    }
                  else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  else{
                    return Text("${snapshot.data}");
                  }
                }
                );
              },
                style: TextButton.styleFrom(
                  elevation: 10,
                  shadowColor: Color(0xFF000000),
                  backgroundColor:Color.fromARGB(255, 199, 22, 169).withOpacity(0.8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  fixedSize: Size(350, 50)),
                child: Text("Signup as Counsellor"),
            ),

          ])
      )
      );  
  }
}


  



