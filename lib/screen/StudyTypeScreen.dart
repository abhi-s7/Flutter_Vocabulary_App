import 'package:flutter/material.dart';
import 'package:wordbot/components/ResuableCard.dart';
import 'package:wordbot/screen/LearnWordCategoryScreen.dart';
import 'package:wordbot/screen/ReviseWordsCategoryScreen.dart';

class StudyTypeScreen extends StatefulWidget {
  static const String id = 'study_type_screen';
  final int listNumber;
  StudyTypeScreen({this.listNumber});
  @override
  _StudyTypeScreenState createState() => _StudyTypeScreenState();
}

class _StudyTypeScreenState extends State<StudyTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFddf3f5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xFFa6dcef),
        title: Text(
          'Study Type?',
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
        margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          children: [
            CommonExpandedCard(
              listNumber: widget.listNumber,
              title: 'Learn',
            ),
            CommonExpandedCard(
              listNumber: widget.listNumber,
              title: 'Revise',
            ),
          ],
        ),
      ),
    );
  }
}

class CommonExpandedCard extends StatelessWidget {
  final int listNumber;
  final String title;

  CommonExpandedCard({@required this.listNumber, this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          //Navigator.of(context).pushNamed(WordList.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (title == 'Revise') {
                  return ReviseWordsCategoryScreen(
                    listNumber: listNumber,
                  );
                } else {
                  return LearnWordCategoryScreen(listNumber: listNumber);
                }
              },
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
                    '$title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      letterSpacing: 2,
                      fontFamily: 'Crimson',
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
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
