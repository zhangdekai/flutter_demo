/*

ltCode: 136 https://leetcode.cn/problems/single-number/description/

只出现一次的数字

给你一个 非空 整数数组 nums ，除了某个元素只出现一次以外，其余每个元素均出现两次。
找出那个只出现了一次的元素。

你必须设计并实现线性时间复杂度的算法来解决此问题，且该算法只使用常量额外空间。


示例 1 ：

输入：nums = [2,2,1]
输出：1
示例 2 ：

输入：nums = [4,1,2,1,2]
输出：4
示例 3 ：

输入：nums = [1]
输出：1

提示：
1 <= nums.length <= 3 * 104
-3 * 104 <= nums[i] <= 3 * 104
除了某个元素只出现一次以外，其余每个元素均出现两次。

 */

import 'dart:collection';

/*
使用哈希表存储每个数字和该数字出现的次数。遍历数组即可得到每个数字出现的次数，
并更新哈希表，最后遍历哈希表，得到只出现一次的数字。
 */
// HashMap  O(n), O(n)
int singleNumber(List<int> nums) {
  HashMap<int, int> hashMap = HashMap<int, int>();
  for (int i = 0; i < nums.length; i++) {
    int temp = nums[i];
    /// hashMap 记录每个数字出现的次数
    if (hashMap.containsKey(temp)) {
      hashMap[temp] = hashMap[temp]! + 1;
    } else {
      hashMap[nums[i]] = 1;
    }
  }

  print('hashMap == $hashMap');

  var single = -1;
  hashMap.forEach((key, value) {
    if (value == 1) {
      // 找出出现一次的 Key
      single = key;
    }
  });
  return single;
}

/*
使用集合存储数字。遍历数组中的每个数字，如果集合中没有该数字，则将该数字加入集合，
如果集合中已经有该数字，则将该数字从集合中删除，最后剩下的数字就是只出现一次的数字。
 */

// List  数字最多出现2次  O(n),O(n)
int singleNumber1(List<int> nums) {
  List record = [];
  for (int i = 0; i < nums.length; i++) {
    int temp = nums[i];
    if (record.contains(temp)) {
      //包含就删除
      record.remove(temp);
    } else {
      record.add(temp);
    }
  }

  print('record == $record');
  return record.isNotEmpty ? record.first : -1;
}

// 根据输入List 规律； 使用加减法； 2* sum(非重复) - list sum
int singleNumber2(List<int> nums) {
  List record = [];
  for (int i = 0; i < nums.length; i++) {
    int temp = nums[i];
    if (!record.contains(temp)) {
      record.add(temp); // 记录 非重复数字
    }
  }

  /// 计算 非重复数字 Record sum * 2
  int sum = record.reduce((value, element) => value + element) * 2;

  int listSum = nums.reduce((value, element) => value + element);

  return sum - listSum;
}

/*
1: 任何数和 000 做异或运算，结果仍然是原来的数，即 a⊕0=a。
2: 任何数和其自身做异或运算，结果是 0，即 a⊕a=0 。
3: 异或运算满足交换律和结合律，即 a⊕b⊕a=b⊕a⊕a=b⊕(a⊕a)=b⊕0=b。

 */

/// 异或运算， 交换律+结合律
int singleNumber3(List<int> nums) {
  int single = 0;
  for (int i = 0; i < nums.length; i++) {
    single = single ^ nums[i];
  }
  return single;
}

void main() {
  final nums = [4, 4, 1, 1, 3, 3, 2];
  // final nums = [1];

  var num = singleNumber(nums);
  print('singleNumber == $num');

  var num1 = singleNumber1(nums);
  print('singleNumber == $num1');

  var num2 = singleNumber2(nums);
  print('singleNumber == $num2');

  var num3 = singleNumber3(nums);
  print('singleNumber == $num3');
}
