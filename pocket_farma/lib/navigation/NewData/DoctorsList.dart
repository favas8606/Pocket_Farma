// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocket_farma/navigation/NewData/NewMedicineDataTransfer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOfDoctors extends StatefulWidget {
  const ListOfDoctors({Key? key}) : super(key: key);

  @override
  State<ListOfDoctors> createState() => _ListOfDoctorsState();
}

class _ListOfDoctorsState extends State<ListOfDoctors> {
  @override
  void initState() {
    fetchDoctorsName();
    super.initState();
  }

  List<String> doctorsList = [];
  var name;
  Map<String, dynamic>? user = {
    "Name": "",
    "Profession": "",
    "Age": "",
    "Email": "",
    "Phone": "",
    "Gender": "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Docotrs list'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: MySearchDelegate(doctorsList));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: ListView.separated(
          itemBuilder: ((context, index) {
            return ListTile(
                title: Text(doctorsList[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        name = doctorsList[index];
                        print(name);
                        getEmail();
                      },
                    )
                  ],
                ));
          }),
          separatorBuilder: ((context, index) {
            return const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15),
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            );
          }),
          itemCount: doctorsList.length,
        ));
  }

  void fetchDoctorsName() async {
    final doctors = FirebaseFirestore.instance.collection('Doctors');
    await doctors.get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var doctor = querySnapshot.docs;

        doctor.forEach((element) {
          doctorsList.add(element.data()['Name']);
          // print(doctorsList);
        });
        setState(() {
          doctorsList;
        });
      }
    });
  }

  void getEmail() async {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(name)
        .get()
        .then((querySnapshort) async {
      if (querySnapshort.data()!.isNotEmpty) {
        user = querySnapshort.data();
        SharedPreferences DoctorEmail = await SharedPreferences.getInstance();
        await DoctorEmail.setString("Dremail", user!['Email']);
        print(user!['Email']);
      }
    });

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const MedicineDataTransfer()));
  }
}

class MySearchDelegate extends SearchDelegate {
  final List<String> doctorsList;
  MySearchDelegate(this.doctorsList);
  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
    return null;
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        )
      ];
  @override
  Widget buildResults(BuildContext context) {
    // its shows on pages
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchResult = doctorsList.where((suggestion) {
      final result = suggestion.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: ((context, index) {
        final suggestion = searchResult[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            setemail();

            query = suggestion;
            showResults(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MedicineDataTransfer()));
          },
        );
      }),
    );
  }

  void setemail() async {
    SharedPreferences DoctorName = await SharedPreferences.getInstance();
    await DoctorName.setString("name", query);
  }
}
