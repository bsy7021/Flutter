// 상품 객체
class Product{
  String? image;
  String? title;
  String? decription;

  // 생성자
  Product(
    // required : 객체 생성 시, 필수로 전달해야하는 값으로 지정
    {
      required this.image,
      required this.title,
      required this.decription
    }
  );
}