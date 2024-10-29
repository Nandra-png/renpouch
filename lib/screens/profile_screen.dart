import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repouch/controllers/profile_controller.dart';
import 'login_page.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
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
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onLongPress: () => _showRenameDialog(context),
                    child: Obx(() => Text(
                          profileController
                              .userName.value, // Menampilkan nama terbaru
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Vidaloka',
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ),
                  SizedBox(height: 30),
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

  void _showRenameDialog(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 29, 37, 41),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Rename",
            style: TextStyle(
              color: Colors.white, // Warna teks title
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Container(
            width: double.maxFinite, // Set the width to the max possible
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Enter new name",
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.black45,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newName = _nameController.text.trim();
                if (newName.isNotEmpty) {
                  profileController.updateUserName(newName);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                "Rename",
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: const Color.fromARGB(255, 243, 33, 33),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
