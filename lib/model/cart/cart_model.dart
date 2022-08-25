class CartModel {
  String? id;
  String? name;
  int? quantity;
  String? imageUrl;
  double? price;

  CartModel({
    required this.id,
    required this.name,
    required this.quantity,
    this.imageUrl = "https://img.freepik.com/free-photo/palm-tree-house-plant-pot_53876-125837.jpg?w=740&t=st=1661167877~exp=1661168477~hmac=eb35d5e64db9ecacfc49fe199582d5ca1f729bc093ff51af6d479b175fdca1e7",
    this.price = 200,
  });

  CartModel.fromDB(Map<String, dynamic> db) {
    id = db['product_id'];
    name = db['name'];
    quantity = db['quantity'];
    imageUrl = db['image_url'];
    price = 200.0;
  }
}
