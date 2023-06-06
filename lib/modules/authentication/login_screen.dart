// ignore_for_file: unnecessary_new, unused_field, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuzzy/modules/authentication/regis_screen.dart';
import 'package:flutter_fuzzy/modules/widgets/bottom_navigation_menu.dart';
import 'package:flutter_fuzzy/themes/app_assets.dart';
import 'package:flutter_fuzzy/themes/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences sharedPreferences;
  late bool newUser;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email.";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: AppIcons.email,
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: _obscureText,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: _toggle, child: _obscureText ? AppIcons.visibility_off : AppIcons.visibility),
        prefixIcon: AppIcons.password,
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: AppColors.APP_PRIMARY_BUTTON,
      child: MaterialButton(
        padding: const EdgeInsets.all(16),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          String email = emailController.text;
          String password = passwordController.text;
          signIn(email, password);
        },
        child: const Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.WHITE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    const sizeboxCustom = SizedBox(
      height: 8,
    );
    return Scaffold(
      backgroundColor: AppColors.APP_BACKGROUND,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.APP_BACKGROUND,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(AppAssets.water),
                    ),
                    sizeboxCustom,
                    Center(
                      child: Text(
                        'Fuzzy logic'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    sizeboxCustom,
                    Center(
                      child: Text(
                        'water'.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.BLUE_GREEN,
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    sizeboxCustom,
                    sizeboxCustom,
                    sizeboxCustom,
                    emailField,
                    sizeboxCustom,
                    passwordField,
                    sizeboxCustom,
                    loginButton,
                    sizeboxCustom,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegistrationScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: AppColors.APP_PRIMARY_BUTTON,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              sharedPreferences.setBool('login', false),
              sharedPreferences.setString('email', email),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const BottomNavigationCustom())),
            });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  // ignore: non_constant_identifier_names
  void check_if_already_login() async {
    sharedPreferences = await SharedPreferences.getInstance();
    newUser = (sharedPreferences.getBool('login') ?? true);
    if (newUser == false) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNavigationCustom()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
