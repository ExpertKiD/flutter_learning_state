import 'package:flutter/material.dart';

void main() => runApp(App());

const List<String> urls = [
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cute-baby-animals-1558535060.jpg',
  'https://api.timeforkids.com/wp-content/uploads/2020/08/animalVoting.jpg?w=1024',
  'https://cityofmontevallo.com/Assets/Images/AnimalControl/0_GettyImages-1143342151.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL2de_EUA1aFedrjCcpFf8FbMObTcG3BkGcQ&usqp=CAU',
  'https://www.rd.com/wp-content/uploads/2020/05/GettyImages-109433950-scaled.jpg',
  'https://thumbor.forbes.com/thumbor/711x533/https://specials-images.forbesimg.com/imageserve/5faad4255239c9448d6c7bcd/Best-Animal-Photos-Contest--Close-Up-Of-baby-monkey/960x0.jpg?fit=scale',
];

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Viewer',
      home: GalleryPage(
        urls: urls,
        title: 'Image Gallery',
      ),
    );
  }
}

class Photo extends StatelessWidget {
  const Photo({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  final String title;
  final List<String> urls;

  const GalleryPage({Key? key, required this.title, required this.urls})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        primary: false,
        children: List.of(urls.map((url) => Photo(
              url: url,
            ))),
      ),
    );
  }
}
