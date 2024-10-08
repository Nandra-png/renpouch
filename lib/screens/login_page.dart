import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/screens/bottom_nav_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF121013)),
        child: Stack(
          children: [
            // teks "Create A Better Future For Yourself"
            Positioned(
              left: width * 0.1,
              top: height * 0.1,
              child: Image.asset(
                'assets/maintext.png',
                width: width * 0.8,
              ),
            ),
            Positioned(
              left: width * 0.1,
              top: height * 0.08,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ren',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Pouch',
                      style: TextStyle(
                        color: Color(0xFFF2D752),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bagian gambar utama dan oval
            Positioned(
              left: width * 0.05,
              top: height * 0.3,
              child: Container(
                width: width * 0.9,
                height: width * 0.9 * 1.25,
                child: Stack(
                  children: [
                    Positioned(
                      left: width * 0.1,
                      top: height * 0.1,
                      child: Container(
                        width: width * 0.55,
                        height: width * 0.9 * 0.60,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF38878),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * 0.345,
                      top: height * 0.15,
                      child: Transform(
                        transform: Matrix4.identity()..rotateZ(0.01),
                        child: Container(
                          width: width * 0.55,
                          height: width * 0.9 * 0.60,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF38878),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: width * 0.9,
                        height: width * 1 * 1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/moneypage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tombol "Start Now"
            Positioned(
              left: width * 0.1,
              top: height * 0.83,
              child: GestureDetector(
                onTap: () {
                  Get.offAll(BottomNav());
                },
                child: Container(
                  width: width * 0.8,
                  height: height * 0.08,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFEFEFE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Start Now',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
