import 'dart:convert';

List<Word> wordFromJson(String str) =>
    List<Word>.from(json.decode(str).map((x) => Word.fromJson(x)));

String wordToJson(List<Word> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// To parse this JSON data, do
//
//     final word = wordFromJson(jsonString);

class Word {
  Word({
    this.word,
    this.meanings,
  });

  String word;
  List<Meaning> meanings;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        word: json["word"],
        meanings: List<Meaning>.from(
            json["meanings"].map((x) => Meaning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "meanings": List<dynamic>.from(meanings.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Word{word: $word, meanings: $meanings}';
  }
}

class Meaning {
  Meaning({
    this.partOfSpeech,
    this.definitions,
  });

  String partOfSpeech;
  List<Definition> definitions;

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": List<dynamic>.from(definitions.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Meaning{partOfSpeech: $partOfSpeech, definitions: $definitions}';
  }
}

class Definition {
  Definition({
    this.definition,
    this.synonyms,
    this.example,
  });

  String definition;
  List<String> synonyms;
  String example;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: json["synonyms"] != null
            ? List<String>.from(json["synonyms"].map((x) => x))
            : [],
        example: json["example"],
      );

  Map<String, dynamic> toJson() => {
        "definition": definition,
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "example": example,
      };

  @override
  String toString() {
    return 'Definition{definition: $definition, synonyms: $synonyms, example: $example}';
  }
}
