import 'dart:convert';

import 'package:api_app/model/data.dart';
import 'package:api_app/screens/company.dart';
import 'package:api_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiDataScreen extends StatefulWidget {
  const ApiDataScreen({super.key});

  @override
  State<ApiDataScreen> createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  Future<List<Data>> fetchAlbum() async {
    var url = Uri.https('hoblist.com', 'api/movieList');
    var response = await http.post(url, body: {
      'category': 'movies',
      'language': 'kannada',
      'genre': 'all',
      'sort': 'voting'
    });

    if (response.statusCode == 200) {
      // prin/t(response.body);
      var bd = response.body;
      var jsonData = jsonDecode(bd);
      jsonData = jsonData['result'];
      List<Data> data = [];
      for (var i in jsonData) {
        Data data1 = Data(
            director: i['director'][0],
            title: i['title'],
            stars: i['stars'][0],
            genre: i['voted'][0]['genre'],
            poster: i['poster'],
            pageViews: i['pageViews'],
            totalVoted: i['totalVoted']);
        data.add(data1);
      }
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Color(0xFF4CAF50),
        title: Text("Movie List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
               Navigator.pushNamed(context, '/company-detail');
            },
            icon: Icon(Icons.menu),
          ), IconButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
             pref.setBool("isLogin", false);
            Navigator.pushNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: FutureBuilder<List<Data>>(
        future: fetchAlbum(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CardW(
                    director: snapshot.data![index].director.toString(),
                    title: snapshot.data![index].title.toString(),
                    stars: snapshot.data![index].stars.toString(),
                    genre: snapshot.data![index].genre.toString(),
                    poster: snapshot.data![index].poster.toString(),
                    pageViews: snapshot.data![index].pageViews.toString(),
                    totalVoted: snapshot.data![index].totalVoted.toString());
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}

class CardW extends StatelessWidget {
  final String director, title, stars, genre, poster, pageViews, totalVoted;
  const CardW(
      {super.key,
      required this.director,
      required this.title,
      required this.stars,
      required this.genre,
      required this.poster,
      required this.pageViews,
      required this.totalVoted});

  @override
  Widget build(BuildContext context) {
    return customcard(
      context,
        title, director, stars, genre, poster, pageViews, totalVoted);
  }

  Widget customcard(BuildContext context, String title, String director, String stars, String genre,
      String poster, String pageViews, String totalVoted) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,


        // movie area
        children: [
          Container(
          child: Row(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_drop_up_outlined),
                    Text(totalVoted.toString()),
                    Icon(Icons.arrow_drop_down_outlined),
                    Text("Votes")
                  ],
                ),
              ),
            SizedBox(width:7),
              // taking image
              Container(
                color: Color.fromARGB(255, 212, 7, 7),
                width: 135,
                height: 200,
                child: Image.network(poster),
              ),
             SizedBox(width: 10,),
              // taking texts
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Title:' + title),
                  SizedBox(height: 10,),
                  Text('Director:' + director),
                   SizedBox(height: 10,),
                  Text('Stars:' + stars),
                   SizedBox(height: 10,),
                  Text('Genre:' + genre),
                   SizedBox(height: 10,),
                  Text('PageViews:' + pageViews),
                   SizedBox(height: 10,),
                  Text('TotalVoted:' + totalVoted),
                ]),
              )
            ],
          ),
        ),

        // button area

        ElevatedButton(


          onPressed: (){
          
          },
          child: Text('Watch Trailer'),
        )
        ]
      ),
    );
  }
}
