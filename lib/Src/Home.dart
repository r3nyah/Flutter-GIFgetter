import 'package:flutter/material.dart';
import 'package:gif_fromapi/Src/GIF.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Homepage extends StatefulWidget {
  final String title;
  const Homepage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();
  List<String> gifUrls = [];

  Future<void> getGIFFromAPI(String word) async {
    var data = await http.get(
      Uri.parse(
        'https://api.tenor.com/v1/search?q=$word&key=LIVDSRZULELA&limit=8',
      ),
    );

    var dataParsed = jsonDecode(data.body);
    gifUrls.clear();
    for(int i=0;i<8;i++){
      gifUrls.add(dataParsed['results'][i]['media'][0]['tinygif']['url']);
    }
    setState((){});
  }

  @override
  void initState() {
    getGIFFromAPI('hololive');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _controller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.deepOrange,
                    ),
                      borderRadius: BorderRadius.circular(20),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueGrey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                ),
              ),
              ),
              ElevatedButton(
                onPressed: (){
                  getGIFFromAPI(_controller.text);
                },
                child: const Text(
                  'GIF Getter',
                ),
              ),
              gifUrls.isEmpty?const CircularProgressIndicator():SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                child: ListView.separated(
                  itemCount: 8,
                  itemBuilder: (_,int index){
                    return GifCard(gifUrls[index]);
                  },
                  separatorBuilder: (_,__){
                    return const Divider(
                      color: Colors.orange,
                      thickness: 5,
                      height: 5,
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
