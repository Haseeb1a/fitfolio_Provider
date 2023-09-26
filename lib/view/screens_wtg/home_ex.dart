import 'package:fitfolio/helpers/appcolors..dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Removed the extra period from the import path

import '../sub_screens_wtd/exercises/abs.dart';
import '../sub_screens_wtd/exercises/all.dart';
import '../sub_screens_wtd/exercises/back.dart';
import '../sub_screens_wtd/exercises/biceps.dart';
import '../sub_screens_wtd/exercises/calf.dart';
import '../sub_screens_wtd/exercises/chest.dart';
import '../sub_screens_wtd/exercises/forearms.dart';
import '../sub_screens_wtd/exercises/legs.dart';
import '../sub_screens_wtd/exercises/shoulders.dart';
import '../sub_screens_wtd/exercises/triceps.dart';

class HomeEx extends StatelessWidget {
  // Remove "super.key" from the constructor
  //  HomeEx();

  final List<ListModel> listof = [
    ListModel('assets/images/131-1319291_six-pack-abs-gym-muscles-clipart-sticker-cartoon.png', 'ABS',),
    ListModel('assets/images/wings.jpg', 'BACK',),
    ListModel('assets/images/biceps.jpg', 'BICEPS',),
    ListModel('assets/images/calf.jpg', 'CALF',),
    ListModel('assets/images/chest (2).jpg', 'CHEST',),
    ListModel('assets/images/forearms.jpg', 'FOREARMS',),
    ListModel('assets/images/legs.jpg', 'LEGS',),
    ListModel('assets/images/shoulders.jpg', 'SHOULDERS',),
    ListModel('assets/images/triceps.jpg', 'TRICEPS',),
    ListModel('assets/images/all.jpg', 'ALL',),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: colors.darktheme,
              child: CarouselSlider(
                items: [
                  Image.asset('assets/images/carosela.jpg'),
                  Image.asset('assets/images/caroselb.jpg'),
                  Image.asset('assets/images/caroselc.jpg'),
                  Image.asset('assets/images/caroseld.jpg'),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.9,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.separated(
                  itemCount: listof.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    final ListModel itemData = listof[index];
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(itemData.images,),
                            ),
                            title: Text(
                              itemData.name,
                              style: const TextStyle(color: colors.darktheme, fontWeight: FontWeight.w700),
                            ),
                            onTap: () {
                              _handleItemTap(itemData, context); // Pass the context to handleItemTap
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleItemTap(ListModel itemData, BuildContext context) {
    switch (itemData.name) {
      case 'ABS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Abs()),
        );
        break;
      case 'BACK':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Back()),
        );
        break;
      case 'BICEPS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Biceps()),
        );
        break;
      case 'CALF':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Calf()),
        );
        break;
      case 'CHEST':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Chest()),
        );
        break;
      case 'FOREARMS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Forearms()),
        );
        break;
      case 'LEGS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Legs()),
        );
        break;
      case 'SHOULDERS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Shoulder()),
        );
        break;
      case 'TRICEPS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Triceps()),
        );
        break;
      case 'ALL':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const All()),
        );
        break;
      default:
        break;
    }
  }
}

class ListModel {
  final dynamic images;
  final String name;

  ListModel(this.images, this.name,);
}
