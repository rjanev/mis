import 'package:flutter/material.dart';

import '../models/obleka_model.dart';
import 'obleka_card.dart';

class OblekaGrid extends StatefulWidget {
  final List<Obleka> obleka;
  const OblekaGrid({super.key, required this.obleka});
  @override
  _OblekaGridState createState() => _OblekaGridState();
}
class _OblekaGridState extends State<OblekaGrid> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GridView.count(
      padding: const EdgeInsets.all(6),
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      semanticChildCount: 250,
      childAspectRatio: 200 / 244,
      physics: const BouncingScrollPhysics(),
      children: widget.obleka.map((obleka) =>
          OblekaCard(id: obleka.id, name: obleka.name, image: obleka.img, desc: obleka.desc, price: obleka.price),

      ).toList(),
    );
  }
}