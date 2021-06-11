import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String stringResponse;
  List listResponse;
  Map mapResponse;
  List listOfMap;

  Future fetchData() async {
    http.Response response;

    //response = await http.get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=1'));
    //response = await http.get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=4'));
    response = await http
        .get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=2'));

    if (response.statusCode == 200) {
      setState(() {
        //stringResponse = response.body;
        //listResponse = jsonDecode(response.body);
        mapResponse = jsonDecode(response.body);
        listOfMap = mapResponse['facts'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data'),
          backgroundColor: Colors.blue[900],
        ),
        body: mapResponse == null
            ? Container()
            : SingleChildScrollView(
              child: Column(
                  children: [
                    Text(
                      mapResponse['category'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listOfMap == null ? 0 : listOfMap.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(listOfMap[index]['image_url']),
                                Text(
                                  listOfMap[index]['title'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  listOfMap[index]['description'],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
            ),
      ),
    );
  }
}
