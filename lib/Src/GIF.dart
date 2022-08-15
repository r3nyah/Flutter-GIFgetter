import 'package:flutter/material.dart';

class GifCard extends StatelessWidget {
  final String gifUrl;

  const GifCard(this.gifUrl,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.fill,
      image: NetworkImage(gifUrl),
    );
  }
}
