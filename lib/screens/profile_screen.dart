import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/screens/login_page.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 430,
        height: 875,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.black87),
        child: Stack(
          children: [
            Positioned(
              left: 43,
              top: 114,
              child: Container(
                width: 344,
                height: 348,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    // Replace with your local asset image
                    image: AssetImage('assets/profile.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 87,
              top: 481,
              child: SizedBox(
                width: 300,
                height: 49,
                child: Text(
                  'Arka Narendra',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'Vidaloka',
                    fontWeight: FontWeight.w400,
                    // Remove or change height to a normal value like 1.2
                  ),
                ),
              ),
            ),
            // Username Text
            Positioned(
              left: 159,
              top: 532,
              child: Text(
                '@narentoo',
                style: TextStyle(
                  color: Color(0xFF908F9D),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.07,
                ),
              ),
            ),

            // Profile Title Text
            Positioned(
              left: 185,
              top: 60,
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
            // Logout Button Text
            Positioned(
              left: 138,
              top: 592,
              child: GestureDetector(
                onTap: () {
                  Get.offAll(LoginScreen()); 
                },
                child: Container(
                  width: 154,
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
            ),
          ],
        ),
      ),
    );
  }
}
