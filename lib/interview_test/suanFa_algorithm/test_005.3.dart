/*
LCR 076. 数组中的第 K 个最大元素

给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。

请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。



示例 1:

输入: [3,2,1,5,6,4] 和 k = 2
输出: 5
示例 2:

输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
输出: 4


提示：

1 <= k <= nums.length <= 104
-104 <= nums[i] <= 104
 */

/*
题解：

前言

约定：假设这里数组的长度为 nnn。

题目分析：本题希望我们返回数组排序之后的倒数第 kkk 个位置。

方法一：基于快速排序的选择方法

思路和算法

我们可以用快速排序来解决这个问题，先对原数组排序，再返回倒数第 kkk 个位置，这样平均时间复杂度是 O(nlog⁡n)O(n \log n)O(nlogn)，但其实我们可以做的更快。

首先我们来回顾一下快速排序，这是一个典型的分治算法。我们对数组 a[l⋯r]a[l \cdots r]a[l⋯r] 做快速排序的过程是（参考《算法导论》）：

分解： 将数组 a[l⋯r]a[l \cdots r]a[l⋯r] 「划分」成两个子数组 a[l⋯q−1]a[l \cdots q - 1]a[l⋯q−1]、a[q+1⋯r]a[q + 1 \cdots r]a[q+1⋯r]，使得 a[l⋯q−1]a[l \cdots q - 1]a[l⋯q−1] 中的每个元素小于等于 a[q]a[q]a[q]，且 a[q]a[q]a[q] 小于等于 a[q+1⋯r]a[q + 1 \cdots r]a[q+1⋯r] 中的每个元素。其中，计算下标 qqq 也是「划分」过程的一部分。
解决： 通过递归调用快速排序，对子数组 a[l⋯q−1]a[l \cdots q - 1]a[l⋯q−1] 和 a[q+1⋯r]a[q + 1 \cdots r]a[q+1⋯r] 进行排序。
合并： 因为子数组都是原址排序的，所以不需要进行合并操作，a[l⋯r]a[l \cdots r]a[l⋯r] 已经有序。
上文中提到的 「划分」 过程是：从子数组 a[l⋯r]a[l \cdots r]a[l⋯r] 中选择任意一个元素 xxx 作为主元，调整子数组的元素使得左边的元素都小于等于它，右边的元素都大于等于它， xxx 的最终位置就是 qqq。
由此可以发现每次经过「划分」操作后，我们一定可以确定一个元素的最终位置，即 xxx 的最终位置为 qqq，并且保证 a[l⋯q−1]a[l \cdots q - 1]a[l⋯q−1] 中的每个元素小于等于 a[q]a[q]a[q]，且 a[q]a[q]a[q] 小于等于 a[q+1⋯r]a[q + 1 \cdots r]a[q+1⋯r] 中的每个元素。所以只要某次划分的 qqq 为倒数第 kkk 个下标的时候，我们就已经找到了答案。 我们只关心这一点，至于 a[l⋯q−1]a[l \cdots q - 1]a[l⋯q−1] 和 a[q+1⋯r]a[q+1 \cdots r]a[q+1⋯r] 是否是有序的，我们不关心。

因此我们可以改进快速排序算法来解决这个问题：在分解的过程当中，我们会对子数组进行划分，如果划分得到的 qqq 正好就是我们需要的下标，就直接返回 a[q]a[q]a[q]；否则，如果 qqq 比目标下标小，就递归右子区间，否则递归左子区间。这样就可以把原来递归两个区间变成只递归一个区间，提高了时间效率。这就是「快速选择」算法。

我们知道快速排序的性能和「划分」出的子数组的长度密切相关。直观地理解如果每次规模为 nnn 的问题我们都划分成 111 和 n−1n - 1n−1，每次递归的时候又向 n−1n - 1n−1 的集合中递归，这种情况是最坏的，时间代价是 O(n2)O(n ^ 2)O(n
2
 )。我们可以引入随机化来加速这个过程，它的时间代价的期望是 O(n)O(n)O(n)，证明过程可以参考「《算法导论》9.2：期望为线性的选择算法」。

作者：力扣官方题解
链接：https://leetcode.cn/problems/xx4gT2/solutions/1398893/shu-zu-zhong-de-di-k-da-de-shu-zi-by-lee-6doi/
 */
import 'dart:core';
import 'dart:math';

int findKthLargest(List<int> nums, int k) {
  return quickSelect(nums, 0, nums.length - 1, nums.length - k);
}

int quickSelect(List<int> a, int l, int r, int index) {
  int q = partition(a, l, r);
  if (q == index) {
    return a[q];
  } else {

    if(q < index){
      return quickSelect(a, q + 1, r, index);
    } else {
      return quickSelect(a, l, q - 1, index);
    }
  }
}

int partition(List<int> a, int l, int r) {
  int x = a[r], i = l - 1;
  for (int j = l; j < r; ++j) {
    print('j == $j; i == $i; a[j] == ${a[j]}');
    if (a[j] <= x) {
      i++;
      swap(a, i, j);
    }
    print('list == $a');
  }
  swap(a, i + 1, r);
  print('list1 == $a');
  return i + 1;
}

void swap(List<int> a, int i, int j) {
  int temp = a[i];
  a[i] = a[j];
  a[j] = temp;
}

void main(){
  final nums = [3,2,1,5,6,4,9];
  int k = 2;
  int kValue = findKthLargest(nums, k);
  print('kValue == $kValue');
}
