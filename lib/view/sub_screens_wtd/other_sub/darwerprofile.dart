import 'dart:io';
import 'package:fitfolio/view/sub_screens_wtd/other_sub/profileedit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../controller/profiledrawer.dart';
import '../../../services/db_person.dart';
import '../../../model/person_model/persondata.dart';
import 'package:fitfolio/helpers/appcolors..dart';

class Profile extends StatelessWidget {
  final void Function(String?) onProfileImageChanged;

  const Profile({Key? key, required this.onProfileImageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colors.primarytheme,
        title: const Center(
          child: Text('Profile'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final personDataList =
                  Provider.of<PersonDataProvider>(context, listen: false)
                      .personDataList;

              if (personDataList.isNotEmpty) {
                final profileData = personDataList[0];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profileedit(
                      personname: profileData.personname,
                      personage: profileData.personage,
                      personheight: profileData.personheight,
                      index: 0,
                      personweight: profileData.personweight,
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.edit),
            color: Colors.white,
            iconSize: 25,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () async {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .pickImageAndStore();
                    // Load stored image logic here
                    // You may use Provider to fetch the selectedImage
                  },
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: colors.primarytheme,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: ClipOval(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Consumer<ProfileProvider>(
                            builder: (context, profileProvider, _) {
                              File? selectedImage =
                                  profileProvider.selectedImage;

                              if (selectedImage != null) {
                                return Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey[600],
                                );
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 21,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    SizedBox(
                      child: Container(
                        height: 370,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(3),
                            bottomLeft: Radius.circular(50),
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(3),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          color: colors.secondarytheme,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3.7,
                              blurRadius: 7,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Consumer<PersonDataProvider>(
                                  builder: (context, personDataProvider, _) {
                                    List<persondata> personDataList =
                                        personDataProvider.personDataList;

                                    if (personDataList.isEmpty) {
                                      return Text('No profile data available.');
                                    }

                                    persondata profileData = personDataList[0];

                                    return Text(
                                      '''
Name: ${profileData.personname}
Age: ${profileData.personage}
Weight: ${profileData.personheight}
Height: ${profileData.personweight}
                                      ''',
                                      style: GoogleFonts.acme(
                                        fontSize: 25,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      textAlign: TextAlign.start,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
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
