import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perapal/components/button.dart';
import 'package:perapal/components/input_box.dart';
import 'package:perapal/helper/helper_function.dart';
import 'package:perapal/pages/login.dart';
import 'package:perapal/utils/style.dart';

class ForgotPassword extends StatefulWidget {
 const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
final emailController = TextEditingController();

@override
  void dispose () {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
      .sendPasswordResetEmail(email: emailController.text.trim());
      
      showDialog(context: context,
       builder: (context) {
        return const AlertDialog(
          content: Text("Password reset instructions sent to your email")
          );
       }
       );


    } on FirebaseAuthException catch (e) {
      displayMessageToUser(e.code, context);

  }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Forgot password?",
              style: heading2D.copyWith(fontSize: 30)
              ),
            SizedBox(
              height: small,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: large),
              child: Text("Please enter the email address associated with your account and we'll send you reset instructtions.",
              style: p2,
              ),
            ),
            
            SizedBox(
              height: medium,
            ),
        
            Padding(
              padding: EdgeInsets.symmetric(horizontal: large),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Email",
                  style: p1,),
                ],
              ),
            ),
        
            SizedBox(
              height: xsmall,
            ),
        
            CustomInputBox(
              hintText: "Enter your email ", 
            obscureText: false, 
            controller: emailController
            ),
        
            SizedBox(
              height: small,
            ),
        
        
            Button(
              buttonText: "Reset password", 
              onPressed: resetPassword
              ),

            SizedBox(
              height: large,
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                MaterialPageRoute(
                  builder: (context) => const LoginPage())
                  ); 
              },
              child: Text("Back to log in",
              style: p2.copyWith(decoration: TextDecoration.underline),
              ),
            )
          ]
        ),
        )

    );
  }
}
