import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


//Booking Appointments  
class Bookings extends StatefulWidget {
  const Bookings({super.key});

@override
State<Bookings> createState() => BookingState();
}

class BookingState extends State<Bookings>{

  final form_key = GlobalKey<FormState>();
  DateTime in_date = DateTime(2022,12,20);
  TimeOfDay t_now = TimeOfDay(hour: 09, minute: 33);
  final d_controller = TextEditingController();
  final t_controller = TextEditingController();
  String? _value;
  


  Future<DateTime?> getdate() =>
  showDatePicker(
    context: context,
    initialDate: in_date, 
    firstDate: DateTime(2022,4,4), 
    lastDate: DateTime(2022,23,12),
  );

  Future<TimeOfDay?> gettime() =>
    showTimePicker(
      context: context,
      initialTime: t_now,
    );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: form_key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Book Your Appointments Here",style: TextStyle(fontWeight: FontWeight.bold)),

            DropdownButtonFormField(
              value: _value,
              hint: Text("Choose Counsellor"),
              items: [
                DropdownMenuItem(child: Text("Shahista Akhter"),value: "Shahista Akhter",),
                DropdownMenuItem(child: Text("Tahmeena Shaban"),value: "Tahmeena Shaban",),
                DropdownMenuItem(child: Text("Ashiq Hussain Zaki"),value: "Ashiq Hussain Zaki",),
                DropdownMenuItem(child: Text("Waheeda Rafiq"),value: "Waheeda Rafiq",),
                DropdownMenuItem(child: Text("Rasiya Kashani"),value: "Rasiya Kashani",),
              ], 
              onChanged: (dynamic value){
                setState(() {
                  _value = value.toString();
                });
              }  
              ),
            TextFormField(
              controller:d_controller,
              decoration:InputDecoration(
                hintText:"Appointment Date",
                labelText: "Date",
                suffixIcon: IconButton(
                  onPressed: ()async{
                    final date = await getdate();
                    if(date == null) return;
                    else{
                      setState(() {
                        d_controller.text = date.toString().replaceFirst("00:00:00.000", "");
                      });
                    }
                  },
                  icon:Icon(Icons.calendar_today)
                  ),
              )
            ),
            TextFormField(
              controller:t_controller,
              onChanged: (value){
                setState(() {
                  t_controller.text = value;  
                });
              },
              decoration:InputDecoration(
                hintText: "Appointment Time",
                labelText: "Time",
                suffixIcon: IconButton(
                  onPressed: () async{
                    final time = await gettime();
                    if(time == null) return;
                    else{
                      setState(() {
                        t_controller.text = time.toString().replaceFirstMapped("TimeOfDay(", (match) => "");
                    });
                  }
                  },
                  icon:Icon(Icons.lock_clock),
                  )
              )
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.purpleAccent.withOpacity(0.5),
                fixedSize: Size(300,30),
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
              onPressed: (){
                if(d_controller.value.text != "" && t_controller.value.text != ""){
                  if(_value != null){
                FirebaseFirestore.instance.collection("Appointments")
                .add({
                  "Counsellor Name":_value,
                  "Date": d_controller.text,
                  "Time": t_controller.text,
                  "uid":FirebaseAuth.instance.currentUser!.email
                })
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Appointment set successfully"))))
                .catchError((e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
                });
                  }
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill the details correctly")));
                }
              }, 
              child: Text("Submit")
              )
            ])
        ),
    );
  }
}
