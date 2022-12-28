import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/Screen/AccountPage.dart';
import 'package:pocket_farma/navBar.dart';

class report_Problem extends StatefulWidget {
  const report_Problem({Key? key}) : super(key: key);

  @override
  State<report_Problem> createState() => _report_ProblemState();
}

class _report_ProblemState extends State<report_Problem> {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => const navBar())));
            }),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Report Problem',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
            width: 400,
            child: Text(
              "Briefly explain what happened or what's not working?",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
            child: TextField(
              controller: textController,
              textInputAction: TextInputAction.newline,
              autofocus: true,
              autocorrect: true,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter the problems you have...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding:
                const EdgeInsets.only(top: 10, left: 240, right: 20, bottom: 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan[100], // Background color
              ),
              child: const Icon(
                Icons.send,
                size: 25,
              ),
              onPressed: () {
                //where to send the report
                textController.clear();
              },
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          SizedBox(
            height: 20,
            child: Center(
              child: Text(
                'Pocket Pharma',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey[200],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
