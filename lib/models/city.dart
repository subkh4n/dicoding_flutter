class City {
  int? id;
  String? name;
  String? imageurl;
  bool? isPopular;

  City({
    required this.id,
    required this.imageurl,
    required this.name,
    this.isPopular = false,
  });
}

var cityList = [
  City(
    id: 1,
    name: "Jakarta",
    imageurl: "assets/city1.png",
    isPopular: false,
  ),
  City(
    id: 2,
    name: "Bandung",
    imageurl: "assets/city2.png",
    isPopular: false,
  ),
  City(
    id: 3,
    name: "Yogyakarta",
    imageurl: "assets/city3.png",
    isPopular: true,
  ),
  City(
    id: 4,
    name: "Semarang",
    imageurl: "assets/city4.png",
    isPopular: false,
  ),
  City(
    id: 5,
    name: "surabaya",
    imageurl: "assets/city5.png",
    isPopular: false,
  ),
];
