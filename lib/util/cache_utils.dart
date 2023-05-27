import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheUtils {
  ///下载目录
  static Future<String> getDownloadPath(String name) async {
    Directory tempDir = await getTemporaryDirectory();
    return "${tempDir.path}${Platform.pathSeparator}download${Platform.pathSeparator}$name";
  }

  ///分享图片目录
  static Future<String> getShareImagePath(String name) async {
    Directory tempDir = await getTemporaryDirectory();
    return "${tempDir.path}${Platform.pathSeparator}share${Platform.pathSeparator}$name";
  }

  ///缓存图片目录
  static Future<String> getCacheImagePath(String name) async {
    Directory tempDir = await getTemporaryDirectory();
    return "${tempDir.path}${Platform.pathSeparator}image${Platform.pathSeparator}$name";
  }

  ///录音目录
  static Future<String> getRecordVoicePath(String name) async {
    Directory tempDir = await getTemporaryDirectory();
    return "${tempDir.path}${Platform.pathSeparator}voice${Platform.pathSeparator}$name";
  }
}
