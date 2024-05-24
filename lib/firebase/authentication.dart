import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:perapal/helper/helper_function.dart';
import 'package:perapal/pages/login.dart';
import 'package:perapal/pages/onboarding.dart';
import 'package:perapal/firebase/interactions.dart'; // Import the interactions.dart file
import 'package:perapal/pages/home_page.dart';

Future<void> signUpUser(BuildContext context, 
    TextEditingController emailController, 
    TextEditingController passwordController,
    TextEditingController rptpasswordController) async {

  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  // Validate that none of the fields are empty
  if (emailController.text.isEmpty || 
      passwordController.text.isEmpty || 
      rptpasswordController.text.isEmpty) {
    Navigator.pop(context);
    displayMessageToUser("Every field should have an input", context);
    return;
  }

  // Validate password length and complexity
  String password = passwordController.text;
  if (password.length < 8 || 
      password.length > 32 || 
      !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,32}$').hasMatch(password)) {
    Navigator.pop(context);
    displayMessageToUser("Password must be 8-32 characters long, containing a mix of letters and numbers", context);
    return;
  }

  if (password != rptpasswordController.text) {
    Navigator.pop(context);
    displayMessageToUser("Passwords do not match", context);
    return;
  }

  try {
    UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    await addDefaultData(); // Call the addDefaultData function
    if (context.mounted) Navigator.pop(context);
    Navigator.push(context, 
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoginPage())
    );
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    displayMessageToUser(e.code, context);
  }
}



void loginUser(BuildContext context,
              TextEditingController emailController, 
              TextEditingController passwordController,) async {
  showDialog(context: context, 
  builder: (context) => const Center(
    child: CircularProgressIndicator(),
   ),
   );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text);
      
    if (context.mounted) Navigator.pop(context);
    Navigator.push(context, 
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const HomePage())
    );
  } 

  on FirebaseAuthException catch (e) {

    Navigator.pop(context);
    displayMessageToUser(e.code, context);
  }
  
}
