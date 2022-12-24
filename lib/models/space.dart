class Space {
  int? id;
  String? name;
  String? imageUrl;
  int? price;
  String? city;
  String? country;
  String? imghead;
  int? rating;

  Space({
    required this.city,
    required this.country,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.imghead,
    required this.rating,
  });
}

var spaceList = [
  Space(
    id: 1,
    name: "ondel Hotel",
    imageUrl: "assets/space1.png",
    price: 20,
    city: "Jakarta",
    country: "Indonesia",
    rating: 5,
    imghead: "assets/tumbnail.png",
  ),
  Space(
    id: 2,
    name: "Staview Resort",
    imageUrl: "assets/space2.png",
    price: 20,
    city: "Bandung",
    country: "Indonesia",
    rating: 1,
    imghead: "assets/tumbnail2.png",
  ),
  Space(
    id: 3,
    name: "GetView Hotel",
    imageUrl: "assets/space3.png",
    price: 20,
    city: "Yogyakarta",
    country: "Indonesia",
    rating: 3,
    imghead: "assets/tumbnail3.png",
  ),
  Space(
    id: 4,
    name: "Oke Resort",
    imageUrl: "assets/space4.png",
    price: 20,
    city: "Semarang",
    country: "Indonesia",
    rating: 4,
    imghead: "assets/tumbnail4.png",
  ),
  Space(
    id: 5,
    name: "Joglo Harmony",
    imageUrl: "assets/space5.png",
    price: 20,
    city: "Jakarta",
    country: "Indonesia",
    rating: 5,
    imghead: "assets/tumbnail5.png",
  ),
];
