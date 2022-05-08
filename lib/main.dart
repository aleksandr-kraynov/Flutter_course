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
}

class Film extends Attribut {
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
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Фильмы',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.yellow,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Film> films = [];

  bool filterWeight = false;

  @override
  void initState() {
    _getFilms().then((value) {
      setState(() {
        films = value;
      });
    });
    super.initState();
  }

  Future<List<Film>> _getFilms() async {
    await Future.delayed(const Duration(seconds: 1));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список фильмов'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: filterWeight,
                  onChanged: (bool? changeValue) {
                    setState(() {
                      filterWeight = changeValue ?? false;
                    });
                  },
                ),
                const Text('Рейтинг больше 8.7'),
              ],
            ),
            ElevatedButton(
              onPressed: filterFilms,
              child: const Text('Поиск'),
            ),
            ...List.generate(films.length, (index) {
              return FilmCard(
                title: films[index].title,
                picture: films[index].picture,
                voteAverage: films[index].voteAverage,
                releaseDate: films[index].releaseDate,
                description: films[index].description,
                language: films[index].language,
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> filterFilms() async {
    await _getFilms().then((valueFilms) {
      setState(() {
        if (filterWeight) {
          films = valueFilms.where((e) => e.voteAverage >= 8.8).toList();
        } else {
          films = valueFilms;
        }
      });
    });
  }
}

class FilmCard extends StatelessWidget {
  const FilmCard({
    Key? key,
    // required this.id,
    required this.title,
    required this.picture,
    required this.voteAverage,
    required this.releaseDate,
    required this.description,
    required this.language,
  }) : super(key: key);

  // final String id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.yellow,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 1,
          child: Image.network(picture),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Название: ' + title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Рейтинг: $voteAverage',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Год выпуска: ' + releaseDate,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Описание: ' + description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Язык: ' + language,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
