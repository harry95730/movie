import 'package:flutter_application_1/clas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/each.dart';
import 'package:flutter_application_1/rating.dart';

Widget function(BuildContext context, List<Movies> searchResults) {
  return searchResults.isNotEmpty
      ? ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: (searchResults.length / 2).ceil(),
          itemBuilder: (BuildContext context, int index) {
            int startIndex = index * 2;

            if (startIndex < searchResults.length) {
              Movies abc = searchResults[startIndex];
              if (startIndex + 1 < searchResults.length) {
                Movies def = searchResults[startIndex + 1];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [eachwid(context, abc), eachwid(context, def)],
                );
              } else {
                return Row(
                  children: [eachwid(context, abc), Container()],
                );
              }
            }
            return Container();
          },
        )
      : const Center(
          child: Text(
          'NO SEARCH RESULTS FOUND',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'f6',
            decoration: TextDecoration.none,
          ),
        ));
}

Widget eachwid(BuildContext context, Movies harry) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyPage(harry: harry)));
      },
      child: Container(
        width: 175,
        height: 165,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            harry.show!.image != null
                ? harry.show!.image!.medium != null
                    ? SizedBox(
                        height: 100,
                        child: Image.network(
                          harry.show!.image!.original!,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Text('Image not found');
                          },
                        ),
                      )
                    : Container()
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                harry.show!.name!,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            harry.show!.rating!.average != null
                ? StarRating(rating: harry.show!.rating!.average! / 2, br: true)
                : const StarRating(rating: 0, br: true),
          ],
        ),
      ),
    ),
  );
}
