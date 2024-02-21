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
  _testTwoSum();
}
