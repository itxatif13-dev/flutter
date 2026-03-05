
void main() {

  var fruits = {'apple', 'banana', 'orange'};
  print('Initial set: $fruits');

  fruits.add('mango');
  fruits.add('apple');
  print('After adding mango and apple: $fruits');

  fruits.remove('banana');
  print('After removing banana: $fruits');

  if (fruits.contains('apple')) {
    print('Apple is in the set.');
  }

  var setA = {1, 2, 3, 4};
  var setB = {3, 4, 5, 6};

  print('\nSet A: $setA');
  print('Set B: $setB');

  print('Union (A ∪ B): ${setA.union(setB)}');

  print('Intersection (A ∩ B): ${setA.intersection(setB)}');

  print('Difference (A - B): ${setA.difference(setB)}');
}
