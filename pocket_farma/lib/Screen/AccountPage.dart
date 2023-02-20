// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:pocket_farma/navigation/navBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  // final userDoc = FirebaseAuth.instance.currentUser.toString();
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
        endDrawer: const navBar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: GestureDetector(
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Center(
                    child: SizedBox(
                      height: 20,
                      child: Text(
                        user!.isEmpty == false ? user!['Name'] : "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 3),
                  child: Text(
                    "Personal Information:",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(
                  thickness: 2.5,
                  indent: 5,
                  endIndent: 80,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Name         :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        user!.isEmpty == false ? user!['Name'] : "",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Profession :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        user!.isEmpty == false ? user!['Profession'] : "",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Age             :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        user!.isEmpty == false ? user!['Age'] : "",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Gender       :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        user!.isEmpty == false ? user!['Gender'] : "",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 8, bottom: 3),
                  child: Text(
                    "Account Information:",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(
                  thickness: 2.5,
                  indent: 5,
                  endIndent: 80,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Email          :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        user!.isEmpty == false ? user!['Email'] : "",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Mobile No  :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        user!.isEmpty == false ? user!['Phone'] : "",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                const Center(
                  child: Text(
                    "Pocket Pharma",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }

  Future getUserData() async {
    final docName = await SharedPreferences.getInstance();
    final String? docnam = docName.getString('docname');
    print(docnam);

    await FirebaseFirestore.instance
        .collection("Accounts")
        .doc(docnam)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.data()!.isNotEmpty) {
        setState(() => {user = querySnapshot.data()});
      }
    });
  }
}
