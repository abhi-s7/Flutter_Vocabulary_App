import 'package:wordbot/constants/WordListText.dart';
import 'dart:math';

//this class is to extract the words and categories from the constant text of wordlist in file: WordListText.dart
class ExtractWords {
  /* ************* Index wise ******************* */

  static List extractWordsIndexWise(int listNum, int part) {
    var allList = new List();
    var wordList = new List();
    var categoryList = new List();

    String wordListStr =
        kGetWordList(listNum); //this will get through only list number
    //print('WordList is $wordListStr');
    var outOf4Category = wordListStr.split("~");
    var lines = [];
    if (part == 10) {
      //all categories
      for (int subPart = 0; subPart < 4; subPart++)
        lines += outOf4Category[subPart].split(";");
    } else {
      lines = outOf4Category[part - 1].split(";");
    }

    for (var oneLine in lines) {
      int colonIndex = oneLine.indexOf(':');
      var category = oneLine.substring(0, colonIndex);
      var listOfWords = oneLine.substring(colonIndex + 1).trim();

      addToLists(wordList, categoryList, category, listOfWords);
    }

    allList..add(wordList)..add(categoryList);
    return allList;
  }

  static List extractOnlyCategoryIndexWise(int listNum, int part) {
    var categoryList = new List();
    String wordListStr =
        kGetWordList(listNum); //this will get through only list number
    var outOf4Category = wordListStr.split("~");
    var lines = outOf4Category[part - 1].split(";");
    for (var oneLine in lines) {
      int colonIndex = oneLine.indexOf(':');
      var category = oneLine.substring(0, colonIndex);
      categoryList.add(category);
    }
    return categoryList;
  }

  static List extractAllCategoryListWise(int listNum) {
    var categoryList = new List();
    String wordListStr =
        kGetWordList(listNum); //this will get through only list number
    //print('WordList is $wordListStr');
    var outOf4Category = wordListStr.split("~");
    outOf4Category.forEach((oneBoxCategory) {
      var lines = oneBoxCategory.split(";");
      for (var oneLine in lines) {
        int colonIndex = oneLine.indexOf(':');
        var category = oneLine.substring(0, colonIndex);
        categoryList.add(category);
      }
    });
    return categoryList;
  }

  static void addToLists(List wordsList, List correspondingCategoryList,
      String category, String words) {
    var wordsArr = words.split(",");

    for (String word in wordsArr) {
      wordsList.add(word);
      correspondingCategoryList.add(category);
    }
  }

  static List randomIndexList(int wordListSize) {
    Random rand = new Random();
    var hashing = new List(wordListSize);

    List indexList = new List();
    int count = 0;
    while (indexList.length != wordListSize) {
      count++;
      // take a random index between 0 to size
      int randomIndex = rand.nextInt(wordListSize);
      // first check whether it is present in the hashing or not
      if (hashing[randomIndex] != 1) {
        // the only add that random index to the queue
        indexList.add(randomIndex);
        // put flag to 1 in the hashing table
        hashing[randomIndex] = 1;
      }
    }
    return indexList;
  }
}
