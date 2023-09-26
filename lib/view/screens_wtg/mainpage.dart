import 'dart:io';
import 'package:fitfolio/view/sub_screens_wtd/other_sub/darwerprofile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitfolio/view/screens_wtg/home_ex.dart';
import '../../controller/mainpagecontrolller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = Provider.of<ProfileImageProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(225, 27, 57, 61),
        title: const Text('Exercises'),
        actions: [
          Consumer<ProfileImageProvider>(
            builder: (context, provider, child) {
              if (provider.profileImagePath != null) {
                return Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(provider.profileImagePath!)),
                  ),
                );
              } else {
                return const SizedBox(); // Replace this with a default widget if needed
              }
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body:  HomeEx(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        // body: ReadDataPage(),
       body: Profile(onProfileImageChanged: (String? imagePath) {
  // Handle the profile image change here
}),
      ),
    );
  }
}
