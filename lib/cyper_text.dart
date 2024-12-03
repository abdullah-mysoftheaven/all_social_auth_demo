// import 'dart:io';

class CyperText{


  int mulInverse(int a, int n) {
    for (int x = 1; x < n; x++) {
      if (((a % n) * (x % n)) % n == 1) {
        return x;
      }
    }
    throw Exception('Multiplicative Inverse of $a and $n does not exist.');
  }

  void affineCipher(String message, List<String> alphabet, int key1, int key2, int Zn) {
    print('==================== Affine Cipher ====================');
    print('Plain Text: ${message.toLowerCase()}');
    String cipherText = '';

    for (var char in message.toLowerCase().split('')) {
      if (char == ' ') {
        cipherText += char;
      } else {
        int encryptionValue = ((alphabet.indexOf(char) * key1 + key2) % Zn);
        String encryptedText = alphabet[encryptionValue].toUpperCase();
        print('$char:${alphabet.indexOf(char)} --> Encryption = $encryptedText');
        cipherText += encryptedText;
      }
    }

    print('Cipher Text: $cipherText');
    print('==================== Affine Cipher Ends ====================');
  }

  void substitutionCipher(String message, Map<String, String> substitutionKey) {
    print('==================== Substitution Cipher ====================');
    print('Plain Text: ${message.toLowerCase()}');
    print('Substitution Key: $substitutionKey');

    String cipherText = message.toLowerCase().split('').map((char) {
      return substitutionKey[char] ?? char;
    }).join('');

    print('Cipher Text: $cipherText');
    print('==================== Substitution Cipher Ends ====================');
  }

  void vigenereCipher(String message, String vigenereKey, List<String> alphabet, int Zn) {
    print('==================== Vigenère Cipher ====================');
    print('Plain Text: ${message.toLowerCase()}');

    List<int> vigenereValues = vigenereKey.toLowerCase().split('').map((char) => alphabet.indexOf(char)).toList();
    while (vigenereValues.length < message.length) {
      vigenereValues += vigenereValues.sublist(0, message.length - vigenereValues.length);
    }

    String cipherText = '';
    int index = 0;

    for (var char in message.toLowerCase().split('')) {
      if (char == ' ') {
        cipherText += char;
      } else {
        int encryptionValue = (alphabet.indexOf(char) + vigenereValues[index]) % Zn;
        String encryptedText = alphabet[encryptionValue].toUpperCase();
        print('$char:${alphabet.indexOf(char)} + ${vigenereValues[index]} --> $encryptedText');
        cipherText += encryptedText;
        index++;
      }
    }

    print('Cipher Text: $cipherText');
    print('==================== Vigenère Cipher Ends ====================');
  }

  void keylessTranspositionCipher(String message) {
    print('==================== Keyless Transposition Cipher ====================');
    print('Plain Text: ${message.toLowerCase()}');

    List<String> firstRow = [];
    List<String> secondRow = [];

    for (int i = 0; i < message.length; i++) {
      if (i % 2 == 0) {
        firstRow.add(message[i]);
      } else {
        secondRow.add(message[i]);
      }
    }

    String cipherText = firstRow.join() + secondRow.join();
    print('Cipher Text: $cipherText');
    print('==================== Keyless Transposition Cipher Ends ====================');
  }

  void mainFunction(String userInputMessage, String selectOption) {
    final alphabet = List.generate(26, (i) => String.fromCharCode(97 + i));
    final substitutionKey = {
      'a': 'C', 'b': 'X', 'c': 'Q', 'd': 'M', 'e': 'K', 'f': 'P', 'g': 'A',
      'h': 'L', 'i': 'O', 'j': 'Z', 'k': 'E', 'l': 'R', 'm': 'Y', 'n': 'N',
      'o': 'U', 'p': 'S', 'q': 'F', 'r': 'T', 's': 'G', 't': 'I', 'u': 'V',
      'v': 'W', 'w': 'B', 'x': 'D', 'y': 'J', 'z': 'H'
    };
    final reverseSubstitutionKey = {for (var k in substitutionKey.keys) substitutionKey[k]!: k};
    final vigenereKey = 'PASCAL';

    // print('Enter your message:');
    // String message = stdin.readLineSync() ?? '';

    print('Select a Cipher:');
    print('1. Affine Cipher');
    print('2. Substitution Cipher');
    print('3. Vigenère Cipher');
    print('4. Keyless Transposition Cipher');
    int choice = int.parse(selectOption ?? '0');

    switch (choice) {
      case 1:
        int key1 = 7, key2 = 2, Zn = 26;
        affineCipher(userInputMessage, alphabet, key1, key2, Zn);
        break;
      case 2:
        substitutionCipher(userInputMessage, substitutionKey);
        break;
      case 3:
        vigenereCipher(userInputMessage, vigenereKey, alphabet, 26);
        break;
      case 4:
        keylessTranspositionCipher(userInputMessage);
        break;
      default:
        print('Invalid Choice!');
    }
  }


}

