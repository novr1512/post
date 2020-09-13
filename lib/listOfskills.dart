import 'package:flutter/material.dart';

class listOfSkills extends StatefulWidget {
  List<String> skills;

  listOfSkills({this.skills});

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<listOfSkills> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.skills.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          title: Text(widget.skills[index]),
          trailing: Icon(Icons.cancel),
          //onDeleted: () {
          // setState(() {
          //  widget.skills.removeWhere((String entry) {
          //return entry == widget.skills[index];
          //  });
          //  });
          //  },
          // elevation: 10,
        ));
      },
    );
  }
}
