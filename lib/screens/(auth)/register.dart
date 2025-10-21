

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:safe_trip/screens/(auth)/login.dart';
import 'package:safe_trip/widget/(custom)/loading_dialog.dart';
import 'package:safe_trip/widget/(custom)/text_field.dart';
import '/widget/(validators)/name.dart';
import '/widget/(validators)/email.dart';
import '/widget/(validators)/password.dart';
import '/widget/(validators)/phone.dart';
import '/widget/(custom)/toast.dart';
import '/screens/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register>  createState() => _RegisterState();
}


class _RegisterState extends State<Register> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void onSubmit() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();
    // final confirmPassword = _confirmPasswordController.text.trim();
    final phone = _phoneController.text.trim();

    if(name.isEmpty || email.isEmpty || password.isEmpty  || phone.isEmpty){
      displayToast("Please make sure to fill in all fields", context);
    }else if (!isValidName(name)){
      displayToast("Name charater should be greter then 3", context);
    }else if (!isValidEmail(email)){
      displayToast("Please enter a valid email", context);
    }else if (!isValidPassword(password)){
      displayToast("Password must be at least 6 characters", context);
    }else if (!isValidPhone(phone)){
      displayToast("Phone number should be greter then 11 or less then 11", context);
    }else{
      createAccount();
    }
  }

  void createAccount() async {
    try{

      showDialog(
        context: context, 
        builder: (BuildContext context) => LoadingDialog(),
      );

    final User? fbUser = (await FirebaseAuth.instance.createUserWithEmailAndPassword(

      email: _emailController.text.trim().toLowerCase(), 
      password: _passwordController.text.trim(),
    ).catchError((onError){

      displayToast(onError.toString(), context);
      Navigator.pop(context);

      return onError;
    })).user;

    Map userData = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim().toLowerCase(),
      "password": _passwordController.text.trim(),
      "phone": _phoneController.text.trim(),
      "uid": fbUser!.uid,
    };

    FirebaseDatabase.instance.ref("users").child(fbUser.uid).set(userData);
    displayToast("You have successfully registered", context);

    FirebaseAuth.instance.signOut();

    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

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

          SizedBox(height: 18),

          Text(
            "Register as a User",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontFamily: "MontserratBold",
              color: Colors.white70,
            ),
          ),

          SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 24, bottom: 60),
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: "Name",
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: 18),

                CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 18),

                CustomTextField(
                  controller: _passwordController, label: "Password", isPassword: true,),

                // SizedBox(height: 18),

                // CustomTextField(
                //   controller: _confirmPasswordController, label: "Confirm Password", isPassword: true,),

                SizedBox(height: 18),

                CustomTextField(
                  controller: _phoneController, 
                  label: "Phone", 
                  keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: onSubmit, child: Text("Register"))),
              ],
            ),
          ),

        SizedBox(height: 18),

        TextButton(
          onPressed: (){
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          child: Text("Alreaddy   have an account? Login",
          style: TextStyle(
            fontSize: 12,
          ),),
        ),
      ],
    ),
  );
  }
}