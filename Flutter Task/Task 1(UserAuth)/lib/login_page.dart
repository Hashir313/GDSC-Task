// ignore_for_file: non_constant_identifier_names

import 'package:authentication_task/flutter_toast.dart';
import 'package:authentication_task/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color custom_purple = const Color(0xff2F3164);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ToastMessage toastMessage = ToastMessage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Future login() async {
    try {
     await  _auth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        ToastMessage().flutterToast('Signed in Successfully');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }).onError((error, stackTrace) {
        ToastMessage().flutterToast(error.toString());
      });
    } catch (e) {
      ToastMessage().flutterToast(e.toString());
    }
  }

  // Text Editing Controller for email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //password visibility
  bool showPassword = true;

  //checkbox value
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Welcome Back!',
              style: GoogleFonts.figtree(
                fontSize: 22.0,
                color: custom_purple,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.9,
                    child: Material(
                      shadowColor: custom_purple,
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(15.0),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          prefixIconColor: custom_purple,
                          hintText: 'Email',
                          hintStyle: GoogleFonts.figtree(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: size.width * 0.9,
                    child: Material(
                      shadowColor: custom_purple,
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(15.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: showPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          prefixIconColor: custom_purple,
                          suffixIcon: showPassword
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.visibility_off,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.visibility,
                                  ),
                                ),
                          suffixIconColor: custom_purple,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.figtree(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15.0,
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(
                            () {
                              isChecked = value ?? false;
                            },
                          );
                        },
                      ),
                      Text(
                        'Remember Password',
                        style: GoogleFonts.figtree(
                          color: custom_purple,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.figtree(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                   login();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    custom_purple,
                  ),
                  elevation: const MaterialStatePropertyAll(
                    8.0,
                  ),
                  shadowColor: MaterialStatePropertyAll(
                    custom_purple,
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.figtree(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2.0,
                  width: 60.0,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Or sign in with',
                  style: GoogleFonts.figtree(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 2.0,
                  width: 60.0,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      elevation: MaterialStatePropertyAll(
                        5.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google_logo.png',
                          height: 30.0,
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Google',
                          style: GoogleFonts.figtree(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  width: size.width * 0.45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        custom_purple,
                      ),
                      elevation: const MaterialStatePropertyAll(
                        5.0,
                      ),
                      shadowColor: MaterialStatePropertyAll(
                        custom_purple,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/fb_logo.png',
                          height: 20.0,
                          width: 20.0,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Facebook',
                          style: GoogleFonts.figtree(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 65.0,
            ),
          ],
        ),
      ),
    );
  }
}
