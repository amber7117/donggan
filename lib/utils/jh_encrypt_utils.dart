
///引用插件
import 'package:encrypt/encrypt.dart';
import 'package:wzty/app/app.dart';

///定义秘钥
const aesKEY = "8930ba380e7fdadf";
///定义偏移量
const aesIV = "510cf0fcbdc4d20f";

//128的keysize=16，192keysize=24，256keysize=32

class JhEncryptUtils {
//  //Base64编码
//  static String encodeBase64(String data) {
//    return base64Encode(utf8.encode(data));
//  }

//  //Base64解码
//  static String decodeBase64(String data) {
//    return String.fromCharCodes(base64Decode(data));
//  }

//  // md5 加密 32位小写
//  static String encodeMd5(String plainText) {
//    return EncryptUtil.encodeMd5(plainText);
//  }

 //AES加密
 static aesEncrypt(plainText) {
   try {
     final key = Key.fromUtf8(aesKEY);
     final iv = IV.fromUtf8(aesIV);
     /// 这里可以配置类型，
     final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
     final encrypted = encrypter.encrypt(plainText, iv: iv);
     return encrypted.base16;
   } catch (err) {
     logger.i("aes encode error:$err");
     return plainText;
   }
 }

 //AES解密
 static dynamic aesDecrypt(encrypted) {
   try {
     final key = Key.fromUtf8(aesKEY);
     final iv = IV.fromUtf8(aesIV);
     final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
     final decrypted = encrypter.decrypt64(encrypted, iv: iv);
     return decrypted;
   } catch (err) {
     logger.i("aes decode error:$err");
     return encrypted;
   }
 }
}