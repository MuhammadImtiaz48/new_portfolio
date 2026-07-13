import 'dart:html' as html;

void downloadFile(String url, String fileName) {
  final html.AnchorElement anchorElement = html.AnchorElement(href: url);
  anchorElement.download = fileName;
  anchorElement.click();
}
