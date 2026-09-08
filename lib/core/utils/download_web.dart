// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

void downloadFile(String path, String fileName) {
  try {
    final anchor = html.AnchorElement(href: path)
      ..setAttribute('download', fileName)
      ..setAttribute('target', '_blank')
      ..style.display = 'none';

    html.document.body?.children.add(anchor);
    anchor.click();
    anchor.remove();
  } catch (e) {
    try {
      html.window.open(path, '_blank');
    } catch (_) {}
  }
}
