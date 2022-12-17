import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_calls.dart';
import '../components/movie_tile.dart';
import '../provider/api_provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  searchForMovie(context, String movieName) {
    final postMdl = Provider.of<PostDataProvider>(context, listen: false);
    postMdl.getPostData(context, movieName);
  }

  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _controller,
        onSubmitted: (string) async {
          if (!_controller.text.isEmpty) {
            setState(() {
              isLoading = true;
            });
            await searchForMovie(context, _controller.text);
            setState(() {
              isLoading = false;
            });
          }
        },
        decoration: InputDecoration(
          hintText: "Search for movies",
          suffixIcon: IconButton(
            onPressed: () async {
              if (!_controller.text.isEmpty) {
                setState(() {
                  isLoading = true;
                });
                await searchForMovie(context, _controller.text);
                setState(() {
                  isLoading = false;
                });
              }
            },
            icon: Icon(Icons.search),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final postMdl = Provider.of<PostDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _searchBox(),
                  postMdl.loading
                      ? Container(
                          child: CircularProgressIndicator(),
                        )
                      : postMdl.post.title == "Not Found"
                          ? Container(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text("Not found"),
                              ),
                            )
                          : movieTile(postMdl: postMdl),
                ],
              ),
            ),
    );
  }
}
