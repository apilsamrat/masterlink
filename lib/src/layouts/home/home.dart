import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masterlink/src/globalcomponents/dialog.dart';
import 'package:masterlink/src/globalcomponents/textformfield.dart';
import 'package:masterlink/src/network/network_file.dart';
import 'package:masterlink/utilities/colors.dart';
import 'package:masterlink/utilities/copy_to_clipboard.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

String? shortnedUrl;
bool isLoading = false;

class HomePageState extends State<HomePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<AnimatedWidgetBaseState> containerKey =
      GlobalKey<AnimatedWidgetBaseState>();

  String alias = "";
  TextEditingController urlEditingController = TextEditingController();
  TextEditingController aliasEditingController = TextEditingController();

  RegExp aliasExp = RegExp(r'([a-z,A-Z,0-9])');

  bool customURL = false;
  bool showCustomAlias = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final res = await showAlertDialog(
            context: context,
            title: "Hey You, Yes You!",
            content: const Text("Are you handsome?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Yes"),
              ),
            ]);
        if (!res) {
          SystemNavigator.pop(animated: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Master Link"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    customURL = !customURL;
                  });
                },
                icon: Row(
                  children: [
                    Text(
                      "${customURL ? "Custom" : "Random"} URL",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    CupertinoSwitch(
                        value: customURL,
                        onChanged: (value) {
                          setState(() {
                            customURL = value;
                          });
                        }),
                  ],
                )),
          ],
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: customURL ? 350 : 220,
                      alignment: Alignment.center,
                      curve: Curves.bounceOut,
                      key: containerKey,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Master Link",
                                  style: GoogleFonts.vt323(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34,
                                      color: kPrimaryColor)),
                              Text(
                                "Shorten your long URLs with no hassle",
                                style: GoogleFonts.urbanist(
                                    fontSize: 14, color: kPrimaryColor),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: urlEditingController,
                                labelText: "Long URL",
                                errorText: "Input an URL here",
                                suffix: IconButton(
                                  onPressed: () async {
                                    final res = await Clipboard.getData(
                                        Clipboard.kTextPlain);
                                    urlEditingController.text = res?.text ?? "";
                                  },
                                  icon: const Icon(Icons.paste),
                                  tooltip: "Paste from clipboard",
                                ),
                              ),
                              Visibility(
                                visible: customURL,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    CustomTextField(
                                      controller: aliasEditingController,
                                      maxLength: 10,
                                      labelText: "Input short alias here.",
                                      errorText: "Input an short alias here",
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z0-9]'))
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          alias = value!;
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(aliasEditingController
                                                .value.text.isEmpty
                                            ? ""
                                            : "Your short url will be:\nhttps://ishortn.ink/${aliasEditingController.text}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Your shortned link will appear here:",
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: shortnedUrl != null
                                    ? TextButton(
                                        onPressed: () async {
                                          copyToClipBoard(
                                              data: shortnedUrl,
                                              context: context);
                                        },
                                        child: Text(
                                          shortnedUrl ?? "",
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                      )
                                    : null),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(kPrimaryColor),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  copyToClipBoard(
                                      data: shortnedUrl, context: context);
                                },
                                child: const Text(
                                  "Copy Link",
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    RippleAnimation(
                      minRadius: 100,
                      repeat: true,
                      color: Colors.white,
                      child: MaterialButton(
                          minWidth: 150,
                          height: 150,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          textColor: kPrimaryColor,
                          onPressed: () async {
                            if (isLoading) {
                              return;
                            }
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              final response = await Network().shortURL(
                                  longURL:
                                      Uri.encodeFull(urlEditingController.text)
                                          .toString(),
                                  customURL: customURL,
                                  alias: aliasEditingController.text);
                              setState(() {
                                isLoading = false;
                              });

                              if (response.statusCode == 201) {
                                setState(() {
                                  final result = jsonDecode(response.body);

                                  shortnedUrl = result["shortLink"];
                                });
                              } else {
                                EasyLoading.showError(response.body);
                              }
                            }
                          },
                          child: isLoading
                              ? const CupertinoActivityIndicator()
                              : Text(
                                  "Short",
                                  style: GoogleFonts.vt323(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34),
                                )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
