import 'package:flutter/material.dart';
import 'package:wordbot/components/ResuableCard.dart';
import 'package:wordbot/model/Data.dart';
import 'package:wordbot/screen/ReviseWordsScreen.dart';
import 'package:wordbot/util/ExtractWords.dart';

class ReviseWordsCategoryScreen extends StatefulWidget {
  static const String id = 'revise_words_category_screen';
  final int listNumber;
  ReviseWordsCategoryScreen({this.listNumber});
  @override
  _ReviseWordsCategoryScreenState createState() =>
      _ReviseWordsCategoryScreenState();
}

class _ReviseWordsCategoryScreenState extends State<ReviseWordsCategoryScreen> {
  List categoryList1;
  List categoryList2;
  List categoryList3;
  List categoryList4;
  @override
  void initState() {
    // TODO: implement initState
    categoryList1 =
        ExtractWords.extractOnlyCategoryIndexWise(widget.listNumber, 1);
    categoryList2 =
        ExtractWords.extractOnlyCategoryIndexWise(widget.listNumber, 2);
    categoryList3 =
        ExtractWords.extractOnlyCategoryIndexWise(widget.listNumber, 3);
    categoryList4 =
        ExtractWords.extractOnlyCategoryIndexWise(widget.listNumber, 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _getCategoryWords(int listNum) {
      List list;
      String str = '';
      if (listNum == 1)
        list = categoryList1;
      else if (listNum == 2)
        list = categoryList2;
      else
        list = categoryList3;

      list.forEach((element) {
        str += element + ", ";
      });
      return str.substring(0, str.length - 2);
    }

    return Scaffold(
      backgroundColor: Color(0xFFddf3f5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xFFa6dcef),
        title: Text(
          'Vocabulary List ${widget.listNumber}',
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
        children: [
          CommonExpandedCard(
            listNumber: widget.listNumber,
            part: 1,
            categories: _getCategoryWords(1),
          ),
          CommonExpandedCard(
            listNumber: widget.listNumber,
            part: 2,
            categories: _getCategoryWords(2),
          ),
          CommonExpandedCard(
            listNumber: widget.listNumber,
            part: 3,
            categories: _getCategoryWords(3),
          ),
          CommonExpandedCard(
            listNumber: widget.listNumber,
            part: 4,
            categories: _getCategoryWords(4),
          ),
          CommonExpandedCard(
            listNumber: widget.listNumber,
            part: 10,
            categories: 'ALL CATEGORIES',
          )
        ],
      ),
    );
  }
}

class CommonExpandedCard extends StatelessWidget {
  final int listNumber;
  final int part;
  final String categories;

  CommonExpandedCard(
      {@required this.listNumber, @required this.part, this.categories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          //Navigator.of(context).pushNamed(WordList.id);
          final data = Data(listNumber: listNumber, part: part);
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => ReviseListScreen(data: data),
              builder: (context) => ReviseWordsScreen(data: data),
            ),
          );
        },
        child: ReusableWidget(
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
//                    '${current <= list.length ? list[0][current] : ""}',
                    '$categories',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      letterSpacing: 2,
                      fontFamily: 'Crimson',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          colorCustom: Color(0xFFa6dcef),
        ),
      ),
    );
  }
}
