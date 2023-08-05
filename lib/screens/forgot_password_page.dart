import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});


  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final resetPasswordController = TextEditingController();
  @override
  void dispose() {
    resetPasswordController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try{
      FirebaseAuth.instance.sendPasswordResetEmail(email: resetPasswordController.text.trim());
    } on FirebaseAuthException catch(e) {
      print(e);
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
          content: Text('Password reset link send, Check your Email'),
        );
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Enter your email and we will send you a password reset link', style: TextStyle(fontSize: 25),textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                controller: resetPasswordController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          onPressed: passwordReset,
          color: Colors.deepPurple,
          child: const Text('Reset Password'),
        ),
      ]),
    );
  }
}
