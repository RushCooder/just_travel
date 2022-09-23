import 'package:flutter/material.dart';

import '../../../../utils/constants/urls.dart';

class CoverPhoto extends StatelessWidget {
  final String imagePath;
  const CoverPhoto({required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Image.network(
          '${baseUrl}uploads/$imagePath',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: 300,
        ),
      ),
    );
  }
}
