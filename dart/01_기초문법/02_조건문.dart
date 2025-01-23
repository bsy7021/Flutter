void main(List<String> args) {
  int number = 100;
  if (number > 0) {
    print("양수 입니다.");
  } else if (number < 0) {
    print("음수 입니다.");
  } else {
    print("0 입니다.");
  }

  String grade = "A";
  // switch
  // Dart 에선느 break를 쓰지 않아도 해당 case 블록만 실행된다.
  switch (grade) {
    case "A":
      print("A 학점.");
    case "B":
      print("B 학점.");
    case "C":
      print("C 학점.");
    default:
      print("유효하지 않습니다.");
  }
}
