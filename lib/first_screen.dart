import 'package:flutter/material.dart';
import 'package:fproject/home.dart';
import 'login.dart';
import 'home.dart';

class First extends StatelessWidget{
  const First({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(image: DecorationImage(
              image: AssetImage("assets/images/welcome_screen.jpg"),
              fit: BoxFit.contain
              )),
          ),
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: Size(350,50),
              backgroundColor: Colors.purple.withOpacity(0.7),
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
            }, 
            child: Text("Login")
            ),
            
        ],
      )

    );
  }
  
}