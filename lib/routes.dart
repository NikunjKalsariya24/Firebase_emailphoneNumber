import 'package:firebasealldata/homepage/homepage.dart';
import 'package:get/get.dart';

import 'authratication/login.dart';
import 'authratication/singup.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;
  static const String login = '/LogIn';
  static const String signup = '/SignUp';
  static const String homepage = '/HomePage';
  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: login,
      page: () => LogIn(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signup,
      page: () => SignUp(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: homepage,
      page: () =>  HomePage(),
      transition: defaultTransition,
    ),




  ];
}