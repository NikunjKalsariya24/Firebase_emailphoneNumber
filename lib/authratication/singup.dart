import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasealldata/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import 'authratication_controller.dart';

class SignUp extends StatelessWidget {
   SignUp({Key? key}) : super(key: key);
  AuthraticationController authraticationController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,children: [


          Text(
            "Email",
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: authraticationController.signUpEmail,
            decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(height: 6.h,),
          Text(
            "Password",
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: authraticationController.signUpPassword,
            decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(height: 6.h,),

          ElevatedButton(onPressed: () async {

            try {
              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: authraticationController.signUpEmail.text,
                password: authraticationController.signUpPassword.text,
              );

              Get.toNamed(Routes.login);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }

          }, child: const Text("Sign Up"))
        ]),
      ),
    );
  }
}
