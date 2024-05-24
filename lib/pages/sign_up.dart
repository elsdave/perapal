import 'package:flutter/material.dart';
import 'package:perapal/utils/style.dart';
import 'package:perapal/components/input_box.dart';
import 'package:perapal/components/button.dart'; // Import Button widget
import 'terms_page.dart';
import './login.dart';
import 'package:perapal/firebase/authentication.dart'; // Import the authentication file


class SignUpPage extends StatefulWidget {
   const SignUpPage({super.key});

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController rptpasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.only(top: medium),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    const Padding(padding: EdgeInsets.only(
                      top: 20,
                    )
                    ),
          
                  Image.asset('assets/logo1.png'),
              
                   Text(
                      "Your friendly budgeting assistance app",
                      style: p2
                    ),
                    
                    SizedBox(height: large),

                    Text(
                      "Sign Up",
                      style: heading1D.copyWith(fontSize: 30)
                    ),
                    
                    SizedBox(height: small),
                    
                    CustomInputBox(
                      hintText: 'Email',
                      obscureText: false,
                      controller: emailController
                    ),
                    const SizedBox(height: 5),
                    CustomInputBox(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController
                    ),
                    const SizedBox(height: 5),
          
                    CustomInputBox(
                      hintText: 'Repeat Password',
                      obscureText: true,
                      controller: rptpasswordController
                    ),
                    const SizedBox(height: 15),
                    
                    // Use the Button widget instead of ElevatedButton
                    Button(
                    buttonText: 'Sign Up',
                    onPressed: () async {
                      signUpUser(
                      context,
                      emailController,
                      passwordController,
                      rptpasswordController);

                    } 
                ),
                    SizedBox(
                      height: xsmall,
                    ),
          
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const TermsAndConditions()),
                        );
                      },
                      child: Text(
                        "By siging up, you agree to the Terms of Service.",
                        style: p2
                      )               
                    ),
                    
                    const SizedBox(
                      height: 75,
                    ),
          
                     GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text(
                        "Already have an account? Back to log in",
                        style: p2.copyWith(decoration: TextDecoration.underline)
                      ),                  
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
