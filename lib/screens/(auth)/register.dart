

import 'package:flutter/material.dart';
import 'package:safe_trip/screens/(auth)/login.dart';
import 'package:safe_trip/widget/(custom)/text_field.dart';
import '/widget/(validators)/name.dart';
import '/widget/(validators)/email.dart';
import '/widget/(validators)/password.dart';
import '/widget/(validators)/phone.dart';
import '/widget/(custom)/toast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register>  createState() => _RegisterState();
}


class _RegisterState extends State<Register> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  void onSubmit() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();
    // final confirmPassword = _confirmPasswordController.text.trim();
    final phone = _phoneController.text.trim();

    if(name.isEmpty || email.isEmpty || password.isEmpty  || phone.isEmpty){
      displayToast("Please make sure to fill in all fields", context);
    }else if (!isValidName(name)){
      displayToast("Please enter a valid name", context);
    }else if (!isValidEmail(email)){
      displayToast("Please enter a valid email", context);
    }else if (!isValidPassword(password)){
      displayToast("Password must be at least 6 characters", context);
    }else if (!isValidPhone(phone)){
      displayToast("Please enter a valid phone number", context);
    }else{
      
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

                  Container(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: Text("Register"))),
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