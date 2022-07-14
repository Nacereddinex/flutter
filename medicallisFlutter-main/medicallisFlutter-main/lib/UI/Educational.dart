import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// ignore: unused_import
import 'dart:developer';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'barcode.dart';

//import 'details.dart';
class EducationalContent extends StatefulWidget {
  const EducationalContent({Key? key}) : super(key: key);

  @override
  State<EducationalContent> createState() => _EducationalContentState();
}

class _EducationalContentState extends State<EducationalContent> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";
  String? c = '';

  @override
  Widget build(BuildContext context) {
    void getRecognizedText(XFile image) async {
      // showDialog(
      //   builder: (context) => const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      //   context: context,
      // );
      final inputImage = InputImage.fromFilePath(image.path);
      final textDetector = GoogleMlKit.vision.textRecognizer();
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      await textDetector.close();
      scannedText = "";
      for (TextBlock block in recognisedText.blocks) {
        for (TextLine line in block.lines) {
          scannedText = "$scannedText${line.text}\n";
        }
      }
      textScanning = false;
      setState(() {});
    }

    void getImage(ImageSource source) async {
      try {
        final pickedImage = await ImagePicker().pickImage(source: source);
        if (pickedImage != null) {
          textScanning = true;
          imageFile = pickedImage;
          setState(() {});
          getRecognizedText(pickedImage);
        }
      } catch (e) {
        textScanning = false;
        imageFile = null;
        scannedText = "Error while Scanning";
        setState(() {});
      }
    }

    findRegularExpressions(scannedText) async {
      RegExp exp = RegExp(r'(durchstreichen\))(\r\n|\r|\n)([äa-zA-Z0-9 \.]*)');

      Iterable<RegExpMatch>? matches = exp.allMatches(scannedText);

      //var defineRegexMethod = RegExp(r'[durchstreichen)](.*)');
      //var findMatches = defineRegexMethod.firstMatch(scannedText);
      //if (matches == null) {
      //  return 0;
      //}

      //log('test test');
      //log(matches[0].toString());

      setState(() {
        c = matches.first.group(3).toString();
      });
    }

    String str =
        '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';
    Uint8List bytes = base64Decode(str);

    Widget showCurrentWidget() {
      if (textScanning) {
        return const CircularProgressIndicator();
      }

      if (imageFile == null) {
        return Container(
          width: 700,
          height: 450,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(image: DecorationImage(image: MemoryImage(bytes))),
        );
      }

      if (imageFile != null && scannedText.isEmpty) {
        return Container(
          width: 700,
          height: 450,
          alignment: Alignment.center,
          child: const Text(
            'Image without Text',
            style: TextStyle(fontSize: 20),
          ),
        );
      } else {
        findRegularExpressions(scannedText);

        return SizedBox(
            width: 650,
            height: 450,
            child: SingleChildScrollView(
              //child: Text(scannedText),
              child: Text(c.toString()),
            )
            // getFromScannedText(scannedText);
            );

        //FittedBox(fit: BoxFit.fitHeight, child: Text(scannedText));
        // Navigator.of(context).pop();
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Details(scannedText)));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Medicallis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showCurrentWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: SizedBox(
                  width: 150,
                  height: 100,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.insert_photo_outlined),
                    label: const Text('Gallery'),
                  ),
                )),
                Expanded(
                    child: SizedBox(
                        width: 150,
                        height: 100,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                        ))),
                Expanded(
                    child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ScanBarcode())),
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                  label: const Text('Barcode Scanner'),
                ))
              ], //Children
            ),
          ],
        ),
      ),
    );
  }
}
