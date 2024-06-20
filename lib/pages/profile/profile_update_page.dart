import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

const String tProfileImage = "assets/male.png";

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProfile = Provider.of<AuthProvider>(context, listen: false).user;
    if (userProfile != null) {
      displayNameController.text = userProfile.displayName;
      emailController.text = userProfile.email;
      birthDateController.text = userProfile.birthDate;
      addressController.text = userProfile.address;
    }
  }

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        birthDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _saveProfile() {
    String displayName = displayNameController.text;
    String birthDate = birthDateController.text;
    String address = addressController.text;

    Provider.of<AuthProvider>(context, listen: false)
        .updateUserProfile(displayName, birthDate, address)
        .then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to update user profile: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            height: 1.5,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: displayNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: 'Full Name',
                        prefixIcon: const Icon(LineAwesomeIcons.user),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: 'Email',
                        prefixIcon: const Icon(LineAwesomeIcons.envelope),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                      readOnly: true, // Mark as readOnly if not editable
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: birthDateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: 'Birth Date',
                        hintText: 'DD/MM/YYYY',
                        prefixIcon: const Icon(Icons.calendar_today),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                      onTap: _selectDate,
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelText: 'Address',
                        prefixIcon: Icon(LineAwesomeIcons.city_solid),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text("Confirm",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Text(
                            "Cancel",
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
    );
  }
}
