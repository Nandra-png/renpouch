import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/screens/bottom_nav_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF121013)),
        child: Stack(
          children: [
            // teks "Create A Better Future For Yourself"
            Positioned(
              left: 43,
              top: 97,
              child: Image.asset(
                'assets/maintext.png',
                width: 314,
              ),
            ),
            Positioned(
              left: 46,
              top: 75,
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
              left: 33,
              top: 306,
              child: Container(
                width: 363.82,
                height: 369,
                child: Stack(
                  children: [
                    Positioned(
                      left: 29.56,
                      top: 64.44,
                      child: Container(
                        width: 234.45,
                        height: 251.11,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFF6D6F),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 168.04,
                      top: 108,
                      child: Transform(
                        transform: Matrix4.identity()..rotateZ(0.01),
                        child: Container(
                          width: 195.78,
                          height: 207.72,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFF6D6F),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 362,
                        height: 369,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/moneypage.png'), // Gambar utama lokal
                            fit: BoxFit.fill,
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
              left: 47,
              top: 768,
              child: GestureDetector(
                onTap: () {
                  Get.offAll(BottomNav());
                },
                child: Container(
                  width: 314,
                  height: 73,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFEFEFE), // Warna tombol
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
                        fontWeight: FontWeight.w700,
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
