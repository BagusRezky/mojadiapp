import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

const String tProfileImage = "assets/male.png";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.getUserProfile();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProfile = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
      backgroundColor: Colors.white,
      body: userProfile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                          _buildProfileField(
                            icon: LineAwesomeIcons.user,
                            label: 'Full Name',
                            value: userProfile.displayName,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileField(
                            icon: LineAwesomeIcons.envelope,
                            label: 'Email',
                            value: userProfile.email,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileField(
                            icon: Icons.calendar_today,
                            label: 'Birth Date',
                            value: userProfile.birthDate,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileField(
                            icon: LineAwesomeIcons.city_solid,
                            label: 'Address',
                            value: userProfile.address,
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/updateProfile',
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF103374),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Edit Profile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          8.verticalSpace,
                          const Divider(),
                          8.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                authProvider.signOut(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF3B30),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Keluar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
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
          selectedItemColor: const Color(0xFF103374),
          unselectedItemColor: Colors.grey[700],
          onTap: onItemTapped,
        ),
      ),
    );
  }

  Widget _buildProfileField(
      {required IconData icon, required String label, required String value}) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        labelText: label,
        prefixIcon: Icon(icon),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(width: 2, color: Colors.black),
        ),
      ),
      readOnly: true,
      initialValue: value.isNotEmpty ? value : 'Not provided',
    );
  }
}
