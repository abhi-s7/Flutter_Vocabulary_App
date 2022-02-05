import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:wordbot/model/Word.dart';

class WordService {
  static String word = 'dummy';
  static final String url =
      "https://api.dictionaryapi.dev/api/v2/entries/en_US/";

  static Future<List<Word>> getWordFromRESTApi() async {
    try {
      final response = await http.get(url + word);
      //print('Response is ${response.statusCode} : ${response.body}');
      if (200 == response.statusCode) {
        final List<Word> users = wordFromJson(response.body);
        print('User is $users');
        return users;
      } else {
        return List<Word>();
      }
    } catch (e) {
      print(e.toString());
      return List<Word>();
    }
  }

  static Future<List<Meaning>> getMeaningData() async {
    List<Word> listOfWords = await getWordFromRESTApi();
    if (null == listOfWords || listOfWords.isEmpty) {
      return [];
    }
    print('List is $listOfWords');
    String word = listOfWords[0].word;
    List<Meaning> listOfMeanings = listOfWords[0].meanings;

    listOfMeanings.forEach((meaning) {
      String partOfSpeech = meaning.partOfSpeech;
      List<Definition> listOfDefinition = meaning.definitions;

      listOfDefinition.forEach((definition) {
        print(
            'Definition of $word (${partOfSpeech}) :  ${definition.definition} \nExample: ${definition.example} \nSynonymns ${definition.synonyms}');
      });
    });
    return listOfMeanings;
  }
}
