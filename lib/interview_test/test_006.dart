/*

The Problem:
Given an array of nums, write a function to move all 0’s to the end of it
while maintaining the relative order of the non-zero elements.

Example:
Input: [0,1,0,3,12]
Output: [1,3,12,0,0]

 */

List<int> moveZero(List<int> list) {
  List<int> zeroList = [];
  List<int> noZeroList = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i] == 0) {
      zeroList.add(0);
    } else {
      noZeroList.add(list[i]);
    }
  }

  for (int i = 0; i < list.length; i++) {
    if (i < noZeroList.length) {
      list[i] = noZeroList[i];
    } else {
      list[i] = zeroList[i - noZeroList.length];
    }
  }
  return list;
}

void main() {
  final nums = [0, 1, 0, 3, 12];
  var list = moveZero(nums);
  print('list == $list');
}