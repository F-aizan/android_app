import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fproject/login.dart';
import 'problems.dart';
import 'appointments.dart';






class Home extends StatelessWidget{
   Home({super.key});

  final bool theme = false;
  final String v = "Light";
  
  
  @override
  Widget build(BuildContext context) {

//Signing out Current User
    Future<void> signOut() async{
      FirebaseAuth.instance.signOut()
      .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged out successfully"),elevation: 4)))
      .catchError((onError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Problem logging out"),elevation: 4));
      });
    }

  
    return Scaffold(
          appBar:AppBar(
            title:Text("Mental Health"),
          ),
          //bottom
          body: const MyCard(),
          drawer:Drawer(
            width: 210,
              child: ListView(
                padding: const EdgeInsets.only(top: 20),
                children: [
                  //login or logout button
                      StreamBuilder(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (context,snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return CircularProgressIndicator();
                              }
                              else if(FirebaseAuth.instance.currentUser != null){
                                return Column(
                                  children:[
                                    Icon(Icons.person,size: 30),
                                    ListTile(
                                      title: Text("Welcome"),
                                      minVerticalPadding: 3,
                                      subtitle: Text("${FirebaseAuth.instance.currentUser!.email}"),
                                    ),
                                    ListTile(
                                    title: Text("Logout"),
                                    trailing: Icon(Icons.arrow_forward),
                                    leading: Icon(Icons.logout),
                                    minLeadingWidth: 2,
                                    onTap: (){
                                      FutureBuilder(
                                        future: signOut(),
                                        builder: (context,snapshot) {
                                          if(snapshot.connectionState == ConnectionState.waiting){
                                            return CircularProgressIndicator();
                                          }
                                          else if(snapshot.hasData){
                                            return Text("${snapshot.data}"); 
                                          }
                                          else{
                                            return Text("${snapshot.error}");
                                          }
                                      
                                        });
                                      
                                    }
                                  )
                                  ]);
                              }
                              else{
                                return ListTile(
                                  title: Text("Login"),
                                  leading: Icon(Icons.login),
                                  minLeadingWidth: 2,
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap:(){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
                                  }
                                );
                              }
                            }
                            ),
                            ListTile(
                              title: Text("Tests"),
                              leading: Icon(Icons.medical_information),
                              trailing: Icon(Icons.arrow_forward),
                              minLeadingWidth: 2,
                              onTap: () {
                                if(FirebaseAuth.instance.currentUser != null){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => const Tests()));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You need to be logged in")));
                                }
                              }
                            ),
                            ListTile(
                              title: Text("Appointments"),
                              leading: Icon(Icons.person),
                              trailing:Icon(Icons.arrow_forward),
                              minLeadingWidth: 2,
                              onTap: (){
                                if(FirebaseAuth.instance.currentUser != null){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Bookings()));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    elevation: 4,
                                    content: Text("You need to be logged in")),
                                    );
                                }
                              },
                            
                          ),
                          
                          ListTile(
                            title: Text("About"),
                            leading: Icon(Icons.info),
                            minLeadingWidth: 2,
                            trailing: Icon(Icons.arrow_forward),
                            onTap: (){},
                            )
                      ],
                ),
              ),
            );
        
      } 
       
}


//images to display
final images = [
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.Yw3feb8ztBFprvGLVxwG9gHaJ_%26pid%3DApi&f=1&ipt=e333810ad171bf67ca0ce4e387c6da6547bdba661e81270b167fea142ea49959&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP._96GAJ41Fu-y8NGDzRR9hgHaGN%26pid%3DApi&f=1&ipt=9faed9dbd117193bfbc6a07d14ff4a98c24ec01c1c4fae7603e475dd3c86e2c5&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.At_rIkZ6jBkKbzU5IggUdgHaLH%26pid%3DApi&f=1&ipt=0948d451dabcc8487bc2a0684033642dc256446f5826f81b2ff64c2cc5caccd7&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.ob8nMTIbJzIke64CeVrnIQHaHa%26pid%3DApi&f=1&ipt=2fe1cbbdf5746564e073ddd29e251e19456c7aa4583e9470cac25aa16b86d87f&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.XwgSRZ8abQkhDJN5E4Vg0gHaHa%26pid%3DApi&f=1&ipt=347006942f8c801ac1bb2a8a8554938e78de7691d767bdb8f2778aed11feab68&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.5LBGUQkK31t91S1ZYSnXOAHaFf%26pid%3DApi&f=1&ipt=fdaf9d29559cb26e8aa3990f90dedb868c343ea16cc94620d7e351406fb4e63c&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.E0wxsZ7ZlmZMd5Fg_QrZ7QHaDy%26pid%3DApi&f=1&ipt=e4fdc2afcef750d1f6f14b39db1600dd9552d78d78524cd5c89efae1153bdd8d&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP._h7wdJxpktAskRYm03ZTZgHaOh%26pid%3DApi&f=1&ipt=e0224f0b60a74bcd42e4082d68ce423c6cd9304d0e43ecc76f2b21a600e4cdf0&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.QrpXUfBBI_p5EevMCDsyAwHaHa%26pid%3DApi&f=1&ipt=db84c1a5ef613af7d2e28fa847e69b88af324e889b59694e31f3036f00eb52eb&ipo=images"
];

//My card widget
class MyCard extends StatefulWidget{
  const MyCard({super.key});

@override
State<MyCard> createState() => CardState();
}
class CardState extends State<MyCard>{

  PageController _pageController = PageController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:PageView.builder(
            scrollDirection: Axis.vertical,
            controller:_pageController,
            itemCount: images.length,
            itemBuilder:(context,index){
              return Image.network(
                images[index],
                fit: BoxFit.fill,
                loadingBuilder: ((context,child,loadingProgress) {
                  if(loadingProgress == null ) return child;
                  else{
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        :null,
                      ),
                    );
                  }
                }),
              );
            }
          ), 
    );
  }
}



