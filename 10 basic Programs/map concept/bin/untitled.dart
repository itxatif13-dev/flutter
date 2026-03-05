void main() {
  Map<String, dynamic> user = {
    'name': 'atif',
    'age': 21,
    'isStudent': true,
  };
  print('Name: ${user['name']}');
  user['email'] = 'atif@gmail.com';
  user['age'] = 26;
  user.remove('isStudent');
  user.forEach((key, value) {
    print('$key: $value');
  });
  print('Keys: ${user.keys}');
  print('Values: ${user.values}');
}
