// ignore_for_file: unnecessary_import, file_names

import 'package:flutter/material.dart';

import 'package:pocket_farma/Screen/EqupmentSearch/SearchPageForEqupment.dart';
import 'package:pocket_farma/Screen/MedicineSearch/SearchPageForMedicine.dart';

class Selection extends StatefulWidget {
  const Selection({Key? key}) : super(key: key);

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        title: const Text("Search"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Center(
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MedicineSearch(),
                        ));
                  },
                  child: const Text("MEDICINE")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchEqupment(),
                        ));
                  },
                  child: const Text("EQUIPMENTS")),
            ],
          ),
        ),
      ),
    );
  }
}
