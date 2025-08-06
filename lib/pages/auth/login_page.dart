import 'package:flutter/material.dart';
import 'package:siraat/buttons/google_btn.dart';
import 'package:siraat/pages/auth/signup_screen.dart';

import '../../Themes/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset('assets/images/logo.png'),
              SizedBox(height: 10),
              Text(
                "Login",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.darkgreen,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.password,
                            color: AppColors.darkgreen,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.darkgreen),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 160,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkgreen,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Sign in"),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                text: "Register",
                                style: TextStyle(color: AppColors.darkgreen),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked = newValue!;
                              });
                            },
                          ),
                          Text(
                            "I agree to the terms and conditions",
                            style: TextStyle(color: AppColors.darkgreen),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      GoogleBtn(onPressed: (){})
        
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
