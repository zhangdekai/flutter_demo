/*

最下边有 快速排序和归并排序的区别：

快速排序（Quicksort）是一种高效的排序算法，由 Tony Hoare 在 1960 年提出。
它使用分治法（Divide and Conquer）策略

[将待排序的数组递归地分成两个子数组，然后分别对这两个子数组进行排序，
最终得到整个数组的有序结果]。

算法步骤:
1. 从数组中选择一个元素作为 基准（pivot）。
2. 重新排序数组，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面。
这个过程称为 分区（partition）。
3. 递归地对小于基准值元素的子数组和大于基准值元素的子数组进行排序。

示例:
假设我们有一个数组 [3, 8, 2, 5, 1, 0, 9, 6].
1. 选择第一个元素 3 作为基准。
2. 分区操作后，数组变为 [2, 1, 0, 3, 8, 5, 9, 6].
3. 递归地对子数组 [2, 1, 0] 和 [8, 5, 9, 6] 进行排序。
4. 最终得到排序后的数组 [0, 1, 2, 3, 5, 6, 8, 9].

时间复杂度:
* 平均时间复杂度：O(n log n)
* 最坏时间复杂度：O(n^2)
空间复杂度:
* O(log n)
 */

void swap(List<int> array, int i, int j) {
  int temp = array[i];
  array[i] = array[j];
  array[j] = temp;
}

/// 异或 ^
void swap1(int a, int b) {
  print('a == $a, b == $b');
  a = a ^ b;
  print('a == $a, b == $b');
  b = a ^ b;
  print('a == $a, b == $b');
  a = a ^ b;
  print('a == $a, b == $b');
}

/// 将数组划分为两个部分，其中所有元素小于或等于基准元素的放在基准元素的左边，
/// 所有元素大于基准元素的放在基准元素的右边.
int partition(List<int> array, int low, int high) {
  int pivot = array[high];
  int i = (low - 1);
  ///  0, 1, 2, 3, 4, 5, 6
  /// [8, 7, 2, 1, 0, 9, 6]
  for (int j = low; j < high; j++) {
    print('j == $j; i == $i; a[j] == ${array[j]}');
    if (array[j] <= pivot) {
      i++;
      swap(array, i, j);
    }
    print('ar == $array');
  }
  print('arr = $array');
  swap(array, i + 1, high);
  print('arr 1 = $array');
  return (i + 1);
}

void quickSort1(List<int> array, int low, int high) {
  if (low < high) {
    int pi = partition(array, low, high);

    // int pivot = array[high];
    // int i = (low - 1);
    // ///  0, 1, 2, 3, 4, 5, 6
    // /// [8, 7, 2, 1, 0, 9, 6]
    // for (int j = low; j < high; j++) {
    //   if (array[j] <= pivot) {
    //     i++;
    //     swap(array, i, j);
    //   }
    //   // print('pivot == $pivot, i == $i, j==$j  ar == $array');
    // }
    //
    // swap(array, i + 1, high);
    //
    // int pi = i+1;

    quickSort1(array, low, pi - 1);
    quickSort1(array, pi + 1, high);
  }
}

void main() {
  // 创建一个待排序的列表
  List<int> list = [8, 7, 2, 1, 0, 9, 6];

  // 使用快速排序对列表进行排序
  quickSort1(list, 0, list.length - 1);

  // 打印排序后的列表
  print('list == $list');// list == [0, 1, 2, 6, 7, 8, 9]

  // swap1(10, 12);
}

/// 以下是 一个 run failed Code
void quickSort(List<int> list) {
  // 递归终止条件
  if (list.length <= 1) {
    return;
  }

  // 选择基准元素
  int ind = list.length ~/ 2;
  // print('list len = ${list.length} ind == $ind');
  int pivot = list[list.length ~/ 2];

  // 将列表分割成两部分
  List<int> smaller = [];
  List<int> larger = [];
  for (int element in list) {
    if (element <= pivot) {
      smaller.add(element);
    } else {
      larger.add(element);
    }
  }

  // 递归地对两部分进行排序
  quickSort(smaller);
  quickSort(larger);

  // 将排序后的两部分合并
  list.clear();
  list.addAll(smaller);
  list.add(pivot);
  list.addAll(larger);
}

/*
快速排序（Quick Sort）和归并排序（Merge Sort）是两种常见的排序算法，它们有几个重要的区别：

分治策略：

快速排序：快速排序使用分治法，它通过选择一个基准元素，将数组分割为两个子数组，一个子数组中的元素均小于基准，另一个子数组中的元素均大于基准，然后递归地对子数组进行排序。
归并排序：归并排序也使用分治法，但是它将数组一分为二，分别对两个子数组进行排序，然后再将排好序的子数组合并起来。
稳定性：

快速排序：快速排序是不稳定的排序算法，相等元素的相对位置在排序后可能会改变。
归并排序：归并排序是稳定的排序算法，相等元素的相对位置在排序后不会改变。
时间复杂度：

快速排序：在平均情况下，快速排序的时间复杂度为 O(n log n)。但是在最坏情况下（如已排序数组），快速排序的时间复杂度为 O(n^2)。
归并排序：归并排序的时间复杂度始终稳定在 O(n log n)，无论是在最好情况、最坏情况还是平均情况下。
空间复杂度：

快速排序：快速排序通常是原地排序，它不需要额外的存储空间，因此空间复杂度是 O(1)。
归并排序：归并排序需要额外的存储空间来存储临时数组，在归并阶段时需要 O(n) 的额外空间，因此空间复杂度是 O(n)。
虽然归并排序在时间复杂度上比快速排序更稳定，但是由于其需要额外的存储空间，因此在实际应用中，根据数据规模、数据特点和性能需求等因素来选择适当的排序算法。

 */