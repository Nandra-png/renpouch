import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/screens/login_page.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.black87),
        child: Stack(
          children: [
           
            Positioned(
              left: screenWidth * 0.1,
              top: screenHeight * 0.1,
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.4,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profile.png'),
                    fit: BoxFit.contain,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
            // Profile title
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.05,
              child: Center(
  
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Color(0xFF908F9D),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            //teks profile
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nama
                  Text(
                    'Guest',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Vidaloka',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Narentoo
                  Center(
                    child: Text(
                      '@none',
                      style: TextStyle(
                        color: Color(0xFF908F9D),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Logout Button
                  GestureDetector(
                    onTap: () {
                      Get.offAll(LoginScreen());
                    },
                    child: Container(
                      width: screenWidth * 0.4,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Color(0xFFF38878),
                        borderRadius: BorderRadius.circular(31),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
