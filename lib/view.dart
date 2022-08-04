import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class View extends StatelessWidget {
  final  url;
  PdfViewerController? _pdfViewerController;

  View({this.url});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resume'),

        ),
        body: SfPdfViewer.network(
          url,
          controller: _pdfViewerController,
        ),
    );
  }
}

