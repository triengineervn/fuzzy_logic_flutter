import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuzzy/models/user_model.dart';
import 'package:flutter_fuzzy/modules/authentication/login_screen.dart';
import 'package:flutter_fuzzy/themes/app_assets.dart';
import 'package:flutter_fuzzy/themes/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

const sizeboxCustom = SizedBox(
  height: 8,
);

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences sharedPreferences;

  late String email;
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    db.collection("users").doc(user?.uid).get().then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      initial();
    });
  }

  Future<void> logout(BuildContext context) async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> initial() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email = sharedPreferences.getString('email')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuzzy Logic Control'),
        centerTitle: true,
        backgroundColor: AppColors.APP_PRIMARY_BUTTON,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset(AppAssets.water, fit: BoxFit.contain),
              ),
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              sizeboxCustom,
              Text(
                "${loggedInUser.firstName} ${loggedInUser.secondName}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${loggedInUser.email}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              sizeboxCustom,
              ElevatedButton(
                onPressed: () {
                  sharedPreferences.setBool('login', true);
                  logout(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcons.logout,
                    SizedBox(width: 5),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
