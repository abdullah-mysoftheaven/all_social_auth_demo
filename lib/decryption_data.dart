import 'dart:typed_data';

class SHA256Decryption {
  // Initial hash values (h0 to h7)
  final List<int> _h = [
    0x6a09e667,
    0xbb67ae85,
    0x3c6ef372,
    0xa54ff53a,
    0x510e527f,
    0x9b05688c,
    0x1f83d9ab,
    0x5be0cd19
  ];

  // Constants (k0 to k63)
  final List<int> _k = [
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
  ];

  String hash(String input) {
    if (input.length > 8) {
      throw Exception("Input must be 8 characters or less!");
    }

    Uint8List messageBytes = Uint8List.fromList(input.codeUnits);

    // Step 1: Padding the message
    List<int> paddedMessage = _padMessage(messageBytes);

    // Step 2: Process each 512-bit chunk
    for (int i = 0; i < paddedMessage.length; i += 64) {
      List<int> chunk = paddedMessage.sublist(i, i + 64);
      _processChunk(chunk);
    }

    // Step 3: Combine final hash values
    return _h.map((value) => value.toRadixString(16).padLeft(8, '0')).join();
  }

  List<int> _padMessage(Uint8List message) {
    int originalLength = message.length * 8; // Length in bits
    List<int> padded = List.from(message)..add(0x80); // Add 1 bit

    // Pad with zeros until length is 448 mod 512
    while ((padded.length % 64) != 56) {
      padded.add(0x00);
    }

    // Append original length as a 64-bit big-endian integer
    for (int i = 0; i < 8; i++) {
      padded.add((originalLength >> ((7 - i) * 8)) & 0xFF);
    }

    return padded;
  }

  void _processChunk(List<int> chunk) {
    // Prepare the message schedule (w[0..63])
    List<int> w = List.filled(64, 0);

    for (int i = 0; i < 16; i++) {
      w[i] = (chunk[i * 4] << 24) |
      (chunk[i * 4 + 1] << 16) |
      (chunk[i * 4 + 2] << 8) |
      chunk[i * 4 + 3];
    }

    for (int i = 16; i < 64; i++) {
      w[i] = (_sigma1(w[i - 2]) + w[i - 7] + _sigma0(w[i - 15]) + w[i - 16]) & 0xFFFFFFFF;
    }

    // Initialize hash values for this chunk
    int a = _h[0], b = _h[1], c = _h[2], d = _h[3];
    int e = _h[4], f = _h[5], g = _h[6], h = _h[7];

    // Main loop
    for (int i = 0; i < 64; i++) {
      int t1 = (h + _bigSigma1(e) + _ch(e, f, g) + _k[i] + w[i]) & 0xFFFFFFFF;
      int t2 = (_bigSigma0(a) + _maj(a, b, c)) & 0xFFFFFFFF;
      h = g;
      g = f;
      f = e;
      e = (d + t1) & 0xFFFFFFFF;
      d = c;
      c = b;
      b = a;
      a = (t1 + t2) & 0xFFFFFFFF;
    }

    // Add this chunk's hash to result
    _h[0] = (_h[0] + a) & 0xFFFFFFFF;
    _h[1] = (_h[1] + b) & 0xFFFFFFFF;
    _h[2] = (_h[2] + c) & 0xFFFFFFFF;
    _h[3] = (_h[3] + d) & 0xFFFFFFFF;
    _h[4] = (_h[4] + e) & 0xFFFFFFFF;
    _h[5] = (_h[5] + f) & 0xFFFFFFFF;
    _h[6] = (_h[6] + g) & 0xFFFFFFFF;
    _h[7] = (_h[7] + h) & 0xFFFFFFFF;
  }

  // SHA256 Helper Functions
  int _ch(int x, int y, int z) => (x & y) ^ (~x & z);
  int _maj(int x, int y, int z) => (x & y) ^ (x & z) ^ (y & z);
  int _bigSigma0(int x) => _rotr(x, 2) ^ _rotr(x, 13) ^ _rotr(x, 22);
  int _bigSigma1(int x) => _rotr(x, 6) ^ _rotr(x, 11) ^ _rotr(x, 25);
  int _sigma0(int x) => _rotr(x, 7) ^ _rotr(x, 18) ^ (x >> 3);
  int _sigma1(int x) => _rotr(x, 17) ^ _rotr(x, 19) ^ (x >> 10);
  int _rotr(int x, int n) => (x >> n) | (x << (32 - n));
}