import 'package:flutter/material.dart';
import 'package:lab1_211050/models/obleka_model.dart';
import 'package:lab1_211050/widgets/detail_back_button.dart';
import 'package:lab1_211050/widgets/detail_image.dart';
import 'package:lab1_211050/widgets/detail_title.dart';

import '../widgets/detail_data.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Obleka;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top
        ),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            DetailImage(
                image: arguments.img
            ),
            DetailTitle(
                id: arguments.id, name: arguments.name
            ),
            DataDetails(
                id: arguments.id,
                desc: arguments.desc,
                price: arguments.price,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const DetailBackButton(),
    );
  }
}