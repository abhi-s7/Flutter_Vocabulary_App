import 'package:flutter/material.dart';
import 'package:wordbot/components/RoundButton.dart';
import 'package:wordbot/components/ResuableCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordbot/model/Data.dart';
import 'package:wordbot/model/Word.dart';
import 'package:wordbot/service/WordService.dart';
import 'package:wordbot/util/ExtractWords.dart';

class ReviseWordsScreen extends StatefulWidget {
  static const String id = 'revise_words_screen';
  final Data data;

  ReviseWordsScreen({this.data});

  @override
  _ReviseWordsScreenState createState() => _ReviseWordsScreenState();
}

class _ReviseWordsScreenState extends State<ReviseWordsScreen> {
  int current;
  bool showWord = false;
  bool _fetchMeaning = false;
  var list;
  List randomIndexList;

  @override
  void initState() {
    // TODO: implement initState
    current = 0;
    print('Data is ${widget.data.listNumber} ${widget.data.part}');
    //list = ShowWords.extractWords(widget.data.listNumber, widget.data.part);
    list = ExtractWords.extractWordsIndexWise(
        widget.data.listNumber, widget.data.part);
    randomIndexList = ExtractWords.randomIndexList(list[0].length);
    super.initState();
  }

  List<Meaning> listOfMeaning = [];

  _getMeaningsList(String word) {
    WordService.word = word;
    WordService.getMeaningData().then((list) {
      setState(() {
        listOfMeaning = list;
//        print(
//            'fetch meaning = $_fetchMeaning & list of meaning size is ${listOfMeaning.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
//    var map = ModalRoute.of(context)!.settings.arguments as Map;

    _getWord() {
      if (current >= randomIndexList.length) return "End of word";
      int index = randomIndexList[current];
      return list[0][index];
    }

    _getCategory() {
      if (current >= randomIndexList.length) return "End of category";
      int index = randomIndexList[current];
      return list[1][index];
    }

    String _getSynonymns(List list) {
      if (list.length > 5) {
        list = list.sublist(0, 5);
      }
      String str = list.toString();
      return str.replaceAll(RegExp('\\[|\\]'), '');
    }

    return Scaffold(
      backgroundColor: Color(0xFFddf3f5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xFFa6dcef),
        title: Text(
          'Guess Category of Words',
          style: TextStyle(
            color: Colors.black54,
            letterSpacing: 2,
            fontFamily: 'Crimson',
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              //width: size.width * 0.6,
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
                        '${_getWord()}',
                        // '$item',
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
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
//                          '${current <= list.length ? list[1][current] : ""}',
                          showWord ? '=> ${_getCategory()}' : '**********',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontFamily: 'Crimson',
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child:
                        /* if statement *************/
                        _fetchMeaning && listOfMeaning.length > 0
                            ? Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: ListView.builder(
                                    itemCount: listOfMeaning.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${listOfMeaning[index].partOfSpeech}",
                                                  style: TextStyle(
                                                      fontFamily: 'Pacifico',
                                                      color: Colors.red,
//                                                  color: Color(0xFF1B7A9F),
                                                      letterSpacing: 1,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
//                                                          /*
//                                                          Adding shrinkWrap: true, physics: ScrollPhysics(), inside the listview.builder, in this case the listview.builder need an expanded parent. The physics: ScrollPhysics() will allow it to maintain its state without scrolling back to the first items. Also, you can use physics: NeverScrollableScrollPhysics(), if you don't want the listview.builder to be scrolled by the user.
//                                                          */
//                                                           */
                                                      itemCount:
                                                          listOfMeaning[index]
                                                              .definitions
                                                              .length,
                                                      itemBuilder: (BuildContext
                                                              context,
                                                          int indexOfDefinition) {
                                                        return Container(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "Def: ${listOfMeaning[index].definitions[indexOfDefinition].definition}",
//                                                      "Def: ${listOfMeaning[index].definitions[0].definition}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Crimson',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Text(
                                                                'Example: "${listOfMeaning[index].definitions[indexOfDefinition].example}"',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Crimson',
                                                                    color: Colors
                                                                        .white,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              /*   Text(
                                                            'Synonymns: ${_getSynonymns(listOfMeaning[index].definitions[indexOfDefinition].synonyms)}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Crimson',
//                                                                color:
//                                                                    Colors.red,
                                                                color:
                                                                    Colors.red,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16),
                                                          ),
                                                           SizedBox(
                                                            height: 12,
                                                          ),*/
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Text(
                                              '${_getSynonymns(listOfMeaning[index].definitions[0].synonyms)}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Crimson',
                                                  color: Colors.white,
                                                  fontStyle: FontStyle.italic,
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
                  ),
                ],
              ),
            ),
          ),
          /******************************************************************/
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            height: size.height * 0.1,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundIconButton(
                    icon: FontAwesomeIcons.times,
                    onPress: () {
                      //Todo: add onpress
                      setState(() {
                        if (current != randomIndexList.length) {
                          int index = randomIndexList[current];
                          if (current + 4 > randomIndexList.length - 1) {
                            randomIndexList.add(index);
                          } else {
                            randomIndexList.insert(current + 4, index);
                          }
                          current++;
                        }
                        listOfMeaning = [];
                        _fetchMeaning = false;
                        showWord = false;
                      });
                    },
                    color: Colors.redAccent,
                  ),
                  RoundIconButton(
                    icon: _fetchMeaning
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    onPress: () {
                      //Todo: add onpress
                      setState(() {
                        if (listOfMeaning.length == 0)
                          _getMeaningsList(_getWord());

                        print(
                            'List of meaning is ****************** ${listOfMeaning}');

                        _fetchMeaning = !_fetchMeaning;
                        print('_fetchMeaning is $_fetchMeaning');

                        if (_fetchMeaning) {
                          //word should also show
                          showWord = true;
                        } else {
                          showWord = false;
                        }
                        print('Show word is $showWord');
                      });
                    },
                    color: Colors.lightBlueAccent,
                  ),
                  RoundIconButton(
                    icon: showWord
                        ? FontAwesomeIcons.lightbulb
                        : FontAwesomeIcons.solidLightbulb,
                    onPress: () {
                      //Todo: add onpress
                      setState(() {
                        showWord = !showWord;
                        print('Show word is $showWord');
                      });
                    },
                    color: Colors.yellow[300],
                  ),
                  RoundIconButton(
                    icon: FontAwesomeIcons.check,
                    onPress: () {
                      //Todo: add onpress
                      setState(() {
                        showWord = false;
                        _fetchMeaning = false;
                        listOfMeaning = [];
                        current++;
                        print('Current value is $current');
                      });
                    },
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          )
        ],
      ),
    );
  }
}
