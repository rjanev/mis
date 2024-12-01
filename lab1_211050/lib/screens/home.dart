import 'package:flutter/material.dart';

import '../models/obleka_model.dart';
import '../widgets/obleka_grid.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Obleka> obleka = [
    Obleka(id: 1, name: "obleka 1", img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4W6ZKaWRk2xMcrq4nX8SFkJZa1L7YVEdJ-w&s', desc: "desc 1", price: 1600),
    Obleka(id: 2, name: "obleka 2", img: 'https://i.etsystatic.com/24134759/r/il/0080af/5008153859/il_570xN.5008153859_o2tp.jpg', desc: "desc 2", price: 1500),
    Obleka(id: 3, name: "obleka 3", img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvooVYY9aewzicn4aXkTc2kPPEAFFgPahaBw&s', desc: "desc 3", price: 1900),
    Obleka(id: 4, name: "obleka 4", img: 'https://bechlo.pk/cdn/shop/files/fhv2rpXjCT.jpg?v=1720641530', desc: "desc 4", price: 2500),
    Obleka(id: 5, name: "obleka 5", img: 'https://pictures-nigeria.jijistatic.net/141854483_NjIwLTgxNi1mYjkzZWRlNDk2.webp', desc: "desc 5", price: 300),
    Obleka(id: 6, name: "obleka 6", img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa0s5HBWaBy2UisHpwd6RxozzNZnj0jHlZCQ&s', desc: "Desc 6", price: 100),];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent[100],
        leading: IconButton(onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white, size: 24,)),
        title: const Text("Obleka App", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white, size: 24))
        ],
      ),
      body: OblekaGrid(obleka: obleka),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Share',
        child: const Icon(Icons.share_rounded),
      ),
    );
  }
}