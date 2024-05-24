import 'package:flutter/material.dart';
import 'package:perapal/components/input_box.dart';
import 'package:perapal/components/button.dart';
import 'package:perapal/pages/forgot_password.dart';
import 'package:perapal/utils/style.dart';
import './sign_up.dart';
import 'package:perapal/firebase/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return PopScope( 
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo1.png'),
                  Text(
                    "Your friendly budgeting assistance app",
                    style: p2,
                  ),
                   SizedBox(height: large),
      
                   Text(
                     "Log in",
                     style: heading1D.copyWith(fontSize: 30)
                   ),
                  
                  SizedBox(height: small),
      
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: CustomInputBox(
                      hintText: 'Email',
                      obscureText: false,
                      controller: emailController,
                    ),
                  ),
                  
                  
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: CustomInputBox(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                    ),
                  ),
                  
                  
                  const SizedBox(height: 5),
      
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: large),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => const ForgotPassword())
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: p2.copyWith(color: Colors.grey)
                            ),
                            ),
                           ],
                        ),
                    ),
                  
                  
                  
                  const SizedBox(height: 20),
              
                  Button(
                    buttonText: 'Login', // Customize button text
                    onPressed: () => loginUser(context, 
                                              emailController,
                                              passwordController),
                  ),
                  
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child:  Text(
                        "No account yet? Sign up.",
                        style: p2.copyWith(decoration: TextDecoration.underline)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );   
  }
}
