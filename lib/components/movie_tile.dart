import 'package:flutter/material.dart';

import '../provider/api_provider.dart';

class movieTile extends StatelessWidget {
  movieTile({
    Key? key,
    required this.postMdl,
  }) : super(key: key);

  final PostDataProvider postMdl;
  Color boxColor = Colors.green;
  findColor() {
    if (postMdl.post.title != null) {
      double rating = double.parse(postMdl.post.rating ?? "10.0");
      if (rating < 4)
        boxColor = Colors.red;
      else if (rating < 7) boxColor = Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    findColor();
    return postMdl.post.title == null
        ? SizedBox(
            height: 0,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Material(
                    elevation: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: SizedBox(
                              height: 100,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  postMdl.post.title ?? "Not found",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  postMdl.post.genre?.split(",").join(" | ") ??
                                      "No genre",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: boxColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 20,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      postMdl.post.rating == null
                                          ? "0"
                                          : postMdl.post.rating! + ' IMDB',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 200,
                      child: Image.network(
                        postMdl.post.poster ??
                            "https://t4.ftcdn.net/jpg/02/51/95/53/360_F_251955356_FAQH0U1y1TZw3ZcdPGybwUkH90a3VAhb.jpg",
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
