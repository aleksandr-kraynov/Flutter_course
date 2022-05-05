import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Language { russian, english, deutsch, french, japanese, unknown }

abstract class Attribut {
  final String id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  const Attribut(this.id, this.title, this.picture, this.voteAverage,
      this.releaseDate, this.description, this.language);

  void aboutAttribut();
}

class Film extends Attribut with Converter {
  const Film(
      {required String id,
      required String title,
      required String picture,
      required double voteAverage,
      required String releaseDate,
      required String description,
      required String language})
      : super(id, title, picture, voteAverage, releaseDate, description,
            language);

  @override
  void aboutAttribut() {
    var languageType = getLanguage(language);

    print('Фильм $title, язык ${languageType.toPrettyString()}');
  }
}

mixin Converter {
  Language getLanguage(String language) {
    switch (language) {
      case 'russian':
        return Language.russian;
      case 'english':
        return Language.english;
      case 'deutsch':
        return Language.deutsch;
      case 'french':
        return Language.french;
      case 'japanese':
        return Language.japanese;
      default:
        return Language.unknown;
    }
  }
}

extension LanguageExtension on Language {
  String toPrettyString() {
    switch (this) {
      case Language.russian:
        return 'Русский';
      case Language.english:
        return 'Английский';
      case Language.deutsch:
        return 'Немецкий';
      case Language.french:
        return 'Французский';
      case Language.japanese:
        return 'Японский';
      case Language.unknown:
        return 'Не понятный язык';
    }
  }
}

void main() {
  List<Film> films = _getFilms();

  for (final film in films) {
    film.aboutAttribut();
  }

  List<Film> filterFilms = _filterFilm(films);

  print('Рейтинг выше 8.7');

  for (final film in filterFilms) {
    film.aboutAttribut();
  }
}

List<Film> _filterFilm(List<Film> films) {
  return films.where((e) => e.voteAverage >= 8.8).toList();
}

List<Film> _getFilms() {
  return [
    const Film(
        id: '1',
        title: 'Властелин колец',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/a2d5bcae-a1a9-442f-8195-f5373a5ba77f/300x450',
        voteAverage: 8.6,
        releaseDate: '2001',
        description:
            'Сказания о Средиземье — это хроника Великой войны за Кольцо, длившейся не одну тысячу лет',
        language: 'english'),
    const Film(
        id: '2',
        title: 'Унесённые призраками',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/ae3b699c-3db7-4196-a869-39b610bfe706/300x450',
        voteAverage: 8.5,
        releaseDate: '2001',
        description: 'Тихиро с мамой и папой переезжает в новый дом',
        language: 'japanese'),
    const Film(
        id: '3',
        title: '1+1',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/bf93b465-1189-4155-9dd1-cb9fb5cb1bb5/300x450',
        voteAverage: 8.8,
        releaseDate: '2011',
        description:
            'Пострадав в результате несчастного случая, богатый аристократ Филипп нанимает в помощники человека, который менее всего подходит для этой работы',
        language: 'french'),
    const Film(
        id: '4',
        title: 'Достучаться до небес',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/aac37c55-3aa2-4f4d-b3ed-9f59ba426f92/300x450',
        voteAverage: 8.6,
        releaseDate: '1997',
        description:
            'Судьба сводит двух незнакомцев в больнице, где они получают смертельные диагнозы',
        language: 'deutsch'),
    const Film(
        id: '5',
        title: 'Иван Васильевич меняет профессию',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/1a170eea-da02-40c1-a750-91c59d56e1a6/300x450',
        voteAverage: 8.8,
        releaseDate: '1973',
        description:
            'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного',
        language: 'russian')
  ];
}
