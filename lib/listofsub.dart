import 'package:flutter_application_1/clas.dart';
import 'package:flutter_application_1/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page2.dart';

class Listpage extends StatefulWidget {
  final Function refresh;
  const Listpage({super.key, required this.refresh});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  final List<Bloc> _searchResults = [];
  TextEditingController controller = TextEditingController();
  bool kr = false;
  void someAsyncFunction() async {
    try {
      await Servi().fetchBlogs(context);
      setState(() {
        kr = true;
      });
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  _onSearchTextChanged(String query) async {
    _searchResults.clear();
    if (query.isEmpty) {
      setState(() {});
      return;
    }
    for (var element in dataMap) {
      if (element.title.toLowerCase().contains(query.toLowerCase())) {
        _searchResults.add(element);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      someAsyncFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return kr
        ? Column(
            children: [
              Expanded(
                flex: !sea ? 1 : 0,
                child: !sea
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10),
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          title: TextField(
                            onChanged: _onSearchTextChanged,
                            controller: controller,
                            decoration: const InputDecoration(
                              labelText: 'Search  Article',
                              hintMaxLines: 1,
                            ),
                          ),
                          actions: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              color: Colors.black,
                              onPressed: () {
                                controller.text = '';
                                _onSearchTextChanged('');
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Expanded(
                  flex: !sea ? 9 : 10,
                  child: _searchResults.isNotEmpty || controller.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (BuildContext context, int index) {
                            return box(_searchResults[index]);
                          },
                        )
                      : ListView.builder(
                          itemCount: dataMap.length,
                          itemBuilder: (BuildContext context, int index) {
                            return box(dataMap[index]);
                          },
                        )),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.black,
            ),
          );
  }

  Widget box(Bloc ele) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Eachbloc(
              text: ele,
            ),
          ),
        );
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black87,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Text(
                      ele.title,
                      style: const TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white70.withOpacity(0.8),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.network(
                          ele.imgurl,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Text('Failed to load image');
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              topLeft: Radius.circular(32.0),
                            ),
                            boxShadow: [BoxShadow(color: Colors.black87)]),
                        child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.star,
                            color: ele.lik ? Colors.blueGrey : Colors.yellow,
                          ),
                          onPressed: () {
                            ele.lik = !ele.lik;
                            Servi().update(ele);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
