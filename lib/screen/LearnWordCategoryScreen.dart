import 'package:flutter/material.dart';
import 'package:wordbot/constants/WordListText.dart';
import 'package:wordbot/components/ResuableCard.dart';
import 'package:wordbot/screen/LearnWordsScreen.dart';
import 'package:wordbot/util/ExtractWords.dart';

class LearnWordCategoryScreen extends StatefulWidget {
  static const String id = 'learn_word_category_screen';
  final int listNumber;
  LearnWordCategoryScreen({this.listNumber});
  @override
  _LearnWordCategoryScreenState createState() =>
      _LearnWordCategoryScreenState();
}

class _LearnWordCategoryScreenState extends State<LearnWordCategoryScreen> {
  List categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    _extractList();
    super.initState();
  }

  _extractList() {
    //adding all 4 lists
    for (int i = 1; i <= 4; i++) {
      categoryList +=
          ExtractWords.extractOnlyCategoryIndexWise(widget.listNumber, i);
    }
  }

  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFddf3f5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xFFa6dcef),
        title: Text(
          'Choose a category!',
          style: TextStyle(
            color: Colors.black54,
            letterSpacing: 2,
            fontFamily: 'Crimson',
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          Wrap(
              //it is in form of the Grid
              //it's a wrapper on Grid and List
              children: categoryList
                  .map(
                    (categoryWord) => GestureDetector(
                      // ::::: This will provide onTap feature as there is not such feature in Container or Image
                      onTap: () {
                        String listStr = kGetWordList(widget.listNumber);
                        int index = listStr.indexOf(categoryWord);
                        String leftListStr = listStr.substring(index);
                        int indexColon = leftListStr.indexOf(":");
                        int indexSemiColon = leftListStr.indexOf(";");
                        int indexTilde = leftListStr.indexOf("~");

                        String finalLeftList = '';
                        if (indexSemiColon == -1) {
                          //this means semicolon didn't came and it is the last category
                          finalLeftList = leftListStr.substring(indexColon + 1);
                        } else {
                          //check if ~ came before ;
                          if (indexTilde != -1 && indexTilde < indexSemiColon) {
                            // this means that ; will have index and ~ will also have. If ~ comes first before ; then substring till `
                            finalLeftList = leftListStr.substring(
                                indexColon + 1, indexTilde);
                          } else {
                            finalLeftList = leftListStr.substring(
                                indexColon + 1, indexSemiColon);
                          }
                        }
                        print('List is :$finalLeftList');

                        //Navigator.of(context).pushNamed(MiddleScreen.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearnWordsScreen(
                                category: categoryWord,
                                wordList: finalLeftList.split(
                                    ",")), //listNumber: widget.listNumber
                          ),
                        );
                      },
                      child: ReusableWidget(
                        cardChild: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(
                            child: Text(
                              '$categoryWord',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                letterSpacing: 2,
                                fontFamily: 'Crimson',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        cardHeight: deviceSize.height * 0.2,
                        colorCustom: Color(0xFFa6dcef),
                      ),
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
