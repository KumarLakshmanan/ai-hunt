// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';

import '../api_services/apiservices.dart';

class AiNewsPage extends StatefulWidget {
  const AiNewsPage({super.key});

  @override
  State<AiNewsPage> createState() => _AiNewsPageState();
}

class _AiNewsPageState extends State<AiNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Apiservice().ainewsData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: snapshot.hasData
                        ?
                        // ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: snapshot.data.length,
                        //     itemBuilder: (BuildContext context, int index) =>
                        Container(
                            height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black45)),
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${snapshot.data[0]["thumbnail"]}"))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "${snapshot.data[0]["metadata"]["title"]}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                        "${snapshot.data[0]["metadata"]["description"]}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87)),
                                  ),
                                  Row(children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${snapshot.data[0]["icon"]}"),
                                        minRadius: 15,
                                        backgroundColor: Colors.black12,
                                      ),
                                    ),
                                    Text(
                                      "Wired.${(snapshot.data[0]["datetime"])}",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ])
                                ]))
                        : const Center(child: CircularProgressIndicator()),
                  ),
                )));
  }
}
