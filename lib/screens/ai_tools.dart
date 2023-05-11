import 'package:flutter/material.dart';

class AiToolsPage extends StatefulWidget {
  const AiToolsPage({super.key});

  @override
  State<AiToolsPage> createState() => _AiToolsPageState();
}

class _AiToolsPageState extends State<AiToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                snapshot.hasData
                    ?
                    // ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: snapshot.data.length,
                    //     itemBuilder: (BuildContext context, int 0) =>
                    Container(
                        height: 550,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "${snapshot.data[0]["thumbnail_exists"]}"))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))),
                                      backgroundColor: const Color.fromARGB(
                                          255, 118, 163, 199)),
                                  child: Text(
                                    "${snapshot.data[0]["pricing"]["price"]}",
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(children: [
                                Text(
                                  snapshot.data[0]["title"],
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const Icon(Icons.tiktok, color: Colors.white60),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.bookmark_border_rounded,
                                        color: Colors.white60)),
                                const Text(
                                  "26",
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 20),
                                )
                              ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 15),
                              child: ListView.builder(
                                itemCount: snapshot.data[0]["favourite_count"],
                                itemBuilder: (BuildContext context, int index) {
                                  const Icon(Icons.star,
                                      color: Colors.orangeAccent);
                                },
                              ),
                            ),
                            Row(children: [
                              //

                              SizedBox(
                                width: 10,
                              ),
                              Text("${snapshot.data[0]["favourite_count"]}",
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 20))
                            ]),
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                  "${snapshot.data[0]["gpt33"]["heading"]}",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 20)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                top: 20,
                              ),
                              child: Row(
                                children: [
                                  TextButton.icon(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(171, 59, 57, 59),
                                        iconColor: Colors.white12,
                                      ),
                                      icon: const Icon(Icons.lock),
                                      label: Text(
                                        "${snapshot.data[0]["pricing"]["type"]}",
                                        style: const TextStyle(
                                          color: Colors.white60,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 130,
                                  ),
                                  const Icon(Icons.star_purple500,
                                      color:
                                          Color.fromARGB(255, 240, 176, 176)),
                                  Text(
                                    "${snapshot.data[0]["priority"]}",
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "#${snapshot.data[0]["category"][0]}",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 20),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(140, 35)),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_outward_sharp,
                                      color: Colors.white,
                                    ),
                                    label: const Text(""),
                                  ),
                                ),
                                OutlinedButton.icon(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(140, 35),
                                      side: const BorderSide(
                                        color: Colors.blue,
                                        width: 0.8,
                                      ),
                                    ),
                                    icon: const Icon(Icons.bookmark),
                                    label: Text(""))
                              ],
                            )
                          ],
                        ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      )),
      ),
    );
  }
}
