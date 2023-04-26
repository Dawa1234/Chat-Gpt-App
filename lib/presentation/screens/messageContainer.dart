import 'package:chatgpt/data/models/response.dart';
import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required this.responseModel,
  });
  final ResponseModel? responseModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: responseModel != null
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: responseModel!.choices!.length,
                  itemBuilder: (context, index) {
                    String message =
                        responseModel!.choices![index].message!.content!;
                    return Text(
                      message,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 54, 68, 80),
                        fontSize: 18,
                        wordSpacing: 15,
                      ),
                    );
                  },
                )
              : const Text("Ask any questions to AI"),
        ),
      ),
    );
  }
}
