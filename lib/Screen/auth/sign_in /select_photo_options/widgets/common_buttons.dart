
import 'dart:io';

import 'package:flutter/material.dart';

class CommonButtons extends StatelessWidget {
  const CommonButtons({
    Key? key,
    required this.onTap,
    required this.imageFile,
  }) : super(key: key);

  final File? imageFile;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 6,
          ),
          child: Container(
            width: size.width * 0.24,
            height: size.width * 0.24,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageFile == null
                  ? Image.network(
                'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                fit: BoxFit.fill,
              )
                  : Image.file(
                imageFile!,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        );
  }
}
