import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:developer';

import '../model/registering_user.dart';
import '../services/login_authentification_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  Color obscurePasswordColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Placeholder();

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: generateView(context)),
        ),
      ),
    );
  }

  List<Widget> generateView(BuildContext context) {
    return [
      //-------------------------------Welcome------------------------------
      Image.asset(
        'images/logo.png',
        width: 200,
        height: 200,
      ),

      const Text(
        "Welcome To Lockify",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text("Login to start securely saving your data",
          style: TextStyle(fontSize: 18)),

      const SizedBox(
        height: 50,
      ),

      //---------------------------Username Field------------------------
      FractionallySizedBox(
        widthFactor: .5,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white)),
          child: TextField(
            autofocus: true,
            obscureText: false,
            controller: _emailController,
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Email",
                contentPadding: EdgeInsets.only(left: 25, top: 5)),
          ),
        ),
      ),

      const SizedBox(
        height: 10,
      ),
      //--------------------------Password Field-------------------------
      FractionallySizedBox(
        widthFactor: .5,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white)),
          child: TextField(
            autofocus: false,
            obscureText: obscurePassword,
            controller: _passwordController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: obscurePasswordColor,
                  splashRadius: 1,
                  icon: Icon(CupertinoIcons.eye),
                  onPressed: () => setState(() {
                    obscurePassword = !obscurePassword;
                    obscurePasswordColor =
                        (obscurePasswordColor == Colors.purple)
                            ? Colors.grey
                            : Colors.purple;
                  }),
                ),
                border: InputBorder.none,
                hintText: "Password",
                contentPadding: EdgeInsets.only(left: 25, top: 5)),
          ),
        ),
      ),

      const SizedBox(
        height: 10,
      ),
      //----------------------------Login Button-----------------------------
      //todo : validate input
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            minimumSize: Size(100, 40),
          ),
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : const Text("Login"),
          onPressed: () async {
            if (!isLoading) {
              setState(() {
                isLoading = true; // Set loading to true
              });

              try {
                await LoginAuthService.signInWithEmailAndPassword(
                  context,
                  _emailController.text,
                  _passwordController.text,
                );
              } catch (e) {
                log("Login failed: $e");
              } finally {
                setState(() {
                  isLoading = false; // Reset loading to false
                });
              }
            }
          }),
      const SizedBox(
        height: 20,
      ),

      //----------------------------Register Button-----------------------------
      ElevatedButton(
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: ((context) =>
                        AlertDialog(content: LoginPageRegistration())))
              }, //LoginAuthService.registerNewUser(context)},
          child: const Text("New? No worries, click here to register!"))
    ];
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class LoginPageRegistration extends StatefulWidget {
  const LoginPageRegistration({Key? key}) : super(key: key);

  @override
  State<LoginPageRegistration> createState() => _LoginPageRegistrationState();
}

class _LoginPageRegistrationState extends State<LoginPageRegistration> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? registrationException;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: 700,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: generateView(context),
          )),
    );
  }

  List<Widget> generateView(BuildContext context) {
    return [
      SizedBox(
        height: 350,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close")),
              const Text(
                "Create an Account",
                style: TextStyle(fontSize: 30),
              ),
              Container(
                  child: (registrationException != null)
                      ? Text(
                          style: TextStyle(color: Colors.red),
                          registrationException as String)
                      : null),
              getTextField(firstNameController, "First Name", false),
              getTextField(lastNameController, "Last Name", false),
              getTextField(emailController, "Email", false),
              getTextField(passwordController, "Password", true),
            ],
          ),
        ),
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            minimumSize: Size(100, 40),
          ),
          child: const Text("Create Account"),
          onPressed: (() async {
            //validate the fields have good values
            if (_formKey.currentState!.validate()) {
              //the form is good!
              log("Registering new user");
              String exception = await LoginAuthService.registerNewUser(
                  context,
                  RegisteringUser(
                      firstNameController.text,
                      lastNameController.text,
                      emailController.text,
                      passwordController.text,
                      "none")) as String;
              setState(() {
                registrationException = exception;
              });
            } else {
              print("Bad form");
            }
          })),
    ];
  }

  getTextField(TextEditingController controller, String label, bool obscure) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white)),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          autofocus: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $label';
            }
            return null;
          },
          obscureText: obscure,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: label,
              contentPadding: const EdgeInsets.only(left: 25, top: 5)),
        ),
      ),
    );
  }
}
