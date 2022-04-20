import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/authentication/login.dart';
import 'package:mycalendar/app/modules/authentication/register.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(50),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/computer.png'))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "MyCalendar",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 50, 138),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const LoginPage());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 100),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: const Color.fromARGB(255, 186, 149, 230),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 9),
                              blurRadius: 10,
                            )
                          ]),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 100),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const RegisterPage());
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 145, 120, 180),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
