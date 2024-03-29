import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PHOTOFILE',
     home: Scaffold(
       appBar: AppBar(
         title: Text('PHOTOFILE'),backgroundColor: Colors.lightBlueAccent
         ),
       body: LoginPage(),
     ),
    
    );
  }
}

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery>

    with SingleTickerProviderStateMixin {
      bool loading;
      List<String> ids;


  AnimationController _controller;

  @override
  void initState() {
    loading = true;
    ids = [];


    _loadImageIds();

    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void _loadImageIds() async{
    final response = await http.get('https://picsum.photos/v2/list');
    final json = jsonDecode(response.body);
    List<String> _ids = [];
    for (var image in json){
      _ids.add(image['id']);
    }

    setState(() {
      loading = false;
      ids = _ids;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading){
      return Center(
        child:CircularProgressIndicator() ,
        );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('PHOTOFILE'),
      ),
      body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ImagePage(ids[index]);
            
            },
          
          ),
          
          );

        },
        child: Image.network(
          'https://picsum.photos/id/${ids[index]}/300/300',
         ),
         
      ),
      
      itemCount: ids.length,
    ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final String id;
  ImagePage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network('https://picsum.photos/id/$id/600/600',
        ),
      ),
    );
  }
}

