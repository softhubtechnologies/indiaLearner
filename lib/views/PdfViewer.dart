import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PdfViewer extends StatefulWidget {
  String pdfDocument, flag;

  PdfViewer({this.pdfDocument, this.flag});

  PdfViewerState createState() => PdfViewerState(document: pdfDocument, flag: flag);
}

class PdfViewerState extends State<PdfViewer> {
  bool isLoading = false;
  String document, flag;
  PDFDocument pdfDocument;
  PDFDocument doc;

  PdfViewerState({this.document, this.flag});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Notes', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        child: Container(
            height: Get.size.height,
            width: Get.size.width,
            child: isLoading == true
                ? PDFViewer(document: pdfDocument)
                : Container(
                    height: 80,
                    width: 80,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      ),
    );
  }

  void getDocument() async {
    if (flag != "online") {
      File file = File(document);
      pdfDocument = await PDFDocument.fromFile(file);
    } else {
      print("DDDOC ${document}");
      pdfDocument = await PDFDocument.fromURL(document);
      setState(() {});
    }
    setState(() {
      isLoading = true;
    });
  }
}
