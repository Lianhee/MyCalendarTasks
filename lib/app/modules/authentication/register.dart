import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/authentication/auth.dart';
import 'package:mycalendar/app/modules/authentication/login.dart';
import 'package:mycalendar/app/modules/authentication/validator.dart';
import 'package:mycalendar/app/modules/home/view.dart';
import 'package:mycalendar/app/modules/welcome/welcome.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _regFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const Welcome());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    "Welcome To MyCalendar",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _regFormKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    focusNode: _focusEmail,
                    validator: (value) => Validator.validateEmail(
                      email: value,
                    ),
                    decoration: InputDecoration(
                      hintText: "Email",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _focusPassword,
                    obscureText: true,
                    validator: (value) => Validator.validatePassword(
                      password: value,
                    ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.purple.shade200,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const LoginPage());
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.purple.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple.shade200, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            if (_regFormKey.currentState!.validate()) {
                              Pair pair = await Authentication
                                  .registerUsingEmailPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              if (pair.left != null) {
                                Get.to(() => const HomePage());
                              } else {
                                EasyLoading.showError(pair.right);
                              }
                            }
                          },
                          child: const Text('Create Account'),
                        ),
                      )
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
