void main() {
  // 1. Creating a List
  var fruits = ['apple', 'banana', 'cherry'];
  print('Initial list: $fruits');

  // 2. Adding elements
  fruits.add('date');
  fruits.addAll(['elderberry', 'fig']);
  print('After adding elements: $fruits');

  // 3. Accessing elements
  print('First element: ${fruits[0]}');
  print('Last element: ${fruits.last}');
  print('Element at index 2: ${fruits.elementAt(2)}');

  // 4. List Properties
  print('Length: ${fruits.length}');
  print('Is empty: ${fruits.isEmpty}');
  print('Is not empty: ${fruits.isNotEmpty}');

}
