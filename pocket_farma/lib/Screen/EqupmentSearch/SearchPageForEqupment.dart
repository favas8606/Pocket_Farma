// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchEqupment extends StatefulWidget {
  const SearchEqupment({Key? key}) : super(key: key);

  @override
  State<SearchEqupment> createState() => _SearchEqupmentState();
}

Map<String, dynamic>? dataOfEquipment = {
  'Name': '',
  'Usage': '',
  'Parts': '',
  'Accessories': '',
  'Care': '',
  'Preparation': '',
};

class _SearchEqupmentState extends State<SearchEqupment> {
  List<String> suggestions = [];

  someFunction() async {
    final collection = FirebaseFirestore.instance.collection("EQUIPMENT");
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
      dataOfEquipment = null;
    }
    // } else {
    //   // getData();
    // }
    // its shows on pages
    return query != ''
        ? dataOfEquipment != null
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
                          dataOfEquipment!['Name'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 3,
                    ),
                    dataOfEquipment!['Name'] != ''
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
                                                Text(dataOfEquipment!['Name']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        Colors.purpleAccent,
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
                    dataOfEquipment!['Usage'] != ''
                        ? ListTile(
                            title: const Text('Usage'),
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
                                            title: const Text('Usage'),
                                            content:
                                                Text(dataOfEquipment!['Usage']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        Colors.purpleAccent,
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
                    dataOfEquipment!['Parts'] != ''
                        ? ListTile(
                            title: const Text('Parts'),
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
                                            title: const Text('Parts'),
                                            content:
                                                Text(dataOfEquipment!['Parts']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        Colors.purpleAccent,
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
                    dataOfEquipment!['Accessories'] != ''
                        ? ListTile(
                            title: const Text('Accessories'),
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
                                            title: const Text('Accessories'),
                                            content: Text(dataOfEquipment![
                                                'Accessories']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        Colors.purpleAccent,
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
                    dataOfEquipment!['Care'] != ''
                        ? ListTile(
                            title: const Text('Care'),
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
                                            title: const Text('Care'),
                                            content:
                                                Text(dataOfEquipment!['Care']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        Colors.purpleAccent,
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
                    dataOfEquipment!['Preparation'] != ''
                        ? ListTile(
                            title: const Text('Preparation'),
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
                                            title: const Text('Preparation'),
                                            content: Text(dataOfEquipment![
                                                'Preparation']),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary:
                                                        Colors.purpleAccent,
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
                      dynamic str = await getDataEquipment();

                      showResults(context);
                      setState(() {
                        dataOfEquipment = str;
                        print(dataOfEquipment!["Name"]);
                      });
                    },
                  ),
                ],
              ),
            );
          }));
    });
  }

  // void getData() async {
  //   await FirebaseFirestore.instance
  //       .collection('EQUIPMENT')
  //       .doc(query)
  //       .get()
  //       .then((snapShort) {
  //     if (snapShort.data()!.isNotEmpty) {
  //       dataOfEquipment = snapShort.data();
  //     }
  //   });
  // }

  getDataEquipment() async {
    Map<String, dynamic>? data;
    await FirebaseFirestore.instance
        .collection('EQUIPMENT')
        .doc(query)
        .get()
        .then((snapShort) async {
      if (snapShort.data()!.isNotEmpty) {
        data = snapShort.data();
      }
    });
    return data;
  }
}
