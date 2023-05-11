import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasealldata/authratication/authratication_controller.dart';
import 'package:firebasealldata/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);
  AuthraticationController authraticationController =
      Get.put(AuthraticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            "Email",
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: authraticationController.loginEmail,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            "Password",
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: authraticationController.loginPassword,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(height: 6.h),

          Text(
            "Enter Mobile Number",
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: authraticationController.loginNumber,
            decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
          Text(
            "Otp",
            style: TextStyle(fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          TextFormField(
            controller: authraticationController.otp,
            decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),

          ElevatedButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: authraticationController.loginEmail.text,
                          password: authraticationController.loginPassword.text);
                  authraticationController.loginEmail.clear();
                  authraticationController.loginPassword.clear();
                  Get.toNamed(Routes.homepage);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: const Text("LogIn")),
          SizedBox(height: 6.h),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.signup);
              },
              child: const Text("SignUp")),


          ElevatedButton(onPressed: () async {

            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91${authraticationController.loginNumber.text} ',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {

                  authraticationController.vd=verificationId;
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );

          }, child: const Text("Send Otp")),

          ElevatedButton(onPressed: () async {
            FirebaseAuth auth = FirebaseAuth.instance;
            String smsCode = authraticationController.otp.text;
            // Create a PhoneAuthCredential with the code
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: authraticationController.vd, smsCode: smsCode);

            // Sign the user in (or link) with the credential
            await auth.signInWithCredential(credential);
            Get.toNamed(Routes.homepage);

          }, child: const Text("Submited Otp"))

        ]),

      ),
    );
  }
}
