import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'buttons/postbutton.dart';
import 'listOfskills.dart';

class PostIdeaFormPage extends StatefulWidget {
  PostIdeaFormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//static future<void> show(BuildContext context) async {
//  await Navigator.of(context).push(
//   MaterialPageRoute(builder: (context) => PostIdeaFormPage(),
//    fullscreenDialog: true,
//    )
//);
class _MyHomePageState extends State<PostIdeaFormPage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String title = 't';
    String description = 'd';
    DateTime date = DateTime.now();
    double maxValue = 0;
    String newSkill;
    List<String> skill = ["me"];

    //reference: https://github.com/flutter/samples/tree/master/experimental/form_app
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Scaffold.of(context).openDrawer(); //check
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...[
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Enter a project name...',
                              labelText: 'Project Name',
                            ),
                            onChanged: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Project Name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              hintText: 'Enter a Project description...',
                              labelText: 'Project Description',
                            ),
                            onChanged: (value) {
                              description = value;
                            },
                            maxLines: 5,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter project description';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Enter a skill...',
                              labelText: 'Required skill',
                            ),
                            onChanged: (value) {
                              setState(() {
                                newSkill = value;
                              });
                            },
                          ),
                          FlatButton(onPressed: null, child: Text("Add")),
                          // listOfSkills(skills: skill),

                          _FormDatePicker(
                            date: date,
                            onChanged: (value) {
                              setState(
                                () {
                                  date = value;
                                },
                              );
                            },
                            datetext: "Start date",
                          ),
                          _FormDatePicker(
                              date: date,
                              onChanged: (value) {
                                setState(() {
                                  date = value;
                                });
                              },
                              datetext: "expected deadline"),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Estimated members number',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              Text(
                                intl.NumberFormat.currency(
                                        symbol: "", decimalDigits: 0)
                                    .format(maxValue),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Slider(
                                min: 0,
                                max: 100,
                                divisions: 100,
                                value: maxValue,
                                onChanged: (value) {
                                  setState(() {
                                    maxValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ].expand(
                          (widget) => [
                            widget,
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                        postbutton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged onChanged;
  final String datetext;
  _FormDatePicker({
    this.date,
    this.onChanged,
    this.datetext,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.datetext,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        FlatButton(
          child: Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
