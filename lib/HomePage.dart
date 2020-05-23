import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, @required this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://api.github.com/users";

  bool isLoading = false;
  List data;

  @override
  void initState() {
    super.initState();
    debugPrint("Debugging : Init state invoked");
    getJsonData();
  }

  Future<http.Response> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
      debugPrint("Data : $data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: this.data.length,
        itemBuilder: (BuildContext contxt,int index){
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Image(image: NetworkImage(data[index]['avatar_url'])),
                  title: Text(
                    "${data[index]['login']}",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  subtitle: Text(
                    "${data[index]['url']}",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
