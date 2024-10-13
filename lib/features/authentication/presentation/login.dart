import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.red,
                  child: Image.asset("assets/images/login.jpg"),
                ),
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  "Login",
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.blue,
                  child: Placeholder(),
                ),
              ),
              Expanded(
                  child: Container(
                    color: Colors.green,
                  ),
                  flex: 2)
            ],
          ),
        ),
      ),
    );
  }
}
