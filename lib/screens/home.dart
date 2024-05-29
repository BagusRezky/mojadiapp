import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 300.w,
                height: 200.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(top: 40.h),
                child: Column(
                  children: [
                    Text(
                      'Yuk, laporkan temuaan pelanggaran & kerusakan fasilitas sosial di Lingkungan Sekitarmu!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/report/create');
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        width: 150.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                        child: const Center(
                          child: Text(
                            'Laporkan Sekarang',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              20.verticalSpace,
              Container(
                padding: EdgeInsets.all(25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/report');
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.w),
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Center(
                              child: Icon(Icons.add_alert),
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          'Laporan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.w),
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Icon(Icons.stacked_bar_chart_sharp),
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          'Statistik',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.w),
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Icon(Icons.article),
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          'Artikel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.w),
                            border: Border.all(color: Colors.black),
                          ),
                          child: const Center(
                            child: Icon(Icons.info_outline_rounded),
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          'Informasi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
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
  }
}
