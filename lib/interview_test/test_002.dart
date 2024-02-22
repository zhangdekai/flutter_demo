import 'package:get/get.dart';

///1: 一个长度为n 的数组A，找出其中2个元素和为目标值的下标，使用dart 语言.
///  [11, 7, 15, 2, 8]  10  ==> 3, 4
List<int> twoSum(List<int> nums, int target) {
  Map<int, int> numMap = {}; // 创建哈希表，存储元素值及其索引
  for (int i = 0; i < nums.length; i++) {
    int complement = target - nums[i]; // 计算目标值与当前元素值的差值
    if (numMap.containsKey(complement)) {
      // 如果差值在哈希表中存在，则返回当前元素索引和差值对应的索引
      print('i == $i ; complement = $complement; numMap == $numMap');
      return [numMap[complement]!, i];
    }
    // 将当前元素值及其索引存入哈希表
    numMap[nums[i]] = i;
    print('i == $i ; complement = $complement; numMap == $numMap');
  }
  return []; // 如果没有找到符合条件的元素，返回空数组
}

void _testTwoSum() {
  List<int> nums = [11, 7, 15, 2, 8];
  int target = 10;
  List<int> result = twoSum(nums, target);
  if (result.isNotEmpty) {
    print("Indices: ${result[0]}, ${result[1]}");
  } else {
    print("No two sum solution");
  }
}

void main() {
  // _testTwoSum();
  _testNum();
}


///2: 给你一个数组 nums，其中nums 的整数都在[1,n]之间，
///且每个整数出现1次或2次，请找出所有出现2次的整数，并以数组的形式返回。
///设计一个时间复杂度为 O(n),切仅使用常量额外空间的算法解决此问题。
// 实例：nums = [4,3,2,7,8,2,3,1]   => [2,3]
///
///

void _testNum(){
  List<int> nums = [99,4, 3, 2, 7, 8, 2, 3, 1,1,8];
  List<int> result = findDuplicates(nums);
  print(result);
}

List<int> findDuplicates(List<int> nums) {
  List<int> result = [];
  List<int> tempA = [];
  // Set<int> setA = {};
  for (int m in nums) {
    if(tempA.contains(m)){
      tempA.add(m);
      result.add(m);
    } else {
      tempA.add(m);
    }
  }

  return result;
}