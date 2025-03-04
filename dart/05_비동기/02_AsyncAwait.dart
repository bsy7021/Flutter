Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 2), () {
    throw '강제 예외 발생';
    return '결과 데이터';
  });
}

void fetchDataAwait() async {
  try {
    String result = await fetchData();
    print(result);
  } catch (e) {
    print(e);
  }
}

void main(List<String> args) {
  // then(data)
  // : Future 가 완료된 후, 반환값 data 를 가져와서,
  //   특정 작업을 수행하는 메소드
  fetchData().then((data) {
    print(data);
    print('추가 작업...');
  }).catchError((err) {
    print(err);
  });

  fetchDataAwait();
  print('요청 중...');
}
