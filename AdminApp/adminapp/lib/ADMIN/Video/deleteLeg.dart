import 'package:adminapp/calling/api.dart';
import 'package:adminapp/calling/firebase_file.dart';
import 'package:flutter/material.dart';

class DeleteTrainingLeg extends StatefulWidget {
  @override
  _DeleteTrainingLeg createState() => _DeleteTrainingLeg();
}

class _DeleteTrainingLeg extends State<DeleteTrainingLeg> {
  Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('videoLeg/');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00467F),
          title: Text('Leg Training'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.account_box_rounded, color: Colors.white),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Profile()),
          //       );
          //     },
          //   ),
          // ],
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(files.length),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];

                            return ListTile(
                              title: Text(
                                file.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                              ),
                              onTap: () async {
                                final res = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => _AlertDialog(),
                                );

                                if (res) {
                                  await file.ref.delete();
                                  files.removeAt(index);
                                  setState(() {});
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you relly wanted to delete this file?"),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text("Yes"),
          onPressed: () async {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
