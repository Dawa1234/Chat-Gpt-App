// TODO Implement this library.
import 'dart:developer';

import 'package:chatgpt/logic/bloc/bloc/response_model_bloc.dart';
import 'package:chatgpt/logic/bloc_exports.dart';
import 'package:chatgpt/logic/cubit/loading/loading_cubit.dart';
import 'package:chatgpt/presentation/gaps.dart';
import 'package:chatgpt/presentation/screens/gptImage.dart';
import 'package:chatgpt/presentation/screens/messageContainer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = "/getData";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future _getGptResponse() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoadingCubit>(context).isLoading();
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
                  BlocConsumer<LoadingCubit, LoadingState>(
                    listener: (context, loadingState) {
                      if (loadingState.isLoading) {
                        // getting the data
                        BlocProvider.of<ResponseModelBloc>(context)
                            .add(GettingResponseEvent());
                        // when succefully fetch data
                        BlocProvider.of<ResponseModelBloc>(context).add(
                            SuccessResponse(userInput: _textContoller.text));
                      }
                    },
                    builder: (context, loadingState) {
                      return BlocListener<ResponseModelBloc,
                          ResponseModelState>(
                        listener: (context, state) {
                          if (state.responseModel != null) {
                            BlocProvider.of<LoadingCubit>(context).notLoading();
                          }
                        },
                        child: loadingState.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : BlocBuilder<ResponseModelBloc,
                                ResponseModelState>(
                                builder: (context, state) {
                                  return MessageContainer(
                                      responseModel: state.responseModel);
                                },
                              ),
                      );
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
