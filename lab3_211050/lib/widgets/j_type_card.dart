import 'package:flutter/material.dart';
import '../../services/api_services.dart';
import 'j_type_cardData.dart';

class JokeTypeCard extends StatelessWidget {
  final String type;

  const JokeTypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: Colors.grey.shade300,
      onTap: () {
        ApiService.getJokesByType(type).then((jokes) {
          Navigator.pushNamed(context, "/jokes", arguments: jokes);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: JokeTypeCardData(type: type),
      ),
    );
  }
}
