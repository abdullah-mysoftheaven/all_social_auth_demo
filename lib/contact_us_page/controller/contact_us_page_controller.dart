import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../encryption_data.dart';
import '../../rsa.dart';

class ContactUsScreenPageController extends GetxController {
  var showImage = false.obs;


  var userName="".obs;
  var userInfo="".obs;

  @override
  void onInit() {
    super.onInit();
  }



  // 9836308647138061308610811459313534173128511285147134302


  rsaencryptionAndDecryption(){
// Initialize the primes and keys
    RSA.primeFiller();
    RSA.setKeys();

    String message = "I am Abdullah";  // Message to encrypt
    print("Initial message:");
    print(message);

    // Encode (encrypt) the message
    List<int> encodedMessage = RSA.encoder(message);

    print("\n\nThe encoded message (encrypted by public key):");
    print(encodedMessage.join(''));

    // Decode (decrypt) the message


    String decodedMessage = RSA.decoder(encodedMessage);

    print("\n\nThe decoded message (decrypted by private key):");
    print(decodedMessage);
  }

  rsaencryptionAndDecryption22(){

    // Initialize the primes and keys
    RSA.primeFiller();
    RSA.setKeys();

    // The encrypted string from the user
    String encryptedCode = "6118472456924548472461787431635168591073107356926735";
    print("Encrypted code:");
    print(encryptedCode);

    // Decrypt the encrypted code (each digit in the string)
    String decryptedCode = '';
    for (int i = 0; i < encryptedCode.length; i++) {
      int digit = int.parse(encryptedCode[i]); // Convert each char to int
      decryptedCode += RSA.decrypt(digit).toString(); // Decrypt each digit
    }

    print("\nDecrypted code:");
    print(decryptedCode);  // The decrypted result should be the original string

  }

  sha256encryptionAndDecryption(){
    SHA256 sha256 = SHA256();

    // String input = "ABCDEFGH"; // Example input (up to 8 characters)
    String input = "y"; // Example input (up to 8 characters)
    String hash = sha256.hash(input);

    print("Input: $input");
    print("SHA256 Hash: $hash");


  }







}



// void main() {
//   SHA256 sha256 = SHA256();
//   String input = "ABCDEFGH"; // Example input (up to 8 characters)
//   String hash = sha256.hash(input);
//   print("Input: $input");
//   print("SHA256 Hash: $hash");
// }
