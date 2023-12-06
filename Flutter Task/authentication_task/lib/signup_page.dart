// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:authentication_task/flutter_toast.dart';
import 'package:authentication_task/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

Color custom_purple = const Color(0xff2F3164);

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isStudent = false;

  bool progressBar = false;

// functions for image
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  Future signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user in Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
        );

        // Store additional information in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'gender': selectedGender,
          'isStudent': isStudent,
        }).then((value) {
          debugPrint('Error found');
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });

        // Display success message
        ToastMessage().flutterToast('Signed up successfully');

        // Navigate to home page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } catch (error) {
        // Display error message
        ToastMessage().flutterToast('Error: $error');
      }
    }
  }

  // Text Editing COntroller for email and password
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  //password visibility
  bool showPassword = true;

  //checkbox value
  bool isChecked = false;

  String selectedGender = '';
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
              'Create An Account',
              style: GoogleFonts.figtree(
                fontSize: 22.0,
                color: custom_purple,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: InkWell(
                onTap: () {
                  _showImagePickerDialog(context);
                },
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
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
                      child: TextField(
                        controller: nameController,
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
                            Icons.person,
                          ),
                          prefixIconColor: custom_purple,
                          hintText: 'Full Name',
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
                      child: TextField(
                        controller: emailController,
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
                      child: TextField(
                        controller: passwordController,
                        obscureText: showPassword,
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
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Gender:',
                        style: GoogleFonts.figtree(
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Male',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value as String;
                              });
                            },
                          ),
                          const Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Female',
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value as String;
                              });
                            },
                          ),
                          const Text('Female'),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Checkbox(
                            value: isStudent,
                            onChanged: (value) {
                              setState(() {
                                isStudent = value!;
                              });
                            }),
                        Text(
                          'Are you a student?',
                          style: GoogleFonts.figtree(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
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
                onPressed: () {
                  signup();
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
                  'Sign Up',
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
                  'Or sign up with',
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
              height: 34.0,
            ),
          ],
        ),
      ),
    );
  }
}
