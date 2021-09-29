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

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  bool isTagging = false;
  List<PhotoState> photoStates = List.of(urls.map((url) => PhotoState(url)));

  void toggleTagging(String url) {
    setState(() {
      isTagging = !isTagging;
      photoStates.forEach((element) {
        if (isTagging && element.url == url) {
          element.selected = true;
        } else {
          element.selected = false;
        }
      });
    });
  }

  void onPhotoSelect(String url, bool selected) {
    setState(() {
      photoStates.forEach((element) {
        if (element.url == url) {
          element.selected = selected;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Viewer',
      home: GalleryPage(
        title: 'Image Gallery',
        onPhotoSelect: onPhotoSelect,
        tagging: isTagging,
        photoStates: photoStates,
        toogleTagging: toggleTagging,
      ),
    );
  }
}

class PhotoState {
  String url;
  bool selected;

  PhotoState(this.url, {this.selected = false});
}

class Photo extends StatelessWidget {
  final String url;

  const Photo({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ));
  }
}

class GalleryPage extends StatelessWidget {
  final String title;
  final List<PhotoState> photoStates;
  final bool tagging;

  final Function toogleTagging;
  final Function onPhotoSelect;

  const GalleryPage({
    Key? key,
    required this.title,
    required this.tagging,
    required this.photoStates,
    required this.toogleTagging,
    required this.onPhotoSelect,
  }) : super(key: key);

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
