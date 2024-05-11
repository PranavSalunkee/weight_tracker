import 'package:flutter/material.dart';
import 'package:weight_tracker/ui/button/elevated_button.dart';
import 'package:weight_tracker/ui/textField/text_field.dart';

import '../../services/cache/shared_manager.dart';
import '../home/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late SharedManager manager;
  String? userName;
  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Colors.transparent));

  Future<void> _initialize() async {
    manager = SharedManager();
    await manager.init();
    goToHome();
  }

  void goToHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeView(
                  manager: manager,
                  userName: userName ?? '',
                )));
  }

  final TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Welcome', style: TextStyle(fontSize: 40)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 20),
                controller: userNameController,
                decoration: const InputDecoration(
                  enabledBorder: outlineInputBorder,
                  border:  InputBorder.none,
                  label: Center(
                      child: Text(
                    'Enter Your User Name',
                    style: TextStyle(color: Colors.white),
                  )),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: outlineInputBorder,
                  filled: true,
                  fillColor: Colors.blue,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomElevatedButton(
                text: 'Login',
                onPressed: () {
                  userName = userNameController.text;
                  _initialize();
                }),
          )
        ],
      ),
    );
  }
}
