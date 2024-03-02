/*
归并排序是一种稳定的排序算法，它基于分治法（Divide and Conquer）的思想，
将待排序的数组递归地分成两半，然后对这两半进行排序，最后将排序好的两半合并起来。

算法步骤

将待排序的数组分成左右两半。
对左右两半进行递归排序。
将排序好的左右两半合并起来。

时间复杂度

归并排序的时间复杂度为 O(n log n)，其中 n 是数组的长度。

空间复杂度

归并排序的空间复杂度为 O(n)，因为需要使用额外的空间来存储左右两半数组。

稳定性

归并排序是一种稳定的排序算法，即相同元素在排序前后的相对位置不变。

应用场景

归并排序是一种通用排序算法，可以用于排序各种类型的数据。它常用于需要稳定排序的场景，例如对包含重复元素的数组进行排序。

优缺点

优点

归并排序是一种稳定的排序算法。
归并排序的时间复杂度为 O(n log n)，是比较高效的排序算法之一。
缺点

归并排序的空间复杂度为 O(n)，需要使用额外的空间来存储左右两半数组。
归并排序的递归实现可能会导致栈溢出问题。


 */

void mergeSort(List<int> list) {
  if (list.length <= 1) {
    return;
  }

  int mid = list.length ~/ 2;
  List<int> left = list.sublist(0, mid);
  List<int> right = list.sublist(mid);

  // 对左右两半进行排序
  mergeSort(left);
  mergeSort(right);

  // 合并左右两半
  merge(list, left, right);
}

void merge(List<int> list, List<int> left, List<int> right) {
  int i = 0, j = 0, k = 0;

  while (i < left.length && j < right.length) {
    if (left[i] <= right[j]) {
      list[k++] = left[i++];
    } else {
      list[k++] = right[j++];
    }
  }

  while (i < left.length) {
    // 复制剩余元素
    list[k++] = left[i++];
  }

  while (j < right.length) {
    // 复制剩余元素
    list[k++] = right[j++];
  }
}

void main() {
  // 创建一个待排序的列表
  List<int> list = [8, 7, 2, 1, 0, 9, 6];

  // 使用快速排序对列表进行排序
  mergeSort(list);

  // 打印排序后的列表
  print('list == $list'); // list == [0, 1, 2, 6, 7, 8, 9]

  // swap1(10, 12);
}
