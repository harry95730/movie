import 'package:flutter_application_1/clas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/each.dart';

Widget function(BuildContext context, List<Bloc> searchResults) {
  return SizedBox(
    height: 483,
    child: ListView.builder(
      itemCount: (searchResults.length / 2).ceil(),
      itemBuilder: (BuildContext context, int index) {
        int startIndex = index * 2;

        if (startIndex < searchResults.length) {
          Bloc abc = searchResults[startIndex];
          if (startIndex + 1 < searchResults.length) {
            Bloc def = searchResults[startIndex + 1];
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
        return null;
      },
    ),
  );
}

Widget eachwid(BuildContext context, Bloc harry) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyPage(harry: harry)));
      },
      child: Container(
        width: 175,
        height: 208,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.network(
                harry.images[0],
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                harry.title,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              harry.description,
              maxLines: 2,
              softWrap: true,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '\$${harry.price.toString()}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, fill: 1.0, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
