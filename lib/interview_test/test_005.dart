/*
快速排序（Quicksort）是一种高效的排序算法，由 Tony Hoare 在 1960 年提出。
它使用分治法（Divide and Conquer）策略，将待排序的数组递归地分成两个子数组，
然后分别对这两个子数组进行排序，最终得到整个数组的有序结果。

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

/// 将数组划分为两个部分，其中所有元素小于或等于基准元素的放在基准元素的左边，
/// 所有元素大于基准元素的放在基准元素的右边.
int partition(List<int> array, int low, int high) {
  int pivot = array[high];
  int i = (low - 1);
  ///  0, 1, 2, 3, 4, 5, 6
  /// [8, 7, 2, 1, 0, 9, 6]
  for (int j = low; j < high; j++) {
    if (array[j] <= pivot) {
      i++;
      swap(array, i, j);
    }
    // print('pivot == $pivot, i == $i, j==$j  ar == $array');
  }

  swap(array, i + 1, high);
  return (i + 1);
}

void quickSort1(List<int> array, int low, int high) {
  if (low < high) {
    int pi = partition(array, low, high);

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
  print('list == $list');
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
