import 'dart:io';
void main(){
  try{
    int num1=10;
    int num2=0;
    int result=num1 ~/ num2;
  } catch(e) {
    print("some error occured: $e");
  }
}
