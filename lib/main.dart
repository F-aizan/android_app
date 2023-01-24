import 'package:flutter/material.dart';
import 'package:fproject/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fproject/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fproject/problems.dart';
import 'first_screen.dart';
import 'new.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


final Map<String, WidgetBuilder> routes = {
    "/home":(context) => Home()
  };


class MyApp extends StatelessWidget{
    
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
    
      return MaterialApp(
            title: "My app",
            routes: routes,
            theme: ThemeData(
              primarySwatch:Colors.lightBlue,
            ),
            home:Scaffold(
            body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context,snapshot){
                if(FirebaseAuth.instance.currentUser != null){
                  return Home();
                }
                else{
                  return First();
                }
              }
              )
            
            ),
          
      );
     }
}
