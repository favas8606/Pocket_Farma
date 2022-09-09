import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        title: const Text('About us'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 50,
              width: 400,
              child: const Text(
                "Briefly explain what happened or what's not working?",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                ),
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
                hintText: 'Enter the problems',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.only(
                  top: 10, left: 240, right: 50, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Background color
                ),
                child: const Icon(Icons.send),
                onPressed: () {
                  //where to send the report
                  textController.clear();
                },
              )),
        ],
      ),
    );
  }
}
