import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mojadiapp/screens/profile/update_profile.dart';

const String tProfileImage = "assets/male.png";

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  DocumentSnapshot? userProfile;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  void loadUserProfile() async {
    try {
      DocumentSnapshot doc = await getUserProfile();
      setState(() {
        userProfile = doc;
      });
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  Future<DocumentSnapshot> getUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
    } else {
      throw Exception('User not logged in');
    }
  }

  void navigateToUpdateProfile() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileScreen(userProfile: userProfile!),
      ),
    );
    if (result != null) {
      loadUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('User profile not found'));
        }

        var userProfile = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  height: 1.5,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tProfileImage)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            labelText: 'Full Name',
                            prefixIcon: const Icon(LineAwesomeIcons.user),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                              text: userProfile['fullName'] ?? ''),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            labelText: 'Email',
                            prefixIcon: const Icon(LineAwesomeIcons.envelope),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                              text: userProfile['email'] ?? ''),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            labelText: 'Birth Date',
                            hintText: 'DD/MM/YYYY',
                            prefixIcon: const Icon(Icons.calendar_today),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                              text: userProfile['birthDate'] ?? ''),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            labelText: 'Address',
                            prefixIcon: Icon(LineAwesomeIcons.city_solid),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                              text: userProfile['address'] ?? ''),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: navigateToUpdateProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text("Edit Profile",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 200,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text(
                                "Keluar",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
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
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: onItemTapped,
          ),
        );
      },
    );
  }
}
