byte(int n) {
  int r;
  if (n < -128 || n > 127) {
    List<String> nStrArr = n.toRadixString(2).split('');
    int nccNum = ~n;
    if (nStrArr[0] == '1') {
      r = -1 - nccNum;
    } else {
      r = nccNum + 1;
    }
    return r;
  } else {
    return n;
  }
}

phiTsToKey(int ts) {
  List<int> arrayOfByte = [];
  int arrayOfInt = 0;
  for (int index = 0; index < 8; index++) {
    int j = byte(0xff & ts);
    ts = ts >> 8;
    arrayOfByte.add(byte(j ^ 0x3c));
  }
  for (var i = 0; i < 4; i++) {
    int num = (arrayOfByte[7 - i] & 0xff) << ((arrayOfByte[i] & 0xff) + 8) % 32;
    double dNum = num / 2147483648;
    num = num - (dNum.floor() / 2).round() * 2147483648 * 2;

    arrayOfInt = arrayOfInt + num;
    if (2147483647 < arrayOfInt) {
      arrayOfInt = arrayOfInt - 2147483648 * 2;
    } else if (arrayOfInt < -2147483648) {
      arrayOfInt = arrayOfInt + 2147483648 * 2;
    }
  }
  return arrayOfInt.abs();
}
