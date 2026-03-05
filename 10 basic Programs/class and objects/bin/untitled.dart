void main() {
  Member obj = Member("aatif");
  obj.display();
}

class Member {
  String name;
  Member(this.name);
  void display() {
    print("name: $name");
  }
}


