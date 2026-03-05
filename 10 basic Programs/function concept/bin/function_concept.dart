int factorial(int n) {
  if (n<=1){
    return 1;
  }else{
    return n*factorial(n-1);
  }
}

void main() {
  int number = 5;
  try {
    print('Factorial of $number is ${factorial(number)}');
  } catch (e) {
    print(e);
  }
}
