import 'package:flutter/material.dart';

class GptImage extends StatelessWidget {
  const GptImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/chat_gpt.png",
              ))),
    );
  }
}
