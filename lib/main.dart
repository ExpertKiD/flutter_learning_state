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
  final PhotoState photoState;
  final bool selectable;

  final Function onLongPress;
  final Function onSelect;

  const Photo({
    required this.photoState,
    required this.selectable,
    required this.onLongPress,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      GestureDetector(
        child: Image.network((photoState.url)),
        onLongPress: () => onLongPress(photoState.url),
      )
    ];

    if (selectable) {
      children.add(Positioned(
          left: 20,
          top: 0,
          child: Theme(
            data: Theme.of(context)
                .copyWith(unselectedWidgetColor: Colors.grey.shade200),
            child: Checkbox(
              onChanged: (value) {
                onSelect(photoState.url, value);
              },
              value: photoState.selected,
              activeColor: Colors.white,
              checkColor: Colors.white,
            ),
          )));
    }

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.center,
        children: children,
      ),
    );
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
        children: List.of(photoStates.map((photoState) => Photo(
              photoState: photoState,
              onSelect: onPhotoSelect,
              onLongPress: toogleTagging,
              selectable: tagging,
            ))),
      ),
    );
  }
}
