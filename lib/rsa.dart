import 'dart:math';

class RSA {
  static Set<int> prime = {};
  static int? publicKey;
  static int? privateKey;
  static int? n;
  static Random random = Random();

  // Function to fill the prime set with prime numbers up to 250
  static void primeFiller() {
    List<bool> sieve = List.filled(250, true);
    sieve[0] = false;
    sieve[1] = false;

    for (int i = 2; i < 250; i++) {
      for (int j = i * 2; j < 250; j += i) {
        sieve[j] = false;
      }
    }

    for (int i = 0; i < sieve.length; i++) {
      if (sieve[i]) {
        prime.add(i);
      }
    }
  }

  // Function to pick a random prime from the set of primes
  static int pickRandomPrime() {
    int k = random.nextInt(prime.length);
    List<int> primeList = prime.toList();
    int ret = primeList[k];
    prime.remove(ret);
    return ret;
  }

  // Function to set the public and private keys
  static void setKeys() {
    int prime1 = pickRandomPrime();
    int prime2 = pickRandomPrime();

    n = prime1 * prime2;
    int fi = (prime1 - 1) * (prime2 - 1);

    int e = 2;
    while (true) {
      if (gcd(e, fi) == 1) {
        break;
      }
      e += 1;
    }

    publicKey = e;

    int d = 2;
    while (true) {
      if ((d * e) % fi == 1) {
        break;
      }
      d += 1;
    }

    privateKey = d;
  }

  // Function to encrypt a message (using public key)
  static int encrypt(int message) {
    int e = publicKey!;
    int encryptedText = 1;
    while (e > 0) {
      encryptedText *= message;
      encryptedText %= n!;
      e -= 1;
    }
    return encryptedText;
  }

  // Function to decrypt a message (using private key)
  static int decrypt(int encryptedText) {
    int d = privateKey!;
    int decrypted = 1;
    while (d > 0) {
      decrypted *= encryptedText;
      decrypted %= n!;
      d -= 1;
    }
    return decrypted;
  }

  // Function to calculate the GCD (Greatest Common Divisor)
  static int gcd(int a, int b) {
    if (b == 0) {
      return a;
    }
    return gcd(b, a % b);
  }

  // Function to encode (encrypt) a string message
  static List<int> encoder(String message) {
    List<int> encoded = [];
    for (int i = 0; i < message.length; i++) {
      encoded.add(encrypt(message.codeUnitAt(i))); // Convert char to ASCII
    }
    return encoded;
  }

  // Function to decode (decrypt) the encrypted message
  static String decoder(List<int> encoded) {
    StringBuffer s = StringBuffer();
    for (int num in encoded) {
      s.writeCharCode(decrypt(num)); // Convert decrypted ASCII to char
    }
    return s.toString();
  }
}


































