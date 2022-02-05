import 'package:flutter/material.dart';
import 'package:wordbot/components/ResuableCard.dart';
import 'package:wordbot/screen/StudyTypeScreen.dart';

class VocabListWidget extends StatelessWidget {
  //this will be called from the home screen
  List vocabList = [1, 2, 3, 4, 5, 6];

  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Wrap(
        //it is in form of the Grid
        //it's a wrapper on Grid and List
        children: vocabList
            .map(
              (vocabListNumber) => GestureDetector(
                // ::::: This will provide onTap feature as there is not such feature in Container or Image
                onTap: () {
                  //Navigator.of(context).pushNamed(MiddleScreen.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StudyTypeScreen(listNumber: vocabListNumber),
//                          MiddleScreen(listNumber: vocabListNumber),
                    ),
                  );
                },
                child: ReusableWidget(
                  cardChild: Center(
                    child: Text(
                      'Vocabulary List $vocabListNumber',
                      style: TextStyle(
                        color: Colors.black54,
                        letterSpacing: 2,
                        fontFamily: 'Crimson',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  cardHeight: deviceSize.height * 0.2,
                  colorCustom: Color(0xFFa6dcef),
                ),
              ),
            )
            .toList());
  }
}
