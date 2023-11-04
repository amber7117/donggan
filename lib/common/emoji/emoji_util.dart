class EmojiUtil {

  static List<String> obtainEmojiArr() {
    List<String> emojiArr = [];
    for (int i = 0x1F600; i <= 0x1F64F; i++) {
      String emoji = String.fromCharCode(i);
      emojiArr.add(emoji);
    }
    return emojiArr;
  }

  static List<List<String>> obtainEmojiArr2() {
    List<List<String>> arr2 = [];
    
    List<String> emojiArr = EmojiUtil.obtainEmojiArr();

    List<String> arr1 = [];

    for (int idx = 0; idx < emojiArr.length; idx++) {
      String emoji = emojiArr[idx];

      if (idx == 0) {
        arr1.add(emoji);
      } else if ((idx + 1) % 50 == 0) {
        arr1.add("iconDelete");
        arr2.add(arr1);

        arr1 = [];
        arr1.add(emoji);
      } else {
        arr1.add(emoji);
      }
    }

    arr2.add(arr1);

    return arr2;
  }

}
