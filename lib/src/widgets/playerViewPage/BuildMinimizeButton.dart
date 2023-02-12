

import 'package:flutter/material.dart';

class BuildMinimizeButton extends StatelessWidget {
  const BuildMinimizeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new , weight: 40,));
  }
}
