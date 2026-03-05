import 'dart:io';
void main(){
  stdout.write("Enter a number: ");
  int? n=int.parse(stdin.readLineSync()!);
  int m=fact(n);
  print(m);
}
int fact(int n){
  if(n<=1){
    return 1;
  }else{
    return n*fact(n-1);
  }
}