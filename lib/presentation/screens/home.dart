// TODO Implement this library.
import 'dart:developer';

import 'package:chatgpt/data/models/response.dart';
import 'package:chatgpt/data/repository/gptRepo.dart';
import 'package:chatgpt/logic/bloc_exports.dart';
import 'package:chatgpt/logic/cubit/loading/loading_cubit.dart';
import 'package:chatgpt/presentation/gaps.dart';
import 'package:chatgpt/presentation/screens/gptImage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = "/getData";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ResponseModel? responseModel;
  final _textContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _getGptResponse() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoadingCubit>(context).isLoading();
      try {
        await GptRepository().getResponse(_textContoller.text).then((value) {
          if (value != null) {
            responseModel = value;
            BlocProvider.of<LoadingCubit>(context).notLoading();
            return;
          }
        });
      } catch (e) {
        log("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Build UI");
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("C H A T  G P T"),
                  gapVertical20,
                  // image
                  const GptImage(),
                  gapVertical20,
                  // textformfiled
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
                    ),
                  ),
                  // search button
                  BlocBuilder<LoadingCubit, LoadingState>(
                    builder: (context, state) {
                      return Center(
                        child: MaterialButton(
                          color: const Color.fromARGB(255, 69, 157, 115),
                          textColor: Colors.white,
                          disabledColor:
                              const Color.fromARGB(255, 106, 132, 120),
                          onPressed:
                              state.isLoading ? null : () => _getGptResponse(),
                          child: const Text("Search"),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<LoadingCubit, LoadingState>(
                    builder: (context, state) {
                      return MessageContainer(
                          loading: state.isLoading,
                          responseModel: responseModel);
                    },
                  ),
                  gapVertical10,
                  // Bottom Text
                  const Text(
                    "C H A T  G P T   M O B I L E",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Color.fromARGB(137, 77, 77, 77),
                        shadows: [
                          Shadow(
                              offset: Offset(0, -10),
                              color: Color.fromARGB(137, 67, 67, 67))
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required bool loading,
    required this.responseModel,
  }) : _loading = loading;

  final bool _loading;
  final ResponseModel? responseModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _loading
              ? const CircularProgressIndicator(
                  color: Colors.black54,
                )
              : responseModel != null
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