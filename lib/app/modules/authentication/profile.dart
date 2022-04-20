import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mycalendar/app/modules/authentication/validator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  bool _editEmail = false;
  bool _editPwd = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 162, 103, 172),
            ),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 162, 103, 172),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Text(
                          'EMAIL: ${user!.email}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _editEmail = !_editEmail;
                              });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                    (_editEmail)
                        ? TextFormField(
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
                          )
                        : const Padding(padding: EdgeInsets.zero),
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Text(
                          'Password: *************',
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _editPwd = !_editPwd;
                              });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                    (_editPwd)
                        ? TextFormField(
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
                          )
                        : const Padding(padding: EdgeInsets.zero),
                    (_editEmail || _editPwd)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple.shade200, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                user.updateEmail(_emailController.text);
                                user.updatePassword(_passwordController.text);
                                EasyLoading.showSuccess('Successful edit');
                                Get.back();
                              }
                            },
                            child: const Text('Change'))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade300, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {},
                            child: const Text('Change'),
                          ),
                  ],
                ),
              ),
            )));
  }
}
