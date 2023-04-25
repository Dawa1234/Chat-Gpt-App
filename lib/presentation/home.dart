import 'dart:convert';
import 'dart:developer';

import 'package:chatgpt/data/models/response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = "/getData";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;
  ResponseModel? responseModel;
  final _textContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    log("Build UI");
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 173, 173, 173),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("C H A T  G P T"),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/images/chat_gpt.png",
                            ))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      controller: _textContoller,
                      validator: (value) {
                        if (value == null) {
                          return "*Required*";
                        }
                        if (value.isEmpty) {
                          return "*Required*";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 62, 62, 62),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 139, 67, 62))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 185, 79, 71))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.grey))),
                    ),
                  ),
                  Center(
                    child: MaterialButton(
                      color: const Color.fromARGB(255, 69, 157, 115),
                      textColor: Colors.white,
                      disabledColor: const Color.fromARGB(255, 106, 132, 120),
                      onPressed: _loading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _loading = true;
                                });
                                const String token =
                                    "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";
                                const String url =
                                    'https://api.openai.com/v1/chat/completions';

                                try {
                                  final response = await http.post(
                                    Uri.parse(url),
                                    headers: <String, String>{
                                      'Content-Type': 'application/json',
                                      'Authorization': 'Bearer $token',
                                    },
                                    body: jsonEncode({
                                      "model": "gpt-3.5-turbo-0301",
                                      "messages": [
                                        {
                                          "role": "user",
                                          "content": _textContoller.text
                                        }
                                      ]
                                    }),
                                  );

                                  if (response.statusCode == 200) {
                                    setState(() {
                                      _loading = false;
                                    });
                                    // since body response is in String so decode to json
                                    var data = jsonDecode(response.body);
                                    // then convert to dart object
                                    responseModel =
                                        ResponseModel.fromJson(data);
                                  }
                                } catch (e) {
                                  log("Error: $e");
                                }
                              }
                            },
                      child: const Text("Search"),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon(Icons),
                          _loading
                              ? const CircularProgressIndicator(
                                  color: Colors.black54,
                                )
                              : responseModel != null
                                  ? Expanded(
                                      child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: responseModel!.choices!.length,
                                      itemBuilder: (context, index) {
                                        String message = responseModel!
                                            .choices![index].message!.content!;
                                        return Text(
                                          message,
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 54, 68, 80),
                                            fontSize: 18,
                                            wordSpacing: 15,
                                          ),
                                        );
                                      },
                                    ))
                                  : const Text("Ask any questions to AI"),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "C H A T  G P T   M O B I L E",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.transparent,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationColor:
                                    Color.fromARGB(137, 77, 77, 77),
                                shadows: [
                                  Shadow(
                                      offset: Offset(0, -10),
                                      color: Color.fromARGB(137, 67, 67, 67))
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}