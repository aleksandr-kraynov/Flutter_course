import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Language { russian, english, deutsch, french, chinese }

abstract class Attribut {
  final String id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  Attribut(this.id, this.title, this.picture, this.voteAverage,
      this.releaseDate, this.description, this.language);
}

class Films extends Attribut with Converter {
  Films(String id, String title, String picture, double voteAverage,
      String releaseDate, String description, String language)
      : super(id, title, picture, voteAverage, releaseDate, description,
            language);
}

mixin Converter {
  void converter(String language) {
    switch (language) {
      case 'russian':
        Language.russian;
        break;
      case 'english':
        Language.english;
        break;
      case 'deutsch':
        Language.deutsch;
        break;
      case 'french':
        Language.french;
        break;
      case 'chinese':
        Language.chinese;
        break;
    }
  }
}

extension LanguageName on Language {
  void toPrettyString(Language language) {
    switch (language) {
      case Language.russian:
        print('Русский');
        break;
      case Language.english:
        print('Английский');
        break;
      case Language.deutsch:
        print('Немецкий');
        break;
      case Language.french:
        print('Французский');
        break;
      case Language.chinese:
        print('Китайский');
        break;
    }
  }
}

Future<void> filmsFullList(List filmList) async {
  try {
    for (var item in filmList) {
      print(item.title);
    }
  } catch (e) {
    print('Фильмов нет');
  }
}

Future<void> filterFilmsList(List filmList) async {
  try {
    for (var item in filmList) {
      if (item.voteAverage >= 8.8) {
        print(item.title);
      }
    }
  } catch (e) {
    print('Фильмов нет');
  }
}

void main() {
  List filmList = [
    Films(
        '1',
        'Властелин колец',
        'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/a2d5bcae-a1a9-442f-8195-f5373a5ba77f/300x450',
        8.6,
        '2001',
        'Сказания о Средиземье — это хроника Великой войны за Кольцо, длившейся не одну тысячу лет',
        'english'),
    Films(
        '2',
        'Унесённые призраками',
        'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/ae3b699c-3db7-4196-a869-39b610bfe706/300x450',
        8.5,
        '2001',
        'Тихиро с мамой и папой переезжает в новый дом',
        'japanese'),
    Films(
        '3',
        '1+1',
        'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/300x450',
        8.8,
        '2011',
        'Пострадав в результате несчастного случая, богатый аристократ Филипп нанимает в помощники человека, который менее всего подходит для этой работы',
        'french'),
    Films(
        '4',
        'Достучаться до небес',
        'https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/aac37c55-3aa2-4f4d-b3ed-9f59ba426f92/300x450',
        8.6,
        '1997',
        'Судьба сводит двух незнакомцев в больнице, где они получают смертельные диагнозы',
        'deutsch'),
    Films(
        '5',
        'Иван Васильевич меняет профессию',
        'https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/1a170eea-da02-40c1-a750-91c59d56e1a6/300x450',
        8.8,
        '1973',
        'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного',
        'russian')
  ];

  filmsFullList(filmList);
  filterFilmsList(filmList);
}
