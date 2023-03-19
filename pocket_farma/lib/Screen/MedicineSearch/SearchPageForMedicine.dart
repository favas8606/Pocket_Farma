// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicineSearch extends StatefulWidget {
  const MedicineSearch({Key? key}) : super(key: key);

  @override
  State<MedicineSearch> createState() => _MedicineSearchState();
}

Map<String, dynamic>? dataOfMedicine = {
  "Name": '',
  "Therapeutic group": '',
  "Drug category": '',
  "Indication & Dosage": '',
  "Content": '',
  "Interactions ": '',
  "Precautions ": '',
  "Pregnancy  ": '',
  "Side effect": '',
};

class _MedicineSearchState extends State<MedicineSearch> {
  List<String> suggestions = [];

  someFunction() async {
    final collection = FirebaseFirestore.instance.collection("MEDICINE");
    await collection.get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var a = querySnapshot.docs;
        for (var element in a) {
          suggestions.add(element.data()['Name']);
        }
        setState(() {
          suggestions;
        });
      }
    });
  }

  @override
  void initState() {
    someFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Text("Search"),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: MySearchDelegate(suggestions));
            },
            icon: const Icon(Icons.search))
      ],
    ));
  }
}

class MySearchDelegate extends SearchDelegate {
  final List<String> suggestions;
  MySearchDelegate(this.suggestions);

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
              // close(context, null);
            }
          },
        )
      ];
  @override
  Widget buildResults(BuildContext context) {
    if (query == '') {
      dataOfMedicine = null;
    }
    //  else {
    //   // gotoMedicine();
    // }

    // its shows on pages
    return query != ''
        ? dataOfMedicine != null
            ? Scaffold(
                body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ))),
                        child: Text(
                          dataOfMedicine!['Name'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 3,
                    ),
                    dataOfMedicine!['Name'] != ''
                        ? ListTile(
                            title: const Text('Name'),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: <
                                    Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                            title: const Text('Name'),
                                            content:
                                                Text(dataOfMedicine!['Name']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Text Color
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ]);
                                      });
                                },
                              ),
                            ]),
                          )
                        : Container(),
                    dataOfMedicine!['Therapeutic group'] != ''
                        ? ListTile(
                            title: const Text('Therapeutic group'),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: <
                                    Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                            title:
                                                const Text('Therapeutic group'),
                                            content: Text(dataOfMedicine![
                                                'Therapeutic group']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Text Color
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ]);
                                      });
                                },
                              ),
                            ]),
                          )
                        : Container(),
                    dataOfMedicine!['Drug category'] != ''
                        ? ListTile(
                            title: const Text('Drug category'),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: <
                                    Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                            title: const Text('Drug category'),
                                            content: Text(dataOfMedicine![
                                                'Drug category']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Text Color
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ]);
                                      });
                                },
                              ),
                            ]),
                          )
                        : Container(),
                    dataOfMedicine!['Indication & Dosage'] != ''
                        ? ListTile(
                            title: const Text('Indication & Dosage'),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 30.0,
                                      color: Colors.brown[900],
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                                title: const Text(
                                                    'Indication & Dosage'),
                                                content: Text(dataOfMedicine![
                                                    'Indication & Dosage']),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .red, // Text Color
                                                      ),
                                                      child: const Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ]);
                                          });
                                    },
                                  ),
                                ]),
                          )
                        : Container(),
                    dataOfMedicine!['Content'] != ''
                        ? ListTile(
                            title: const Text('Content'),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 30.0,
                                      color: Colors.brown[900],
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                                title: const Text('Content'),
                                                content: Text(
                                                    dataOfMedicine!['Content']),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .red, // Text Color
                                                      ),
                                                      child: const Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ]);
                                          });
                                    },
                                  ),
                                ]),
                          )
                        : Container(),
                    dataOfMedicine!['Interactions'] != ''
                        ? ListTile(
                            title: const Text('Interactions'),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: <
                                    Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                            title: const Text('Interactions'),
                                            content: Text(dataOfMedicine![
                                                'Interactions']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Text Color
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ]);
                                      });
                                },
                              ),
                            ]),
                          )
                        : Container(),
                    dataOfMedicine!['Precautions'] != ''
                        ? ListTile(
                            title: const Text('Precautions'),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: <
                                    Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                            title: const Text('Precautions'),
                                            content: Text(
                                                dataOfMedicine!['Precautions']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Text Color
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ]);
                                      });
                                },
                              ),
                            ]),
                          )
                        : Container(),
                    dataOfMedicine!['Pregnancy'] != ''
                        ? ListTile(
                            title: const Text('Pregnancy'),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: <
                                    Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                            title: const Text('Pregnancy'),
                                            content: Text(
                                                dataOfMedicine!['Pregnancy']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Text Color
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ]);
                                      });
                                },
                              ),
                            ]),
                          )
                        : Container(),
                    dataOfMedicine!['Side effect'] != ''
                        ? ListTile(
                            title: const Text('Side effect'),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: <
                                    Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                            title: const Text('Side effect'),
                                            content: Text(
                                                dataOfMedicine!['Side effect']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // Text Color
                                                  ),
                                                  child: const Text(
                                                    "Done",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ]);
                                      });
                                },
                              ),
                            ]),
                          )
                        : Container()
                  ],
                ),
              ))
            : ListView()
        : ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      List<String> searchResult = suggestions.where((suggestion) {
        final result = suggestion.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      }).toList();

      return ListView.builder(
          itemCount: searchResult.length,
          itemBuilder: ((context, index) {
            final suggestion = searchResult[index];
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(suggestion),
                    onTap: () async {
                      query = suggestion;
                      dynamic str = await getMedicineData();

                      showResults(context);
                      setState(() {
                        dataOfMedicine = str;
                        print(dataOfMedicine!["Name"]);
                      });
                    },
                  ),
                ],
              ),
            );
          }));
    });
  }

  getMedicineData() async {
    Map<String, dynamic>? data;
    await FirebaseFirestore.instance
        .collection('MEDICINE')
        .doc(query)
        .get()
        .then((querySnapShort) async {
      if (querySnapShort.data()!.isNotEmpty) {
        data = querySnapShort.data();
      }
    });
    return data;
  }
}
