import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/screens/login_page.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth, // Sesuaikan dengan lebar layar
        height: screenHeight, // Sesuaikan dengan tinggi layar
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.black87),
        child: Stack(
          children: [
            // Profile Image
            Positioned(
              left: screenWidth *
                  0.1, // Sesuaikan posisi berdasarkan persentase lebar layar
              top: screenHeight *
                  0.1, // Sesuaikan posisi berdasarkan persentase tinggi layar
              child: Container(
                width: screenWidth *
                    0.8, // Sesuaikan lebar berdasarkan persentase lebar layar
                height: screenHeight *
                    0.4, // Sesuaikan tinggi berdasarkan persentase tinggi layar
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profile.png'),
                    fit: BoxFit.contain, // Mempertahankan rasio gambar
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
                // Membungkus dengan Center untuk memusatkan teks
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
            // Nama Pengguna, Username, dan Logout di bawah gambar
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nama Pengguna
                  Text(
                    'Arka Narendra',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Vidaloka',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10), // Jarak antar teks

                  // Username (@narentoo) di tengah
                  Center(
                    child: Text(
                      '@narentoo',
                      style: TextStyle(
                        color: Color(0xFF908F9D),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 30), // Jarak antara username dan tombol logout

                  // Logout Button
                  GestureDetector(
                    onTap: () {
                      Get.offAll(LoginScreen()); // Pindah ke layar login
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
