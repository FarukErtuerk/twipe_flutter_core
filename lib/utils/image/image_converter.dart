import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
/// ImageConverter Class for converting Images into Base64 and back
/// You can use this Class, if want to save an image or upload to a server
class ImageConverter {
  ///Encode Image To Base64 String
  static Future<String> encodeImage(File image) async {
    final bytes = await image.readAsBytes();
    return base64.encode(bytes);
  }

  ///Decode Image from Base64 String
  static Uint8List decodeImage(String base64String) {
    final Uint8List list = base64.decode(base64String);
    return list;
  }
}
