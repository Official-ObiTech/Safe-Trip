import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:safe_trip/widget/(custom)/loading_dialog.dart';
import 'package:safe_trip/widget/(custom)/toast.dart';
import 'package:safe_trip/widget/(validators)/password.dart';
import '/widget/(custom)/text_field.dart';
import 'package:safe_trip/screens/(auth)/register.dart';
import '/widget/(validators)/email.dart';
import '/screens/home.dart';
import '/widget/(user)/info.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();


}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onSubmit() {
   final email = _emailController.text.trim().toLowerCase();
   final password = _passwordController.text.trim();

   if(email.isEmpty || password.isEmpty){
    displayToast("Please make sure to fill in all fields", context);
    }else if (!isValidEmail(email)){
      displayToast("Please enter a valid email", context);
    }else if (!isValidPassword(password)){
      displayToast("Password must be at least 6 characters", context);
    }else{
      login();
    }
  }

  void login() async {

    try{

      showDialog(
        context: context, 
        builder: (BuildContext context) => LoadingDialog() 
      );

    final User? fbUser  = ( await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim().toLowerCase(), 
        password: _passwordController.text.trim()
      ).catchError((onError){

        displayToast(onError.toString(), context);
        Navigator.pop(context);
        return onError;

      })).user;

      DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users").child(fbUser!.uid);
      await userRef.once().then((onValue){
        if(onValue.snapshot.value != null){

          userName = (onValue.snapshot.value as Map)["name"];
          userPhone = (onValue.snapshot.value as Map)["phone"];
          userEmail = (onValue.snapshot.value as Map)["email"];

          displayToast("You have successfully logged in successfully", context);

           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Home(),
      ));

        }else {
          displayToast("Record not found!", context);
        }
      });
     

    } on FirebaseAuthException catch(e) {

      displayToast(e.toString(), context);
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [

          Image.asset('assets/images/userapplogo.png',  
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.3,
          ),

          SizedBox(height: 12),

          Text(
            "Login as a User",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontFamily: "MontserratBold",
              color: Colors.white70,
            )
          ),

          Padding(
            padding: EdgeInsets.only(left:30, right: 30, top: 30, bottom: 60),
            child: Column(
              children: [
                CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 12),

                CustomTextField(
                  controller: _passwordController, 
                  label: "Password", 
                  isPassword: true,
                  ),

                  SizedBox(height: 18),

                  SizedBox(
                  width: double.infinity,
                    child: ElevatedButton(onPressed: onSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    
                    ),
                     child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "MontserratBold"
                      ),
                    )),
                  ),
              ]
            )
          ),

          SizedBox(height: 60),


TextButton(
  onPressed: () {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (c) => Register()
        ),
    );
  },
   child: Text("Don't have an account? Register",
   style: TextStyle(
    fontSize: 12,
   ),))

        ]
      )
    );
  }
}
