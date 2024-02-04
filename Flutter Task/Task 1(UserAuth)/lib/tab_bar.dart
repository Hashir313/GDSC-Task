// ignore_for_file: non_constant_identifier_names

import 'package:authentication_task/login_page.dart';
import 'package:authentication_task/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color custom_purple = const Color(0xff2F3164);

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: this, // Use `this` as the vsync
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  color: custom_purple.withOpacity(0.97),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: SizedBox(
                  height: size.height * 0.3,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ClipPath(
                              clipper: ParallelogramClipper(),
                              child: Container(
                                height: size.height * 0.8,
                                decoration: BoxDecoration(
                                  color: custom_purple.withOpacity(0.97),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipPath(
                              clipper: ParallelogramClipper(),
                              child: Container(
                                height: size.height,
                                decoration: BoxDecoration(
                                  color: custom_purple.withOpacity(0.97),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TabBar(
                            indicator: const UnderlineTabIndicator(
                              insets: EdgeInsets.symmetric(
                                horizontal: 60.0,
                              ),
                            ),
                            indicatorColor: Colors.white,
                            dividerColor: Colors.transparent,
                            labelColor: Colors.white,
                            labelStyle: GoogleFonts.figtree(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            labelPadding: const EdgeInsets.only(bottom: 5.0),
                            unselectedLabelColor: Colors.white,
                            controller: _controller,
                            tabs: const [
                              Text('Login'),
                              Text('Signup'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: const [
                    LoginPage(),
                    SignupPage(),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  color: custom_purple.withOpacity(0.97),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: SizedBox(
                  height: size.height * 0.3,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ClipPath(
                              clipper: ParallelogramClipper(),
                              child: Container(
                                height: size.height * 0.8,
                                decoration: BoxDecoration(
                                  color: custom_purple.withOpacity(0.97),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ClipPath(
                              clipper: ParallelogramClipper(),
                              child: Container(
                                height: size.height,
                                decoration: BoxDecoration(
                                  color: custom_purple.withOpacity(0.97),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(80, 0.0)
      ..lineTo(180, size.height)
      ..lineTo(120, size.height)
      ..lineTo(20, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
