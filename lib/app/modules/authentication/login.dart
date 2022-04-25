import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/authentication/auth.dart';
import 'package:mycalendar/app/modules/authentication/register.dart';
import 'package:mycalendar/app/modules/authentication/validator.dart';
import 'package:mycalendar/app/modules/controller.dart';
import 'package:mycalendar/app/modules/home/view.dart';
import 'package:mycalendar/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    "Welcome Back !",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Sign in for continue",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade200,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      controller: _emailController,
                      focusNode: _focusEmail,
                      validator: (value) =>
                          Validator.validateEmail(email: value),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      controller: _passwordController,
                      focusNode: _focusPassword,
                      obscureText: true,
                      validator: (value) =>
                          Validator.validatePassword(password: value),
                    ),
                  ],
                ),
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
                        if (_formKey.currentState!.validate()) {
                          Pair pair =
                              await Authentication.signInUsingEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context,
                          );
                          if (pair.left != null) {
                            int end = _emailController.text.indexOf('@');
                            String username =
                                _emailController.text.substring(0, end);
                            printInfo(info: 'there is login $username');
                            await init(username);

                            Get.to(() => const HomePage());
                          } else {
                            EasyLoading.showError(pair.right);
                          }
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 145, 120, 180),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const RegisterPage());
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 145, 120, 180),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
