void main(){
//there are no directly any array in dart officially. list can work as array in it.
  List<int> numbers=[1,2,3,4,5,6,7,8,9,10];
  int sum=0;

  for(int i=0;i<numbers.length;i++){
    if(numbers[i]%2==0){
      print("${numbers[i]} is even");
    }else{
      print("${numbers[i]} is odd");
    }
  }
}
