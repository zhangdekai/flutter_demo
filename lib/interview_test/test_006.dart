
/*

The Problem:
Given an array of nums, write a function to move all 0’s to the end of it
while maintaining the relative order of the non-zero elements.

Example:
Input: [0,1,0,3,12]
Output: [1,3,12,0,0]

 */


List<int> moveZero(List<int> list){
  int len = list.length;
  Map<int,int> temp = {};

  for(int i = 0; i< list.length; i++){
    if(list[i] == 0){
      temp[i] = list[i];
    }
  }





  return [];
}

void main(){

}