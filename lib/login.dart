import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';




class Login extends StatefulWidget{
  const Login({Key?key}): super(key: key);

@override
State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login>{
   bool _obscuretext = true;



   String? password;
   //state for controller
   final myEmail = TextEditingController();
   final myPassword = TextEditingController();
   
   final logkey = GlobalKey<FormState>();
   final _scfstate = GlobalKey<ScaffoldState>();
   
    
    //Password toggle function
    void toggle(){
        setState(() {
       _obscuretext = !_obscuretext;
      });
      
    }
    

    @override
    void dispose(){
      myEmail.dispose();
      myPassword.dispose();
      super.dispose();
    }
    
    
    @override
    Widget build(BuildContext context){

//User Login  
    Future<void> User_Login() async{
      if(logkey.currentState!.validate()){
        FirebaseAuth.instance
        .signInWithEmailAndPassword(email: myEmail.text, password: myPassword.text)
        .then((value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder:(context) => Home()),
          (route) => false))
        .catchError((e) {
          final FirebaseAuthException err = e; 
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.message}"),elevation: 4));  
        });
        }
    }
//Counsellor login
    Future<void> Coun_Login() async{
      if(logkey.currentState!.validate()){
        FirebaseAuth.instance
        .signInWithEmailAndPassword(email: myEmail.text, password: myPassword.text)
        .then((value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder:(context) => Home()),
          (route) => false))
        .catchError((e) {
          final FirebaseAuthException err = e; 
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${err.message}"),elevation: 4));  
        });
      }
    }

      return Scaffold(
        resizeToAvoidBottomInset: false,
        body:Form(
          key: logkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            //Top Toxt
            Padding(
              padding: EdgeInsets.only(right: 270),
              child: Text("LogIn",style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
                textAlign: TextAlign.end,
                ),
            ),
            //Email Field
            Padding(
            padding: const EdgeInsets.only(),
            child:TextFormField(
              initialValue: null,
              controller: myEmail,
              validator: (value){
              if(value == null || value.isEmpty){
                return "Email can't be empty";
              }
              else if(!value.startsWith("[0-9][@#%^&*()!~`{}\\|/?,;:'-_+=]") && !value.contains("@")){
                if(!value.endsWith(".")){
                return "Email format not valid";
              }
              }
                return null;
              },
              decoration: const InputDecoration(
                hintText:"Enter Email",
                border:OutlineInputBorder(),
                label:Text("Email"),
              ),
              
              ),
          ),
            
          
          //Password Field
            Padding(
            padding:const EdgeInsets.only(),
            child:TextFormField( 
              initialValue: null,
              controller: myPassword,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Password can't be empty";
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(onPressed:toggle,icon:Icon(_obscuretext ? Icons.remove_red_eye: Icons.remove_red_eye_outlined)),
                hintText: "Enter Password",
                label: Text("Password")
              ),
              obscureText: _obscuretext,
              onSaved: (val) => password=val, 
              ),
            ),
            //Login button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child:TextButton(
                  key: Key("btn_key"),
                  onPressed:() {
                    FutureBuilder(
                          future: Coun_Login(),
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
                  style:TextButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.black,
                    backgroundColor:Colors.pink.withOpacity(0.8),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    fixedSize:const Size(350, 50)),
                  child:const Text('Login'),
                ),
              ),
             
          Row(
            children: [
              Text("Don't have an account?"),
              TextButton(
                onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => Signup())), 
                child: Text("Signup")
                )
            ],
          )
          ])
          )
      );
      
    }
  }



