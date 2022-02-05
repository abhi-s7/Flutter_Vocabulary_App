import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordbot/components/RoundButton.dart';
import 'package:wordbot/model/Data.dart';
import 'package:wordbot/model/Word.dart';
import 'package:wordbot/service/WordService.dart';

class LearnWordsScreen extends StatefulWidget {
  static final id = "learn_words_screen";

  LearnWordsScreen({this.category, this.wordList});
  final String category;
  final List<String> wordList;

  @override
  _LearnWordsScreenState createState() => _LearnWordsScreenState();
}

class _LearnWordsScreenState extends State<LearnWordsScreen> {
  var _current = 0;
  bool _fetchMeaning = false;

  List<Meaning> listOfMeaning = [];

  _getMeaningsList(String word) {
    WordService.word = word;
    WordService.getMeaningData().then((list) {
      setState(() {
        listOfMeaning = list;
      });
    });
  }

  String _getSynonymns(List list) {
    if (list.length > 5) {
      list = list.sublist(0, 5);
    }
    String str = list.toString();
    return str.replaceAll(RegExp('\\[|\\]'), '');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFddf3f5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xFFa6dcef),
        title: Text(
          '${widget.category}',
          style: TextStyle(
            color: Colors.black54,
            letterSpacing: 2,
            fontFamily: 'Crimson',
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: screenSize.height * 0.65,
                initialPage: 0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  print('Reason is $reason');
                  setState(() {
                    _current = index;
                    _fetchMeaning = false;
                    listOfMeaning = [];
                  });
                },
              ),
              items: widget.wordList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      //margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFa6dcef),
                          borderRadius: BorderRadius.circular(14.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                '$item',
                                style: TextStyle(
                                  color: Colors.black54,
                                  letterSpacing: 2,
                                  fontFamily: 'Crimson',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.lightbulb,
                            onPress: () {
                              //Todo: add onpress
                              setState(() {
                                _getMeaningsList(
                                    item); //this will load the meaning
                                _fetchMeaning = !_fetchMeaning;
                              });
                            },
                            color: Colors.yellow[300],
                          ),
                          Expanded(
                            flex: 6,
                            child:
                                /* if statement *************/
                                _fetchMeaning &&
                                        widget.wordList[_current] == item &&
                                        listOfMeaning.length > 0
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: ListView.builder(
                                            itemCount: listOfMeaning.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30,
                                                            vertical: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${listOfMeaning[index].partOfSpeech}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Pacifico',
                                                              color: Colors.red,
//                                                  color: Color(0xFF1B7A9F),
                                                              letterSpacing: 1,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Container(
                                                          child:
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      ScrollPhysics(),
//                                                          /*
//                                                          Adding shrinkWrap: true, physics: ScrollPhysics(), inside the listview.builder, in this case the listview.builder need an expanded parent. The physics: ScrollPhysics() will allow it to maintain its state without scrolling back to the first items. Also, you can use physics: NeverScrollableScrollPhysics(), if you don't want the listview.builder to be scrolled by the user.
//                                                          */
//                                                           */
                                                                  itemCount: listOfMeaning[
                                                                          index]
                                                                      .definitions
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int indexOfDefinition) {
                                                                    return Container(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            "Def: ${listOfMeaning[index].definitions[indexOfDefinition].definition}",
//                                                      "Def: ${listOfMeaning[index].definitions[0].definition}",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Crimson',
                                                                                fontWeight: FontWeight.w900,
                                                                                color: Colors.black54,
                                                                                fontSize: 16),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                8,
                                                                          ),
                                                                          Text(
                                                                            'Example: "${listOfMeaning[index].definitions[indexOfDefinition].example}"',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Crimson',
                                                                                color: Colors.white,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                8,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    listOfMeaning[index]
                                                                .definitions[0]
                                                                .synonyms
                                                                .length >
                                                            0
                                                        ? 'Synonymns'
                                                        : '',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Pacifico',
                                                        color: Colors.red,
//                                                  color: Color(0xFF1B7A9F),
                                                        letterSpacing: 1,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 30),
                                                    child: Text(
                                                      '${_getSynonymns(listOfMeaning[index].definitions[0].synonyms)}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'Crimson',
                                                          color: Colors.white,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                ],
                                              );
                                            }),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.0, horizontal: 10.0),
                                        child: Image.asset(
                                          'assets/images/imagePlaceholderMiddle.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
